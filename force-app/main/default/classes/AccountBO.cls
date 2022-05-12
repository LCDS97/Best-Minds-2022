public with sharing class AccountBO {

    public class CampoVazioException extends Exception {}
    public class ContaInativaException extends Exception{}
    public class SemDadosBancariosNuloException extends Exception{}
    public class SemContatosException extends Exception{}
    public class CasoNaoCriadoException extends Exception{}

    
    public static void somenteAtivarContaComDadosBancarios(List<Account> lstTriggersAccount, Map<Id, Account> mapOldAccount){
        List<Account> lstContasAtivadasAgora = new List<Account>();
        Set<Id> setIdsContasAtivadas = new Set<Id>();
        Map<Id, List<DadosBancarios__c>> mapDadosPorConta = new Map<Id, List<DadosBancarios__c>>();

        for(Account contaNova : lstTriggersAccount){
            Account contaAntiga = mapOldAccount.get(ContaNova.Id);

            // Filtrando para verificar os map se houve alteração do valor de Ativo para acionar Trigger
            if(!contaAntiga.Ativo__c && contaNova.Ativo__c){
                lstContasAtivadasAgora.add(contaNova);
            }
        }
        
        // Caso nenhuma conta esta em Trigger.new, ele sai do código
        if(lstContasAtivadasAgora.isEmpty()){
            return;
        }
    
        // Percorrendo a lista de Contas Atividas e adicionando eles na lista de Set Id
        for(Account contaAtivada : lstContasAtivadasAgora){
            setIdsContasAtivadas.add(contaAtivada.Id);
        }
    
        // Pegando as contas ativas dentro da lista de Set que possui Dados Bancários
        List<DadosBancarios__c> lstDadosBancarios = DadosBancariosDAO.pegarContasPorDadoBancarios(setIdsContasAtivadas);
        
        // Verificando se existe Dados Bancários
        for(DadosBancarios__c db: lstDadosBancarios){
            // Caso não tenha, é criado uma chave para o item atual com seu Id de Conta e uma Lista de Dados Bancários Vazia
            if(!mapDadosPorConta.containsKey(db.Conta__c)){
                mapDadosPorConta.put(db.Conta__c, new List<DadosBancarios__c>());
            }
            // Caso ele possua um dado bancários, pegamos o valor ja referenciado la e adiciona a lista com seus dados bancários
            mapDadosPorConta.get(db.Conta__c).add(db);
        }
        
        // Verificando se o usuário tentar adicionar uma conta sem Dados Bancários ira fazer a validação, pois o mesmo não esta presente no Map significa que ele não possui dado bancário
        for(Account contaAtivada : lstContasAtivadasAgora){
            if(!mapDadosPorConta.containsKey(contaAtivada.Id)){
                contaAtivada.addError('Você não pode ativar uma conta que não possui dado bancário, por favor insira uma!');
            } else {
                // Para setar por padrão após ser ativado, automaticamente muda para o Rating de Prata
                contaAtivada.Rating = 'Prata';
            }
        }
    }

    public static void criarOportunidadePadraoParaConta(List<Account> lstContasTrigger){
        Map<Id, Boolean> mapDevoCriarOpp = new Map<Id,Boolean>();
        List<Opportunity> lstOppDevoCriar = new List<Opportunity>();

        for(Account conta : lstContasTrigger){
            mapDevoCriarOpp.put(conta.Id, true);
        }

        List<Opportunity> lstOpp = OpportunityDAO.recuperarOportunidadesPorIdConta(mapDevoCriarOpp.keySet());

        for(Opportunity opp : lstOpp){
            mapDevoCriarOpp.put(opp.AccountId, false);
        }

        for(Account conta : lstContasTrigger){
            Boolean devoCriar = mapDevoCriarOpp.get(conta.Id);

            if(devoCriar){
                Opportunity opp = new Opportunity();
                opp.AccountId = conta.Id;
                opp.Name = conta.Name + ' - Oportunidade nova';
                opp.StageName = 'Prospecting';
                opp.CloseDate = date.today().addMonths(1);
                lstOppDevoCriar.add(opp);
            }
            
        }
        insert lstOppDevoCriar;
    }

    public static void clientePJAtualizarCampo(Id idAccount){
        Account clientePj = AccountDAO.buscarContaAtivoPorID(idAccount);
            
            if (clientePj.Ativo__c){
                clientePj.Ativo__c = false;
            }
    
        update clientePj;
    }

    public static Boolean contatoClientePJ(
        Id clientePJ,
        String nomeContato,
        String sobrenomeContato,
        String cargoContato,
        String dataNascimentoContato,
        String emailContato)
    {
        Boolean contactWasCreated;

        try {

            if (
                String.IsBlank(clientePJ) == false &&
                String.isBlank(nomeContato) == false &&
                String.isBlank(sobrenomeContato) == false &&
                String.isBlank(cargoContato) == false &&
                String.isBlank(dataNascimentoContato) == false &&
                String.isBlank(emailContato) == false )
            {
                
                Contact novoContato = new Contact();
                Date dataConvertida = Date.valueOf(dataNascimentoContato);
                novoContato.AccountId = clientePJ;
                novoContato.FirstName = nomeContato;
                novoContato.LastName = sobrenomeContato;
                novoContato.Title = cargoContato;
                novoContato.BirthDate = dataConvertida;
                novoContato.Email = emailContato;
                contactWasCreated = true;

                insert novoContato;
            
            }
                else{
                    throw new CampoVazioException('Preencher todos os campos por favor!!');

                }

            }
        catch (CampoVazioException e) {
            contactWasCreated = false;
            System.debug('### Exception Personalizado => ' + e.getMessage());
        }
    
        catch(Exception e){
            contactWasCreated = false;
            System.debug('### Exception Padrão => ' + e.getMessage());
        }
            return contactWasCreated;    
    }
    
    public static List<Account> buscarSetorClientePJ(String nomeSetor){
        String nomeSetorString = '%' + nomeSetor + '%';

        List<Account> buscarContasClientePj = AccountDAO.buscarContasSetor(nomeSetorString);

        for(Account conta : buscarContasClientePj){
            System.debug('Nome da conta é ' + conta.Name + ' e o Setor da conta é ' + conta.Industry);
        }

        return buscarContasClientePj;
    }

    public static void ClientePJValidacoes(Id idContaPJ){

        Account verificarContaPJ = AccountDAO.buscarValidacoesContaPJ(idContaPJ);

        try {
            if(!verificarContaPJ.Ativo__c){
                    throw new ContaInativaException('Não é possível realizar operações com uma conta Inativa');
                }
            
            if(
                String.isBlank(verificarContaPJ.RazaoSocial__c) ||
                String.isBlank(verificarContaPJ.CNPJ__c) ||
                String.isBlank(verificarContaPJ.Type)){
                    throw new CampoVazioException('Os campos CNPJ e Razão Social e Tipo devem ser preenchidos');
                }
            
            System.debug('Todos os campos preenchidos');
            
           
        } catch (ContaInativaException error) {
            System.debug('### Exception ContaInativa: ' + error.getMessage());

        } catch (CampoVazioException error) {
            System.debug('### Exception CampoVazio: ' + error.getMessage());

        } catch (Exception error) {
            System.debug('### Exception Padrão: ' + error.getMessage());
        }
    }

    public static void criarOportunidadeClientePJ(Id idAccount){
        List <DadosBancarios__c> dadosBancariosClientePJ = DadosBancariosDAO.pegarContaPorDadoBancarios(idAccount);
        List <Contact> contatosClientePJ = ContactDAO.buscarContatosPorIdConta(idAccount);

        try {
            if(dadosBancariosClientePJ.isEmpty()){
                throw new SemDadosBancariosNuloException('É Necessário ter pelo menos um Dado Bancário cadastrado na Conta!');
            }
            if(contatosClientePJ.isEmpty()){
                throw new SemContatosException('É necessário a conta ter pelo menos um contato cadastrado!');
            }
            Opportunity novaOportunidadeClientePJ = new Opportunity();
            Account nomeOportunidade = AccountDAO.buscarContaPorId(idAccount);
            
            novaOportunidadeClientePJ.AccountId = idAccount;
            novaOportunidadeClientePJ.Name = 'Oportunidade da Conta ' + nomeOportunidade.Name;
            novaOportunidadeClientePJ.StageName = 'Prospecting';
            novaOportunidadeClientePJ.CloseDate = date.today().addMonths(2);

            insert novaOportunidadeClientePJ;

        } catch (SemDadosBancariosNuloException error) {
            System.debug('### SemDadosBancariosNuloException => ' + error.getMessage());
        } catch (SemContatosException error) {
            System.debug('### SemContatosException => ' + error.getMessage());
        } catch (Exception error) {
            System.debug('### Exception Padrão => ' + error.getMessage());   
        }
    }

    public static void criarCasoClientePJ(Id idAccount){
        Account verificarContaPJ = AccountDAO.buscarContaPorId(idAccount);
        List <Contact> contatosClientePJ = ContactDAO.buscarContatosPorIdConta(idAccount);

        try {
            if(!verificarContaPJ.Ativo__c){
                throw new ContaInativaException('É Necessário a Conta estar ativa para criar o caso!');
            }
            if(contatosClientePJ.isEmpty()){
                throw new SemContatosException('É necessário a conta ter pelo menos um contato cadastrado!');
            }

            Boolean resultadoCaso = CaseBO.casoCriado(idAccount,verificarContaPJ.Name);
            if(!resultadoCaso){
                throw new CasoNaoCriadoException('Ocorreu um erro, seu caso não foi criado');
            }
            System.debug('Seu caso foi criado');

        } catch (ContaInativaException error) {
            System.debug('### ContaInativaException => ' + error.getMessage());
        } catch (SemContatosException error) {
            System.debug('### SemContatosException => ' + error.getMessage());
        } catch (CasoNaoCriadoException error) {
            System.debug('### CasoNaoCriadoException => ' + error.getMessage());
        } catch (Exception error) {
            System.debug('### Exception Padrão => ' + error.getMessage());   
        }
    }

    public static void alterarDominioEmail(List<Account> lstTriggersAccount,Map<Id, Account> mapNewAccount,  Map<Id, Account> mapOldAccount){
        
        Set<Id> setIdContas = new Set<Id>();
        List<Account> lstContasAlterarEmail = new List<Account>();
        List<Contact> lstContatosAtualizarEmail = new List<Contact>();

        for(Account conta : lstTriggersAccount){
            Account contaAntiga = mapOldAccount.get(conta.Id);
            
            if(contaAntiga.Dominio__c != conta.Dominio__c){
                
                setIdContas.add(conta.Id);
                lstContasAlterarEmail.add(conta);
            }
        }

        if(lstContasAlterarEmail.isEmpty()) return;

        List<Account> lstContasComDominio = AccountDAO.buscarContasComContatosComEmail(setIdContas);

        for(Account conta : lstContasComDominio){


            for(Contact contato : conta.Contacts){

                if(String.isNotBlank(contato.Email)){
                    Integer indiceArroba = contato.Email.indexOf('@');
                    String inicioEmail = contato.Email.mid(0, indiceArroba);
                    String dominioEmail = conta.Dominio__c;
                    String montarEmail = inicioEmail + '@' + dominioEmail;
                    contato.Email = montarEmail;
                    lstContatosAtualizarEmail.add(contato);
                }
            }
        }

        update lstContatosAtualizarEmail;
        


    }




    

}

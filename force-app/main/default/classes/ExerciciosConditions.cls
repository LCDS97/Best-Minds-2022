public with sharing class ExerciciosConditions {
    
    public class ContaInativaException extends Exception{}
    public class CampoVazioException extends Exception{}
    public class DataVencimentoVazioException extends Exception{}
    public class SemDadosBancariosNuloException extends Exception{}
    public class SemContatosException extends Exception{}

    /*  1 - Criar um método que receba o Id de uma parcela como paramêtro e retorne o valor desta parcela adicionando um percentual
        As condições devem ser:
        1. Parcela fora da validade (10%) *0,10 > data de hoje
        2. Parcelas antes da validade (-5%)* 0,95 - 27 < data de hoje
        3. Parcela na validade (0%)
     */
    public static Decimal verificarParcela(Id IdParcela){
        Parcela__c pegarParcela = [SELECT Id, DataVencimento__c, Moeda__c FROM Parcela__c WHERE Id =: idParcela];
        Date dataHoje = Date.Today();
        Decimal valorParcelaAlterado = 0;

        try {
            Integer verificarVencimento = dataHoje.daysBetween(pegarParcela.DataVencimento__c);
            
            if( verificarVencimento > 0){
                valorParcelaAlterado = pegarParcela.Moeda__c - (pegarParcela.Moeda__c * 0.05);
        }   else if (verificarVencimento < 0 ){
                valorParcelaAlterado = pegarParcela.Moeda__c + (pegarParcela.Moeda__c * 0.1);
            
        }   else if(verificarVencimento == 0){
                valorParcelaAlterado = pegarParcela.Moeda__c;
                System.debug('Sem desconto pois é o dia do Vencimento');
        }   else {
                throw new DataVencimentoVazioException('Valor do campo Date está Nulo');
            } 
        } catch (DataVencimentoVazioException error) {
            System.debug('###Erro DataVencimentoException => :' + error.getMessage());
        } catch (NullPointerException error) {
            System.debug('###Erro Argumento Nulo => :' + error.getMessage());
        } catch(Exception error) {
            System.debug('###Erro Exception Padrão' + error.getMessage());
        }
        pegarParcela.Moeda__c = valorParcelaAlterado;
        update pegarParcela;
        return valorParcelaAlterado;
    }
    
    // 2 - Criar um método que receba o Id de um Cliente PJ e faça as seguintes ações:

    /*  Regras: 
    1. Se o cliente PJ estiver inativo, deve ser lançada uma exceção informando que não é possível
    2. Se algum dos campos do Cliente PJ estiverem vazios, é necessário lançar uma exceção indicando que todos os campos devem ser preenchidos
    */
    public static void ClientePJValidacoes(Id idContaPJ){
        Account verificarContaPJ = [SELECT Id, Ativo__c, Type, RazaoSocial__c, CNPJ__c From Account WHERE Id =: idContaPJ];
        try {
            If (!verificarContaPJ.Ativo__c){
                throw new ContaInativaException('Não é possível realizar operações com uma conta Inativa');
            }
            If
            (
                String.isBlank(verificarContaPJ.RazaoSocial__c) ||
                String.isBlank(verificarContaPJ.CNPJ__c) ||
                String.isBlank(verificarContaPJ.Type))
                {
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
    /* 3 - Criar um método que receba o Id de um Cliente PJ e faça as segiuntes ações:
        1. Se o Cliente PJ não tiver nenhum Dado Bancário cadastrado no sistema, é necessário lançar uma exceção
            indicando a falta de registro de Dados Bancários.
        2. Se o Cliente PJ não tiver nenhum Contato cadastrado é necessário lançar uma exceção indicando a falta de registros Contato para a Conta.
        3. Criar uma Oportunidade para o Cliente PJ caso nenhum dos tópicos anteriores for verdadeiro
    */
    public static void criarOportunidadeClientePJ(Id IdAccount){
        List <DadosBancarios__c> dadosBancariosClientePJ = [SELECT Id, Conta__c, Conta__r.Name FROM DadosBancarios__c WHERE Conta__c	 =: IdAccount];
        List <Contact> contatosClientePJ = [SELECT Id FROM Contact WHERE AccountId =: IdAccount];

        try {
            if(dadosBancariosClientePJ.isEmpty()){
                throw new SemDadosBancariosNuloException('É Necessário ter pelo menos um Dado Bancário cadastrado na Conta!');
            }
            if(contatosClientePJ.isEmpty()){
                throw new SemContatosException('É necessário a conta ter pelo menos um contato cadastrado!');
            }
            Opportunity novaOportunidadeClientePJ = new Opportunity();
            Account nomeOportunidade = [SELECT Id, Name FROM Account WHERE Id =: IdAccount ];
            
            //Date dataFechamentoOportunidade = date.today().addMonths(1);
            novaOportunidadeClientePJ.AccountId = IdAccount;
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
    /* 4 - Criar um método que receba o Id de um Cliente PJ e cria um Caso ( Sinistro ) com as seguintes condições:
        1. Se o cliente estiver inativo é necessário lançar uma exceção que indicando que o cliente deve estar ativo para criar um caso
        2. Se o cliente não tiver nenhum contato associado é necessário lançar uma excessão indicando a necessidade de um contato para o Caso
        3. Se nenhuma das condições acima ocorrerem, é necessário criar um caso para o Cliente com o assunto
            Sendo o nome do Cliente, concatenado com a palavra Sinistro, Ex:
            Cliente Teste - Sinistro 
    */

    /* 5 - Para o exercício anterior, faça a criação do caso em um método separado, ou seja, ao invés de criar o caso diretamente no método anterior
            Deve se chamar um novo método para a criação do caso.
    */
    private static Boolean casoCriado(Id IdAccount, String nomeConta){
        Boolean casoCriado = false;

        try {
            Case novoCaso = new Case();
            novoCaso.AccountId = IdAccount;
            novoCaso.Status = 'New';
            novoCaso.Origin = 'Apex';
            novoCaso.Subject = 'Cliente ' + nomeConta + ' - Sinistro';
            casoCriado = true;
            insert novoCaso;
            
            
        } catch (Exception error) {
            System.Debug('### Exception padrão: ' + error);
        }
        System.debug(casoCriado);
        return casoCriado;

    }

    
}

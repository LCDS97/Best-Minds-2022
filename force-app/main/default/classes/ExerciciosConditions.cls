public with sharing class ExerciciosConditions {
    
    public class ContaInativaException extends Exception{}
    //public class CampoVazioException extends Exception{}
    public class DataVencimentoVazioException extends Exception{}
    public class SemDadosBancariosNuloException extends Exception{}
    public class SemContatosException extends Exception{}
    public class CasoNaoCriadoException extends Exception{}


    
    // 2 - Criar um método que receba o Id de um Cliente PJ e faça as seguintes ações:

    /*  Regras: 
    1. Se o cliente PJ estiver inativo, deve ser lançada uma exceção informando que não é possível
    2. Se algum dos campos do Cliente PJ estiverem vazios, é necessário lançar uma exceção indicando que todos os campos devem ser preenchidos
    */

    /* 3 - Criar um método que receba o Id de um Cliente PJ e faça as segiuntes ações:
        1. Se o Cliente PJ não tiver nenhum Dado Bancário cadastrado no sistema, é necessário lançar uma exceção
            indicando a falta de registro de Dados Bancários.
        2. Se o Cliente PJ não tiver nenhum Contato cadastrado é necessário lançar uma exceção indicando a falta de registros Contato para a Conta.
        3. Criar uma Oportunidade para o Cliente PJ caso nenhum dos tópicos anteriores for verdadeiro
    */

    /* 4 - Criar um método que receba o Id de um Cliente PJ e cria um Caso ( Sinistro ) com as seguintes condições:
    1. Se o cliente estiver inativo é necessário lançar uma exceção que indicando que o cliente deve estar ativo para criar um caso
    2. Se o cliente não tiver nenhum contato associado é necessário lançar uma excessão indicando a necessidade de um contato para o Caso
    3. Se nenhuma das condições acima ocorrerem, é necessário criar um caso para o Cliente com o assunto
    Sendo o nome do Cliente, concatenado com a palavra Sinistro, Ex:
    Cliente Teste - Sinistro 
    */
    public static void criarCasoClientePJ(Id IdAccount){
        Account verificarContaPJ = [SELECT Id, Ativo__c, Name From Account WHERE Id =: IdAccount];
        List <Contact> contatosClientePJ = [SELECT Id FROM Contact WHERE AccountId =: IdAccount];

        try {
            if(!verificarContaPJ.Ativo__c){
                throw new ContaInativaException('É Necessário a Conta estar ativa para criar o caso!');
            }
            if(contatosClientePJ.isEmpty()){
                throw new SemContatosException('É necessário a conta ter pelo menos um contato cadastrado!');
            }

            Boolean resultadoCaso = casoCriado(IdAccount,verificarContaPJ.Name);
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
            novoCaso.Type = 'Sinistro';
            novoCaso.Subject = 'Cliente ' + nomeConta + ' - Sinistro';
            casoCriado = true;
            insert novoCaso;
               
        } catch (Exception error) {
            System.Debug('### Exception padrão: ' + error);
        }
        return casoCriado;

    }

    
}

public with sharing class ExerciciosConditions {
    
    public class ContaInativaException extends Exception{}
    public class CampoVazioException extends Exception{}
    public class DataVencimentoVazioException extends Exception{}

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

        Integer verificarVencimento = dataHoje.daysBetween(pegarParcela.DataVencimento__c);
        try {
            
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
    }   catch (Exception error) {
        System.debug('### Exception Padrão: ' + error.getMessage());
    } 
    }



    
}

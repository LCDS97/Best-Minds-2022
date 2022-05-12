public with sharing class TreinamentoController {
    @AuraEnabled
    public static String setValue(String valor){

        String retorno = '';

        try {
            if(String.isNotBlank(valor)){
                retorno = 'Valor inserido: ' + valor;
            }
            else{
                retorno = 'Valor inserido nulo';
            }
        } catch (Exception e) {
            retorno = e.getMessage();
        }

        return retorno;
    }

    @AuraEnabled
    public static string getAccount(String Id){
        String nomeConta = '';

        try {
            nomeConta = [SELECT Id, Name FROM Account WHERE Id = :id].Name;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return nomeConta;
    }

    @AuraEnabled
    public static Boolean updateAccount(String Id, String nomeAtualizado){
        try {
            Account objAccount = [SELECT Id FROM Account WHERE Id =: Id];
            objAccount.Name = nomeAtualizado;

            update objAccount;
            return true;
        } catch (Exception e) {
            //throw new AuraHandledException(e.getMessage());
            return false;
        }
    }
}

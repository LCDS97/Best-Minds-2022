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
}

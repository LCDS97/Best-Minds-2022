public with sharing class ControllerListarDadosBancarios {
    
    @AuraEnabled
    public static List<DadosBancariosBO.DadoBancarioTO> buscarDadosBancarios(Id idConta){
        return DadosBancariosBO.buscarDadosBancarios(idConta);
    }
}

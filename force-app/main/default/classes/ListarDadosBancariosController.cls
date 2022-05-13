public with sharing class ListarDadosBancariosController {
    
    @AuraEnabled
    public static List<DadosBancariosBO.DadoBancarioTO> buscarDadosBancarios(Id idConta){
        return DadosBancariosBO.buscarDadosBancarios(idConta);
    }
}

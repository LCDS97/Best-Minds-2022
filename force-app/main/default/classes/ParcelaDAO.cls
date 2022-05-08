public with sharing class ParcelaDAO {
    public static List<Parcela__c> buscarParcelasIdContrato(Id idContrato){
        return [
            SELECT Id FROM Parcela__c WHERE Contrato__c =: idContrato
        ];
    }

    public static List<Parcela__c> retornarParcelasVencidas(){
        List<Parcela__c> listaVencidas = [SELECT Id, DataVencimento__c FROM Parcela__c WHERE Status__c = 'Atrasada'];
    
        return listaVencidas;
    }

}

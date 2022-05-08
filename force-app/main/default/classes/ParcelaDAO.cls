public with sharing class ParcelaDAO {
    public static List<Parcela__c> buscarParcelasIdContrato(Set<Id> idContrato){
        return [
            SELECT Id FROM Parcela__c WHERE Contrato__c =: idContrato
        ];
    }
}

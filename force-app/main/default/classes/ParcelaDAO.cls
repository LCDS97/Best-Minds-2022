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

    public static List<Parcela__c> retornarParcelasMaiorQueValorDesejado(Integer filtrarValor){
        return [
            SELECT Id, Name, Moeda__c, Contrato__c, Contrato__r.Account.Name FROM Parcela__c WHERE Moeda__c > :filtrarValor
        ];
    }

    public static List<Parcela__c> retornarIdContratoValorNome(Id idContrato){
        return [
            SELECT Id, Contrato__c, Moeda__c, Contrato__r.Account.Name FROM Parcela__c WHERE Contrato__c = :idContrato
        ];
    }

}

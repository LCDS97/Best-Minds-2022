public with sharing class AccountDAO {
    
    public static List<Account> buscarContasPorId(Set<Id> setContasId){
        return [SELECT Id, OwnerId FROM Account WHERE Id IN :setContasId];
    }

    public static List<Account> buscarTodasContasAtivas(Set<Id> idAccount){
        return [SELECT Id, Ativo__c FROM Account WHERE Id =: idAccount];
    }
}

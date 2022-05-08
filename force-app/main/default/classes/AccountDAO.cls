public with sharing class AccountDAO {
    
    public static List<Account> buscarContasPorId(Set<Id> setContasId){
        return [SELECT Id, OwnerId FROM Account WHERE Id IN :setContasId];
    }

    public static Account buscarContaAtivoPorID(Id idAccount){
        return [SELECT Id, Ativo__c FROM Account WHERE Id =: idAccount];
    }
}

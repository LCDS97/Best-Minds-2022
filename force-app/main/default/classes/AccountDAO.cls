public with sharing class AccountDAO {
    
    public static List<Account> buscarContasPorId(Set<Id> setContasId){
        return [SELECT Id, OwnerId FROM Account WHERE Id IN :setContasId];
    }
}

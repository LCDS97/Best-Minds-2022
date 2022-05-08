public with sharing class BonusDAO {
    
    public static List<Bonus__c> retornarBonusPorIdConta(Id idConta){
        return [
            SELECT Id, Name, Conta__c, Conta__r.Name FROM Bonus__c WHERE Conta__c = :idConta
        ];
    }
}

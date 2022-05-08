public with sharing class BonusBO {

    public static List<Bonus__c> retornarBonusPorId(Id idConta){
        List<Bonus__c> bonusPorId = BonusDAO.retornarBonusPorIdConta(idConta);
        
        for(Bonus__c bonus : bonusPorId){
            System.debug('Bônus: ' + bonus.Name + ' da Conta ' + bonus.Conta__r.Name);
        }
        
        return bonusPorId;
        
    }
}

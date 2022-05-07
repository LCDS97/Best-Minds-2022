public with sharing class DadosBancariosDAO {
    
    public static List<DadosBancarios__c> pegarContasPorDadoBancarios(Set<Id> setIdsContasAtivadas){
            return[
				SELECT 	Id,	Conta__c FROM DadosBancarios__c WHERE Conta__c IN  :setIdsContasAtivadas
			];
    }
}

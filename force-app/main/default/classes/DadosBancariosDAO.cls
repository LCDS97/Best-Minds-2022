public with sharing class DadosBancariosDAO {
    
    public static List<DadosBancarios__c> pegarContasPorDadoBancarios(Set<Id> setIdContas){
            return[
				SELECT 	Id,	Conta__c FROM DadosBancarios__c WHERE Conta__c IN  :setIdContas
			];
    }

    public static List<DadosBancarios__c> pegarContasPorIdSomenteAtivos(Set<Id> setIdContasAtivadas){
            return [
                SELECT Id, Conta__c, Ativo__c FROM DadosBancarios__c WHERE Conta__c IN :setIdContasAtivadas AND Ativo__c = true
            ];
                                
    }

    public static List<DadosBancarios__c> pegarContasAtivosPorId(Set<Id> setIdContas){
            return [
                SELECT Id, Conta__c, Ativo__c FROM DadosBancarios__c WHERE Conta__c IN :setIdContas
            ];
    }
}
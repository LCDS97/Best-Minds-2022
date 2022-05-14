public class BatchAtualizarSalarios implements Database.Batchable<SObject>{


        public Database.QueryLocator start(Database.BatchableContext bc){
            return Database.getQueryLocator([SELECT  Id, AnnualRevenue, Name, ( SELECT Id, SalarioAnual__c, SalarioMensal__c FROM Contacts ) FROM Account WHERE AnnualRevenue > 1000000]);
        }

        public void execute(Database.BatchableContext bc, List<Account> lstContas){
            
            AccountBO.atribuirAnnualRevenue();
            ContactBO.DistribuirAltoFaturamento(lstContas);
        }

        public void finish(Database.BatchableContext bc){

        }




}
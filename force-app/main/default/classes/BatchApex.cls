public class BatchApex implements Database.Batchable<SObject>, Database.Stateful{

    public Integer casosProcessados = 0;
    public Database.QueryLocator start(Database.BatchableContext bc ){
        return Database.getQueryLocator([SELECT Id, ContactId FROM Case WHERE ContactId = null]);
    }

    public void execute(Database.BatchableContext bc, List<Case> lstCasos){

        List<Case> lstCasosParaFechar = new List<Case>();

        for(Case caso : lstCasos){
            caso.Status = 'Closed';
            lstCasosParaFechar.add(caso);
            casosProcessados += 1;
        }
        update lstCasosParaFechar;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Casos processados foi: ' + casosProcessados);

    }
}
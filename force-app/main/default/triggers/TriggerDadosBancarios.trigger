trigger TriggerDadosBancarios on DadosBancarios__c (after insert) {

    if(Trigger.isAfter){

        if(Trigger.isInsert){
            DadosBancariosBO.somenteUmDadoBancarioAtivo(Trigger.new);
        }

    }
}
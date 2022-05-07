trigger TriggerOpportunity on Opportunity (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityBO.atrelarUnicoContato(Trigger.new);
        }
    }

}
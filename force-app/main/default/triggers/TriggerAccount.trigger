trigger TriggerAccount on Account (after update) {

    if(trigger.isAfter){
        if(Trigger.isUpdate){
            AccountBO.somenteAtivarContaComDadosBancarios(Trigger.new, Trigger.oldMap);
        }
    }

}
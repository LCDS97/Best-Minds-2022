trigger TriggerAccount on Account (before update, after insert, after update) {

    if(trigger.isAfter){

        if(Trigger.isInsert){
            AccountBO.criarOportunidadePadraoParaConta(Trigger.new);
        }
        
        if(Trigger.isUpdate){
            AccountBO.criarOportunidadePadraoParaConta(Trigger.new);
        }
    }
    
    if(Trigger.isBefore){
        
        if(Trigger.isUpdate){
            AccountBO.somenteAtivarContaComDadosBancarios(Trigger.new, Trigger.oldMap);
        }
    }

}
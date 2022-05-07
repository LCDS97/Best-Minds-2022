trigger TriggerAccount on Account (after insert, after update) {

    if(trigger.isAfter){

        if(Trigger.isInsert){
            AccountBO.criarOportunidadePadraoParaConta(Trigger.new);
        }
        
        if(Trigger.isUpdate){
            AccountBO.criarOportunidadePadraoParaConta(Trigger.new);
            AccountBO.somenteAtivarContaComDadosBancarios(Trigger.new, Trigger.oldMap);
        }
    }

}
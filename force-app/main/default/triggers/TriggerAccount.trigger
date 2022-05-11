trigger TriggerAccount on Account (before update, after insert, after update) {
    
    if(Trigger.isBefore){
        
        if(Trigger.isUpdate){
            AccountBO.somenteAtivarContaComDadosBancarios(Trigger.new, Trigger.oldMap);
        }
    }

    if(Trigger.isAfter){

        if(Trigger.isInsert){
            AccountBO.criarOportunidadePadraoParaConta(Trigger.new);
            AccountBO.alterarDominioEmail(Trigger.new, Trigger.oldMap);
        }
        
        if(Trigger.isUpdate){
            AccountBO.criarOportunidadePadraoParaConta(Trigger.new);
            AccountBO.alterarDominioEmail(Trigger.new, Trigger.oldMap);
        }
    }
    

}
trigger TriggerContract on Contract (before insert, before update, after insert) {


    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContractBO.naoAtivarContratoSemDadosBancarios(Trigger.new,Trigger.oldMap);

        }

        if(Trigger.isUpdate){
            ContractBO.naoAtivarContratoSemDadosBancarios(Trigger.new,Trigger.oldMap);
        }
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContractBO.criarTarefaContaSemDadosBancarios(Trigger.new);
        }
    }


}



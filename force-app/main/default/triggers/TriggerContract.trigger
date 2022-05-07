trigger TriggerContract on Contract (after insert) {


    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContractBO.criarTarefaContaSemDadosBancarios(Trigger.new);
        }
    }

}
trigger TriggerCase on Case (before insert, before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CaseBO.naoAtivarContratoTipoSinistro(Trigger.new);

        }

        if(Trigger.isUpdate){
            CaseBO.naoAtivarContratoTipoSinistro(Trigger.new);
        }
    }
}
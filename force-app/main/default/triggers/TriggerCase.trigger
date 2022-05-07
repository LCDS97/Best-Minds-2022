trigger TriggerCase on Case (before insert, before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CaseBO.naoAtivarContratoTipoSinistro(Trigger.new,Trigger.oldMap);

        }

        if(Trigger.isUpdate){
            CaseBO.naoAtivarContratoTipoSinistro(Trigger.new,Trigger.oldMap);
        }
    }
}
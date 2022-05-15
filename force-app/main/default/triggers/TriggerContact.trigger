trigger TriggerContact on Contact (before insert, before update, after insert, after update) {

/*     if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        ContactBO.DistribuirAltoFaturamento();
    } */

    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        ContactBO.fazerContagemSexualidadeHomossexual(Trigger.new);
        
    }


}
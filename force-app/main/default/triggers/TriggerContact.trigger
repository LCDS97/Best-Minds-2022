trigger TriggerContact on Contact (after insert, after update) {

    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        ContactBO.fazerContagemSexualidadeHomossexual(Trigger.new);
    }

}
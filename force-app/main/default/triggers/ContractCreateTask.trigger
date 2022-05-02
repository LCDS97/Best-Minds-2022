trigger ContractCreateTask on Contract (after insert) {
    /*
    1. Crie um Apex Trigger que, ao criar um registro de Contrato (Contract), crie um registro de Tarefa (Task), caso a Conta (Account) vinculada não possua um registro de Dados Bancários (DadosBancarios__c):
        OwnerId = Proprietário da conta vinculado no caso
        WhatId = Conta vinculada ao caso
        ActivityDate = Data atual
        Subject = Necessário cadastrar os dados bancários do cliente
    */
    List<Contract> lstContasAtivada = new List<Contract>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdsContasAtivadas = new Set<Id>();
    Map<Id,Boolean> mapDevoCriarTask = new Map<Id,Boolean>();

    for(Contract contrato : Trigger.new){
        lstContasAtivada.add(contrato);
        mapDevoCriarTask.put(contrato.AccountId, true);
        setIdsContasAtivadas.add(contrato.AccountId);
    }
    
 /*    for(Contract contaAtivada : lstContasAtivada){
    } */

    List<Account> lstContas = [SELECT Id, OwnerId FROM Account WHERE Id IN :setIdsContasAtivadas];
    List<DadosBancarios__c> lstDadosBancarios = [SELECT
                                                    Id,
                                                    Conta__c
                                                FROM
                                                    DadosBancarios__c
                                                WHERE
                                                    Conta__c
                                                IN
                                                    :setIdsContasAtivadas];
    for(DadosBancarios__c db : lstDadosBancarios){
        mapDevoCriarTask.put(db.Conta__c,false);
    }



    for(Contract contrato : Trigger.New){
        Boolean devoCriar = mapDevoCriarTask.get(contrato.AccountId);


        for(Account conta: lstContas){
            if(mapDevoCriarTask.get(conta.Id)){
                Task task = new Task();
                task.WhatId = conta.Id;
                task.ActivityDate = Date.today();
                task.OwnerId = conta.OwnerId;
                task.Priority = 'High';
                task.Status = 'Not Started';
                task.Subject = 'Necessário cadastrar os dados bancários do cliente';
                lstTaskParaCriar.add(task);
            }
        }


    }
    insert lstTaskParaCriar;
}

// Pegar o OwnerId da conta para criar a Task
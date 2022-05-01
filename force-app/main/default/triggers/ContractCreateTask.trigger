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
    Map<Id, List<DadosBancarios__c>> mapDadosPorConta = new Map<Id, List<DadosBancarios__c>>();

    for(Contract contrato : Trigger.new){
        lstContasAtivada.add(contrato);
        mapDevoCriarTask.put(contrato.AccountId, true);
    }
    
    for(Contract contaAtivada : lstContasAtivada){
        setIdsContasAtivadas.add(contaAtivada.AccountId);
    }

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

        if(devoCriar){
            
            Task task = new Task();
                
            task.WhatId = contrato.AccountId;
            task.ActivityDate = Date.today();
            task.OwnerId = contrato.CreatedById;
            task.Priority = 'High';
            task.Status = 'Not Started';
            task.Subject = 'Necessário cadastrar os dados bancários do cliente';
            lstTaskParaCriar.add(task);
        }
    }
    insert lstTaskParaCriar;
}
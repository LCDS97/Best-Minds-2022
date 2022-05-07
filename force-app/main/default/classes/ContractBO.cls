public with sharing class ContractBO {
    
    /*
1. Crie um Apex Trigger que, ao criar um registro de Contrato (Contract), crie um registro de Tarefa (Task), caso a Conta (Account) vinculada não possua um registro de Dados Bancários (DadosBancarios__c):
    OwnerId = Proprietário da conta vinculado no caso
    WhatId = Conta vinculada ao caso
    ActivityDate = Data atual
    Subject = Necessário cadastrar os dados bancários do cliente */

    public static void criarTarefaContaSemDadosBancarios(List<Contract> lstTriggersContracts){
    List<Contract> lstContasAtivada = new List<Contract>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdsContasAtivadas = new Set<Id>();
    Map<Id,Boolean> mapDevoCriarTask = new Map<Id,Boolean>();

    for(Contract contrato : lstTriggersContracts){
        lstContasAtivada.add(contrato);
        mapDevoCriarTask.put(contrato.AccountId, true);
        setIdsContasAtivadas.add(contrato.AccountId);
    }
    
    List<Account> lstContas = AccountDAO.buscarContasPorId(setIdsContasAtivadas);
    List<DadosBancarios__c> lstDadosBancarios = DadosBancariosDAO.pegarContasPorDadoBancarios(setIdsContasAtivadas);
    for(DadosBancarios__c db : lstDadosBancarios){
        mapDevoCriarTask.put(db.Conta__c,false);
    }

    for(Account conta : lstContas){
        Boolean devoCriar = mapDevoCriarTask.get(conta.Id);

        if(devoCriar){
            
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

        insert lstTaskParaCriar;
    }
}

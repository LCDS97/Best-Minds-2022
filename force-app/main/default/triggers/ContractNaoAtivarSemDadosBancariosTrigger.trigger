trigger ContractNaoAtivarSemDadosBancariosTrigger on Contract (before insert, before update) {
/*
    2 - Crie um Apex Trigger que, ao ativar um Contrato (Contract) (Status = Activated), valide se a Conta (Account) vinculada possui um
            registro de Dados Bancários (DadosBancarios__c) ativo. Caso não possua, exibir uma mensagem que ele não pode ativar um Contrato (Contract)
                sem ter um registro de Dados Bancários (DadosBancarios__c) ativo. Obs.: Utilizar o método addError.
    */
    
    List<Contract> lstContratosAtivado = new List<Contract>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdContratosAtivo = new Set<Id>();
    Map<Id,Boolean> mapEstaComDadosBancarios = new Map<Id,Boolean>();
    Map<Id, List<DadosBancarios__c>> mapDadosPorContrato = new Map<Id, List<DadosBancarios__c>>();

    if(Trigger.isUpdate){
        for(Contract contratoNovo : Trigger.New){
            Contract contratoAntigo = Trigger.oldMap.get(contratoNovo.Id);
            if(contratoAntigo.Status != 'Activated' && contratoNovo.Status == 'Activated'){
                lstContratosAtivado.add(contratoNovo);
                setIdContratosAtivo.add(contratoNovo.AccountId);
            }
        }
    }

    if(Trigger.isInsert){
        for(Contract contratoNovo : Trigger.New){
            if(contratoNovo.Status == 'Activated'){
                lstContratosAtivado.add(contratoNovo);
                setIdContratosAtivo.add(contratoNovo.AccountId);
            }
    }
}
    
    

    if(lstContratosAtivado.isEmpty()){
        return;
    }


    List<DadosBancarios__c> lstDadosBancarios = [SELECT
                                                    Id,
                                                    Conta__c
                                                FROM
                                                    DadosBancarios__c
                                                WHERE
                                                    Conta__c
                                                IN
                                                    :setIdContratosAtivo AND Ativo__c = true];
    for(DadosBancarios__c db : lstDadosBancarios){
        if(!mapEstaComDadosBancarios.containsKey(db.Conta__c)){
            mapDadosPorContrato.put(db.Conta__c, new List<DadosBancarios__c>());
        }
        mapDadosPorContrato.get(db.Conta__c).add(db);
    }

    for(Contract contratoAtivo : lstContratosAtivado){
        if(!mapDadosPorContrato.containsKey(contratoAtivo.accountId) && Trigger.isUpdate){
            contratoAtivo.addError('Você não pode mudar a fase do Contrato sem um dado bancário, preencha uma por favor!');
        }
        if(!mapDadosPorContrato.containsKey(contratoAtivo.accountId) && Trigger.isInsert){
            contratoAtivo.addError('Você não pode criar um contrato já ativado sem um dado bancário, preencha uma por favor!');
        }
    }
}
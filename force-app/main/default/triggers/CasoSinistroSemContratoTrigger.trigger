trigger CasoSinistroSemContratoTrigger on Case (before insert, before update) {
/*
    3 - Crie um Apex Trigger que, ao criar ou atualizar um registro de Caso (Case) com o tipo “Sinistro”, valide se a conta vinculada possui um Contrato (Contract) ativo. Caso não possua, exibir uma mensagem que ele não pode abrir um sinistro sem um Contrato (Contract) ativo. Obs.: Utilizar o método addError.*/
    
    List<Case> lstContratosAtivado = new List<Case>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdContratosAtivo = new Set<Id>();
    Map<Id,Boolean> mapEstaComDadosBancarios = new Map<Id,Boolean>();
    Map<Id, List<DadosBancarios__c>> mapDadosPorContrato = new Map<Id, List<DadosBancarios__c>>();

    for(Case contratoNovo : Trigger.New){
        Case contratoAntigo = Trigger.oldMap.get(contratoNovo.Id);
        if(contratoAntigo.Status != 'Activated' && contratoNovo.Status == 'Activated'){
            lstContratosAtivado.add(contratoNovo);
        }
    }
    

    if(lstContratosAtivado.isEmpty()){
        return;
    }

    
    for(Contract contratoAtivado : lstContratosAtivado){
        setIdContratosAtivo.add(contratoAtivado.AccountId);
    }

    List<DadosBancarios__c> lstDadosBancarios = [SELECT
                                                    Id,
                                                    Conta__c
                                                FROM
                                                    DadosBancarios__c
                                                WHERE
                                                    Conta__c
                                                IN
                                                    :setIdContratosAtivo];
    for(DadosBancarios__c db : lstDadosBancarios){
        if(!mapEstaComDadosBancarios.containsKey(db.Conta__c)){
            mapDadosPorContrato.put(db.Conta__c, new List<DadosBancarios__c>());
        }
        mapDadosPorContrato.get(db.Conta__c).add(db);
    }

    for(Contract contratoAtivo : lstContratosAtivado){
        if(!mapEstaComDadosBancarios.containsKey(contratoAtivo.Id)){
            contratoAtivo.addError('Você não pode mudar a fase do Contrato sem um dado bancário, preencha uma por favor!');
        }
    }
}
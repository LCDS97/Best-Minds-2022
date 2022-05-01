trigger CasoSinistroSemContratoTrigger on Case (before insert, before update) {
/*
    3 - Crie um Apex Trigger que, ao criar ou atualizar um registro de Caso (Case) com o tipo “Sinistro”, valide se a conta vinculada
        possui um Contrato (Contract) ativo. Caso não possua, exibir uma mensagem que ele não pode abrir um sinistro sem um Contrato (Contract) ativo.
        Obs.: Utilizar o método addError.
*/
    
    
    List<Case> lstCasosAtivado = new List<Case>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdCasos = new Set<Id>();
    Map<Id,Boolean> mapEstaComContratos = new Map<Id,Boolean>();
    Map<Id, List<Contract>> mapCasosComContrato = new Map<Id, List<Contract>>();

    if(!Trigger.isInsert){
        for(Case casoNovo : Trigger.New){
            Case casoAntigo = Trigger.oldMap.get(casoNovo.Id);
            if(casoAntigo.Type != 'Sinistro' && casoNovo.Type == 'Sinistro'){
                lstCasosAtivado.add(casoNovo);
                System.debug(lstCasosAtivado);
            }
        }
    }else {
        for(Case casoNovo : Trigger.New){
            if(casoNovo.Type == 'Sinistro') lstCasosAtivado.add(casoNovo);
        }
        
      
    }

    

    if(lstCasosAtivado.isEmpty()){
        return;
    }

    
    for(Case casoAtivado : lstCasosAtivado){
        setIdCasos.add(casoAtivado.AccountId);
        System.debug('#### => ' + setIdCasos);
    }

    List<Contract> lstContratos = [SELECT
                                                    Id,
                                                    AccountId
                                                FROM
                                                    Contract
                                                WHERE
                                                    AccountId
                                                IN
                                                    :setIdCasos];
    for(Contract contrato : lstContratos){
        if(!mapEstaComContratos.containsKey(contrato.AccountId)){
            mapCasosComContrato.put(contrato.AccountId, new List<Contract>());
            System.debug('#### => Dentro do IF: ' + mapCasosComContrato);
        }
        mapCasosComContrato.get(contrato.AccountId).add(contrato);
        System.debug('#### => Fora do IF: ' + mapCasosComContrato);
    }
    
    for(Case caso : lstCasosAtivado){
        if(!mapCasosComContrato.containsKey(caso.accountId)){
            caso.addError('Não é possível ter um Caso do Tipo Sinistro sem um Contrato, por favor, revise essa informação!');
            System.debug('#### => Dentro do ultimo IF: ' + mapCasosComContrato);
        }
        System.debug('#### => Fora do ultimo IF: ' + mapCasosComContrato);
    }
}
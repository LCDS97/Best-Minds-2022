trigger OutroExemplo on Account (before update) {
    List<Account> lstContasAtivadasAgora = new List<Account>();
    Set<Id> setIdsContasAtivadas = new Set<Id>();
    Map<Id, List<DadosBancarios__c>> mapDadosPorConta = new Map<Id, List<DadosBancarios__c>>();

    for(Account contaNova : Trigger.new){
        Account contaAntiga = Trigger.oldMap.get(ContaNova.Id);

        // Filtrando para verificar os map se houve alteração do valor de Ativo para acionar Trigger
        if(!contaAntiga.Ativo__c && contaNova.Ativo__c){
            lstContasAtivadasAgora.add(contaNova);
        }
    }

    // Caso nenhuma conta esta em Trigger.new, ele sai do código
    if(lstContasAtivadasAgora.isEmpty()){
        return;
    }

    // Percorrendo a lista de Contas Atividas e adicionando eles na lista de Set Id
    for(Account contaAtivada : lstContasAtivadasAgora){
        setIdsContasAtivadas.add(contaAtivada.Id);
    }

    // Pegando as contas ativas dentro da lista de Set que possui Dados Bancários
    List<DadosBancarios__c> lstDadosBancarios = [SELECT 
                                                    Id,
                                                    Conta__c
                                                FROM
                                                    DadosBancarios__c
                                                WHERE
                                                    Conta__c
                                                IN 
                                                    :setIdsContasAtivadas];

    // Verificando se existe Dados Bancários
    for(DadosBancarios__c db: lstDadosBancarios){
        // Caso não tenha, é criado uma chave para o item atual com seu Id de Conta e uma Lista de Dados Bancários Vazia
        if(!mapDadosPorConta.containsKey(db.Conta__c)){
            mapDadosPorConta.put(db.Conta__c, new List<DadosBancarios__c>());
        }
        // Caso ele possua um dado bancários, pegamos o valor ja referenciado la e adiciona a lista com seus dados bancários
        mapDadosPorConta.get(db.Conta__c).add(db);
    }
    
    // Verificando se o usuário tentar adicionar uma conta sem Dados Bancários ira fazer a validação, pois o mesmo não esta presente no Map significa que ele não possui dado bancário
    for(Account contaAtivada : lstContasAtivadasAgora){
        if(!mapDadosPorConta.containsKey(contaAtivada.Id)){
            contaAtivada.addError('Você não pode ativar uma conta que não possui dado bancário, por favor insira uma!');
        } else {
            // Para setar por padrão após ser ativado, automaticamente muda para o Rating de Prata
            contaAtivada.Rating = 'Prata';
        }
    }
}
trigger SomenteUmDadoBancarioTrigger on DadosBancarios__c (after insert) {
    /* 
    4 - Crie um Apex Trigger que, ao criar um registro de Dados Bancários (DadosBancarios__c) ativo,
            inative todos os outros registros de Dados Bancários ativos do cliente, menos o que acabou de ser ativado.
    */

    Set<Id> setDadosBancariosAtivo = new Set<Id>();
    Set<Id> setFiltrarContaPorId = new Set<Id>();
    List<DadosBancarios__c> lstAdicionarDadoBancario = new List<DadosBancarios__c>();

    for(DadosBancarios__c dadosBancarios : Trigger.New){
        //DadosBancarios__c novoDadoBancario = Trigger.newMap.get(dadosBancarios.Conta__c);
           // mapDadosBancarios.put(novoDadoBancario.Conta__c,novoDadoBancario);
           if(dadosBancarios.Ativo__c){
                setDadosBancariosAtivo.add(dadosBancarios.Id);
                setFiltrarContaPorId.add(dadosBancarios.Conta__c);
                lstAdicionarDadoBancario.add(dadosBancarios);
           } else{
               return;
           }

            
        }
        
        
        if(setDadosBancariosAtivo.isEmpty() || setFiltrarContaPorId.isEmpty() || lstAdicionarDadoBancario.isEmpty()) return;
        
        
        List<DadosBancarios__c> lstTodosDadosBancariosPorIdConta = [SELECT 
                                                                    Id,
                                                                    Conta__c, 
                                                                    Ativo__c
                                                                FROM
                                                                    DadosBancarios__c
                                                                WHERE
                                                                    Conta__c
                                                                IN 
                                                                    :setFiltrarContaPorId];
    for (DadosBancarios__c db : lstTodosDadosBancariosPorIdConta){
        
            if(!setDadosBancariosAtivo.contains(db.Id)){
                db.Ativo__c = false;
            }
        
        
        
    }
    update lstTodosDadosBancariosPorIdConta;

}
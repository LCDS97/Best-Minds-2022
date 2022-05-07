public with sharing class DadosBancariosBO {
    
    public static void somenteUmDadoBancarioAtivo(List<DadosBancarios__c> lstDadosBancariosTrigger){
        /* 
    4 - Crie um Apex Trigger que, ao criar um registro de Dados Bancários (DadosBancarios__c) ativo,
            inative todos os outros registros de Dados Bancários ativos do cliente, menos o que acabou de ser ativado.
    */

    Set<Id> setDadosBancariosAtivo = new Set<Id>();
    Set<Id> setFiltrarContaPorId = new Set<Id>();

    for(DadosBancarios__c dadosBancarios : lstDadosBancariosTrigger){

        if(dadosBancarios.Ativo__c){
            setDadosBancariosAtivo.add(dadosBancarios.Id);
            setFiltrarContaPorId.add(dadosBancarios.Conta__c);

        }
        else return;
    
        }

        if(setDadosBancariosAtivo.isEmpty() || setFiltrarContaPorId.isEmpty()) return;
        
        List<DadosBancarios__c> lstTodosDadosBancariosPorIdConta = DadosBancariosDAO.pegarContasAtivosPorId(setFiltrarContaPorId);
    for (DadosBancarios__c db : lstTodosDadosBancariosPorIdConta){ 
        
            if(!setDadosBancariosAtivo.contains(db.Id)){ 
                db.Ativo__c = false;
            }
        
        
        
    }
    update lstTodosDadosBancariosPorIdConta;

    }
}

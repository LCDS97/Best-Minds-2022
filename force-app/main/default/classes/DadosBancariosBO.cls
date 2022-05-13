public with sharing class DadosBancariosBO {

    public class AtualizaDadosBancariosException extends Exception {}   
    
    public static void somenteUmDadoBancarioAtivo(List<DadosBancarios__c> lstDadosBancariosTrigger){
        /* 
    4 - Crie um Apex Trigger que, ao criar um registro de Dados Bancários (DadosBancarios__c) ativo,
            inative todos os outros registros de Dados Bancários ativos do cliente, menos o que acabou de ser ativado.
    */

    Set<Id> setDadosBancariosAtivo = new Set<Id>();
    Set<Id> setFiltrarContaPorId = new Set<Id>();
    List<DadosBancarios__c> lstDadosBancariosParaInativar = new List<DadosBancarios__c>(); 

    for(DadosBancarios__c dadosBancarios : lstDadosBancariosTrigger){

        if(dadosBancarios.Ativo__c){
            setDadosBancariosAtivo.add(dadosBancarios.Id);
            setFiltrarContaPorId.add(dadosBancarios.Conta__c);

        }
    
        }

        if(setDadosBancariosAtivo.isEmpty() || setFiltrarContaPorId.isEmpty()) return;
        
        List<DadosBancarios__c> lstTodosDadosBancariosPorIdConta = DadosBancariosDAO.pegarContasAtivosPorId(setFiltrarContaPorId);
    for (DadosBancarios__c db : lstTodosDadosBancariosPorIdConta){ 
        
            if(!setDadosBancariosAtivo.contains(db.Id)){ 
                db.Ativo__c = false;
                lstDadosBancariosParaInativar.add(db);
            }
        
        
        
    }
    update lstDadosBancariosParaInativar;

    }

    public static Map<Id,List<DadosBancarios__c>> mapDadosBancarios(){
        List<Account> contasClientePJ = AccountDAO.clientePjAtivos();

        Map<Id,List<DadosBancarios__c>> mapDadosBancariosClientePJ = new Map<Id,List<DadosBancarios__c>>();

        for(Account conta : contasClientePJ){
            mapDadosBancariosClientePJ.put(conta.Id,new List<DadosBancarios__c>());
        }

        List<DadosBancarios__c> lstDadosBancarios = DadosBancariosDAO.pegarContasPorDadoBancarios(mapDadosBancariosClientePJ.keySet());

        for(DadosBancarios__c dadoBancario : lstDadosBancarios){
            mapDadosBancariosClientePJ.get(dadoBancario.Conta__c).add(dadoBancario);
        }

        return mapDadosBancariosClientePJ;


    }

    public void insereDadosBancarios(Id accountId, String banco, Integer agencia, Integer numeroConta){
        checarDadosBancarios(banco,agencia,numeroConta);
        DadosBancarios__c dadosbancarios = new DadosBancarios__c(
            Agencia__c = agencia,
            Banco__c = banco,
            Conta__c = accountId,
            NumeroConta__c = numeroConta
        );
        insert dadosbancarios;
    }
    private static void checarDadosBancarios(String banco, Integer agencia, Integer numeroConta){
        Set<String> setBancos = new Set<String>{'Itaú', 'Bradesco','Banco do Brasil','Caixa Econômica Federal','Santander'};
        if(!setBancos.contains(banco)){
            throw new AtualizaDadosBancariosException('Banco não disponível para inserção!');
        }
        if(agencia == 0 || numeroConta == 0){
            throw new AtualizaDadosBancariosException('Agência e Número de Conta não podem ser igual a zero!');
        }
    }


    public static List<DadoBancarioTO> buscarDadosBancarios(Id idConta){
        List<DadosBancarios__c> lstDadosBancarios = DadosBancariosDAO.pegarContaPorDadoBancarios(idConta);
        List<DadoBancarioTO> lstDadosBancariosTO = transformarDadosBancariosEmDadoBancarioTO(lstDadosBancarios);
        
        
        return lstDadosBancariosTO;
    }
    
    private static List<DadoBancarioTO> transformarDadosBancariosEmDadoBancarioTO(List<DadosBancarios__c> lstDadosBancarios){
        List<DadoBancarioTO> lstDadoBancarioTO = new List<DadoBancarioTO>();
        for(DadosBancarios__c dadoBancario : lstDadosBancarios){
            
            DadoBancarioTO dadoBancarioTO = new DadoBancarioTO();
            dadoBancarioTO.banco = String.valueOf(dadoBancario.Banco__c);
            dadoBancarioTO.agencia = String.valueOf(dadoBancario.Agencia__c);
            dadoBancarioTO.numeroConta = String.valueOf(dadoBancario.NumeroConta__c);
            dadoBancarioTO.id = dadoBancario.Id;
            lstDadoBancarioTO.add(dadoBancarioTO);

        }

        return lstDadoBancarioTO;

    }

    public class DadoBancarioTO {
        @AuraEnabled
        public String banco { get;set; }
        @AuraEnabled
        public String agencia { get;set; }
        @AuraEnabled
        public String numeroConta { get;set; }
        @AuraEnabled
        public String id { get;set; }
    }
 
}

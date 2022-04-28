public with sharing class ExerciciosCollection {
    // 1 - Criar um método que retorne os Clientes PJ Ativos
    public static List<Account> clientePjAtivos(){
        List<Account> listaAtivos = [SELECT Id,Name, Ativo__c FROM Account WHERE Ativo__c = true];

        return listaAtivos;
    }

    // 2 - Criar um método que retorne uma lista de parcelas vencidas
    public static List<Parcela__c> retornarParcelasVencidas(){
        List<Parcela__c> listaVencidas = [SELECT Id, DataVencimento__c FROM Parcela__c WHERE Status__c = 'Atrasada'];
    
        return listaVencidas;
    }

    // 3 - Criar um método que retorne a Oportunidade de Maior Valor
    public static Opportunity oportunidadeMaiorValor(){
        Opportunity oportunidadeComMaiorValor = [SELECT Id, Amount, Name FROM Opportunity ORDER BY Amount DESC NULLS LAST LIMIT 1];
        
        return oportunidadeComMaiorValor;
    }

    // 4 - Criar um método que receba um campo String referente ao Campo Setor do objeto Cliente PJ
    //      e retorne todos os clientes com aquele setor em Específico
    public static List<Account> buscarSetorClientePJ(String nomeSetor){
        String nomeSetorString = '%' + nomeSetor + '%';

        List<Account> buscarContasClientePj = [SELECT Id, Name, Industry FROM Account WHERE Industry LIKE: nomeSetorString];

        for(Account conta : buscarContasClientePj){
            System.debug('Nome da conta é ' + conta.Name + ' e o Setor da conta é ' + conta.Industry);
        }

        return buscarContasClientePj;
    }

    // 5 - Criar um método que receba um Id de Contrato e retorne a quantidade de parcelas do mesmo Contrato
    public static Integer buscarParcelasContrato(Id IdContrato){
        Integer buscaParcelaPorContratoId = [SELECT Count() FROM Parcela__c WHERE Contrato__c =: IdContrato];

        return buscaParcelaPorContratoId;
    } 

}

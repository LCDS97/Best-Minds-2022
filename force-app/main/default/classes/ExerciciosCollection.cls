public with sharing class ExerciciosCollection {
    // 1 - Criar um método que retorne os Clientes PJ Ativos
    public static List<Account> clientePjAtivos(){
        List<Account> listaAtivos = [SELECT Id,Name, Ativo__c FROM Account WHERE Ativo__c = true];

        return listaAtivos;
    }
}

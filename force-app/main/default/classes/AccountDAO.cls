public with sharing class AccountDAO {
    
    public static List<Account> buscarContasPorId(Set<Id> setIdAccount){
        return [
            SELECT Id, Name, OwnerId FROM Account WHERE Id IN :setIdAccount
        ];
    }

    public static Account buscarContaPorId(Id idAccount){
        return [
            SELECT Id, Name FROM Account WHERE Id =: idAccount
        ];
    }

    public static Account buscarContaAtivoPorID(Id idAccount){
        return [
            SELECT Id, Name, Ativo__c FROM Account WHERE Id =: idAccount
        ];
    }

    public static List<Account> clientePjAtivos(){
        return [
            SELECT Id,Name, Ativo__c FROM Account WHERE Ativo__c = true
        ];

    }

    public static List<Account> buscarContasSetor(String nomeSetor){
        return [
            SELECT Id, Name, Industry FROM Account WHERE Industry LIKE: nomeSetor
        ];
    }

    public static Account buscarValidacoesContaPJ(Id idContaPJ){
        return [
            SELECT Id, Ativo__c, Type, RazaoSocial__c, CNPJ__c From Account WHERE Id =: idContaPJ
        ];
    }

    public static List<Account> buscarContasComContatosComEmail(Set<Id> setIdContas){

        return [
            SELECT Id, Dominio__c, (SELECT Email FROM Contacts) FROM Account WHERE Id =: setIdContas AND Dominio__c != null
        ];
    }

    public static List<Account> buscarContasPorSexualidadeHomossexual(Set<Id> setIdContas){
        return [ 
            SELECT Id, (SELECT Id FROM Contacts WHERE Sexualidade__c = 'Homossexual') FROM Account WHERE Id IN :setIdContas
        ];
    }

}

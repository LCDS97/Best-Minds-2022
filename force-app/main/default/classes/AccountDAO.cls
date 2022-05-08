public with sharing class AccountDAO {
    
    public static List<Account> buscarContasPorId(Set<Id> setIdAccount){
        return [SELECT Id, Name, OwnerId FROM Account WHERE Id IN :setIdAccount];
    }

    public static Account buscarContaPorId(Id idAccount){
        return [SELECT Id, Name FROM Account WHERE Id =: idAccount];
    }

    public static Account buscarContaAtivoPorID(Id idAccount){
        return [SELECT Id, Ativo__c FROM Account WHERE Id =: idAccount];
    }

    public static List<Account> clientePjAtivos(){
        List<Account> listaAtivos = [SELECT Id,Name, Ativo__c FROM Account WHERE Ativo__c = true];

        return listaAtivos;
    }

    public static List<Account> buscarContasSetor(String nomeSetor){
        return [
            SELECT Id, Name, Industry FROM Account WHERE Industry LIKE: nomeSetor
        ];
    }
}

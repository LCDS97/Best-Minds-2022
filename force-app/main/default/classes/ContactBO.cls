public with sharing class ContactBO {

    public static void fazerContagemSexualidadeHomossexual(List<Contact> lstContatos){
        Set<Id> setAccountIds = new Set<Id>();
        List<Account> lstAccountsAdicionar = new List<Account>();

        for(Contact contato : lstContatos){
            if(contato.Sexualidade__c == 'Homossexual') setAccountIds.add(contato.AccountId);
        
        }

        if(setAccountIds.isEmpty()) return;

        List<Account> lstAccounts = AccountDAO.buscarContasPorSexualidadeHomossexual(setAccountIds);
    
        integer qtd = 0;

        for(Account conta : lstAccounts){
            for(Contact contato : conta.Contacts){
                qtd++;
            }
            conta.QuantidadeHomossexuais__c = qtd;
            lstAccountsAdicionar.add(conta);
            qtd = 0;
        }

        update lstAccountsAdicionar;

    
    }
}

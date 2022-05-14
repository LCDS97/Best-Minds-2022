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

    public static void DistribuirAltoFaturamento(List<Account> lstContas){
        Set<Contact> setContatosAtualizado = new Set<Contact>();
        Set<Id> setIdContas = new Set<Id>();

        for(Account conta : lstContas){
            
            Decimal dividirFaturamento = conta.AnnualRevenue / 2;
            conta.AnnualRevenue = dividirFaturamento;

            Decimal valorDistribuir = dividirFaturamento / conta.Contacts.size();
            for(Contact contato : conta.Contacts){
                if(contato.SalarioAnual__c == null){
                    contato.SalarioAnual__c = 0;
                    contato.SalarioMensal__c = 0;

                    contato.SalarioAnual__c = valorDistribuir;
                    contato.SalarioMensal__c = contato.SalarioAnual__c / 12;
                    
                    setContatosAtualizado.add(contato);
                }

                contato.SalarioAnual__c = valorDistribuir;
                contato.SalarioMensal__c = contato.SalarioAnual__c / 12;
                setContatosAtualizado.add(contato);
            }
            
        }
        List<Contact> lstContatosAtualizado = new List<Contact>(setContatosAtualizado);

        update lstContatosAtualizado;

    }
}

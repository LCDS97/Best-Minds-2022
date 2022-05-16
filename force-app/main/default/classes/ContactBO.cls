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


    public static void DistribuirAltoFaturamento(){
        Set<Contact> setContatosAtualizado = new Set<Contact>();
        Set<Id> setIdContas = new Set<Id>();

       atribuirAnnualRevenue();

        List<Account> lstContas = AccountDAO.buscarContasComFaturamentoDeAcimaDeMilhao();

        for(Account conta : lstContas){
            
            if(conta.AnnualRevenue > 1000000){
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
            
        }
        List<Contact> lstContatosAtualizado = new List<Contact>(setContatosAtualizado);

        update lstContatosAtualizado;

    }

    private static void atribuirAnnualRevenue() {

        List<Account> lstContasParaUpdate = new List<Account>();

        List<Account> lstTodasContas = AccountDAO.buscarContasParaCalcularOportunidades();
        for(Account conta : lstTodasContas){
            if(conta.AnnualRevenue == null){
                conta.AnnualRevenue = 0;
                for(Opportunity oportunidade : conta.Opportunities){
                    if(oportunidade.Amount == null){
                        oportunidade.Amount = 0;
                        conta.AnnualRevenue += oportunidade.Amount;
                    }else {
                        conta.AnnualRevenue += oportunidade.Amount;
                    }
                }
            }else{
                
                for(Opportunity oportunidade : conta.Opportunities){
                    if(oportunidade.Amount == null){
                        oportunidade.Amount = 0;
                        conta.AnnualRevenue += oportunidade.Amount;
                    }else {
                        conta.AnnualRevenue += oportunidade.Amount;
                    }
                }

            }
            lstContasParaUpdate.add(conta);
        }

        update lstContasParaUpdate;
    }
}

public with sharing class MathiasExerccicio3 {


    public static void DistribuirAltoFaturamento(){
        Set<Contact> setContatosAtualizado = new Set<Contact>();
        Set<Id> setIdContas = new Set<Id>();
        atribuirAnnualRevenue();

        List<Account> lstContas = [SELECT  Id, AnnualRevenue, Name, ( SELECT Id, SalarioAnual__c, SalarioMensal__c FROM Contacts ) FROM Account WHERE AnnualRevenue > 1000000];

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

    private static void atribuirAnnualRevenue() {

        List<Account> lstContasParaUpdate = new List<Account>();

        List<Account> lstTodasContas = [SELECT Id, AnnualRevenue, Name, (SELECT Id, Amount FROM Opportunities) FROM Account];
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

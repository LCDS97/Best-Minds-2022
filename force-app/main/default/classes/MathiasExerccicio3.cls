public with sharing class MathiasExerccicio3 {
    
    public static void DistribuirAltoFaturamento(){
        List<Account> lstContasParaSomar = new List<Account>();
        List<Account> lstContasParaDistribuir = new List<Account>();
        Set<Id> setIdContas = new Set<Id>();

        List<Account> lstContas = [SELECT  Id, AnnualRevenue, Name, ( SELECT Id, Salario__c FROM Contacts ) FROM Account ];



        for(Account conta : lstContas){
            setIdContas.add(conta.Id);
            lstContasParaSomar.add(conta);
        }

        List<Opportunity> lstOportunidadesValores = OpportunityDAO.recuperarOportunidadesPorIdConta(setIdContas);

        Decimal valorSomar = 0;
        
        for(Account conta : lstContasParaSomar){
            
            System.debug(' Antes do FOR OPP Conta ANNUAL REVENUE R$' + conta.AnnualRevenue);
            if(conta.AnnualRevenue == null){
                for(Opportunity oportunidade : lstOportunidadesValores){
                    System.debug(' DENTRO DO FOR OPPConta ANNUAL REVENUE R$' + conta.AnnualRevenue);
                    if(oportunidade.Amount == null){
                        conta.AnnualRevenue += oportunidade.Amount;
                    }
                    conta.AnnualRevenue += oportunidade.Amount;

                }
            }
            conta.AnnualRevenue = valorSomar;

            if(conta.AnnualRevenue > 1000000){
                lstContasParaDistribuir.add(conta);
                System.debug('Condição Annual Revenual maior que 1 milhao =' + lstContasParaDistribuir);
            }
            valorSomar = 0;
        }

        for(Account conta : lstContasParaDistribuir){
            
            System.debug('###### Conta' + conta.Id + '### Faturamento antes: ' + conta.AnnualRevenue);
            Decimal dividirFaturamento = conta.AnnualRevenue / 2;
            System.debug('###### Conta' + conta.Id + '### Faturamento depois distribuição: ' + conta.AnnualRevenue);
            Decimal valorDistribuir = dividirFaturamento / conta.Contacts.size();
            for(Contact contato : conta.Contacts){
                System.debug('###### Contato' + contato.Id + '### Salario antes: ' + contato.Salario__c);
                contato.Salario__c = valorDistribuir;
                System.debug('###### Contato' + contato.Id + '### Salario depois: ' + contato.Salario__c);
            }
            conta.AnnualRevenue = dividirFaturamento;
            System.debug('###### Conta' + conta.Id + '### Faturamento no update: ' + conta.AnnualRevenue);
        }
        update lstContasParaDistribuir;

    }
}

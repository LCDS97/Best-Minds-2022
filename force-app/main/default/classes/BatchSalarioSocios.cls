public class BatchSalarioSocios implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT  Id, AnnualRevenue, Name, ( SELECT Id, Salario__c FROM Contacts ) FROM Account ]);
    }

    public void execute(Database.BatchableContext bc, List<Account> lstContas){

        List<Account> lstContasParaSomar = new List<Account>();
        List<Account> lstContasParaDistribuir = new List<Account>();
        Set<Id> setIdContas = new Set<Id>();

        for(Account conta : lstContas){
            setIdContas.add(conta.Id);
            lstContasParaSomar.add(conta);
        }

        List<Opportunity> lstOportunidadesValores = OpportunityDAO.recuperarOportunidadesPorIdConta(setIdContas);
        Decimal valorTotalConta = 0;

        for(Account conta : lstContasParaSomar){
            for(Opportunity oportunidade : lstOportunidadesValores){
                valorTotalConta =+ oportunidade.Amount;
            }
            conta.AnnualRevenue = valorTotalConta;
            if(conta.AnnualRevenue > 1000000){
                lstContasParaDistribuir.add(conta);
            }
            valorTotalConta = 0;
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

    public void finish(Database.BatchableContext bc){

    }

}

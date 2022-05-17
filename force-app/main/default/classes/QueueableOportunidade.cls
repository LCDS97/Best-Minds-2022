public class QueueableOportunidade implements Queueable {
    
    public List<Opportunity> lstOportunidades;
    public QueueableOportunidade(List<Opportunity> lstOportunidades){
        this.lstOportunidades = lstOportunidades;
    }
    
    public void execute(QueueableContext context) {
      
        Set<Id> setIdConta = new Set<Id>();
        List<Opportunity> lstOpportunity = new List<Opportunity>();

        for(Opportunity opp : lstOportunidades){
            setIdConta.add(opp.AccountId);
        }

        List<Account> lstContas = [SELECT
                                        Id,
                                        (
                                            SELECT
                                                Id
                                            FROM
                                                Contacts
                                        )
                                    FROM
                                        Account
                                    
                                    WHERE
                                        Id =
                                        :setIdConta];


        for(Account conta : lstContas){
            for(Opportunity opp : lstOportunidades){
                if(conta.Contacts.size() == 0) continue;
                opp.Contato__c = conta.Contacts[0].Id;
                lstOpportunity.add(opp);
            }
        }
        update lstOpportunity;
    }
}
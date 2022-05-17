public class ScheduleBuscarOportunidades implements Schedulable{
    public void execute(SchedulableContext ctx){
        List<Opportunity> lstOportunidades = [SELECT
                                                    Id,
                                                    Amount,
                                                    StageName,
                                                    AccountId,
                                                    ContactId
                                                FROM
                                                    Opportunity
                                                WHERE
                                                    Amount > 100000
                                                OR
                                                    StageName = 'Closed Won'];

        List<Opportunity> lstOportunidadesAtualizadas = new List<Opportunity>();
        List<Contact> lstnovosContatos = new List<Contact>();

        Integer contador = 0;
        
        for(Opportunity oportunidade : lstOportunidades){
            Contact novoContato = new Contact();
            novoContato.LastName = 'Contato Número ' + contador++;
            novoContato.AccountId = oportunidade.AccountId;
            oportunidade.Contato__c = novoContato.Id;

            lstnovosContatos.add(novoContato);
            lstOportunidadesAtualizadas.add(oportunidade);
        }

        update lstOportunidadesAtualizadas;
        insert lstnovosContatos;
        
    }
    
}

public class QueueableDataFechamentoMaiorQueAtual implements Queueable {
    
    public void execute(QueueableContext ctx){
        List<Opportunity> lstOportunidades = [
                                                SELECT
                                                    Id,
                                                    Description,
                                                    AccountId
                                                FROM
                                                    Opportunity
                                                WHERE
                                                    CloseDate > TODAY
        ];

        for(Opportunity opp : lstOportunidades){
            opp.Description = 'Oportunidades com contato associado';
        }

        QueueableOportunidade updateJob = new QueueableOportunidade(lstOportunidades);
        System.enqueueJob(updateJob);
    }
}
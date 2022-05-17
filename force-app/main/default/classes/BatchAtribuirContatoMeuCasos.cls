public class BatchAtribuirContatoMeuCasos implements Database.Batchable<SObject>{


    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT
                                            Id,
                                            ContactId
                                        FROM
                                            Case
                                        WHERE
                                            ContactId = null
                                        AND
                                            CreatedDate = LAST_N_DAYS:5]);
    }

    public void execute(Database.BatchableContext bc, List<Case> lstCases){
        Contact contatoMeu = new Contact();
        contatoMeu.LastName = 'Santos';
        contatoMeu.FirstName = 'Lucas';

        insert contatoMeu;

        for(Case caso : lstCases){
            caso.ContactId = contatoMeu.Id;
        }

        update lstCases;
        
    }

    public void finish(Database.BatchableContext bc){

    }




}
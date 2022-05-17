public class BatchPreencherEndereco implements Database.Batchable<SObject>{


    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT
                                                Id,
                                                BillingStreet,
                                                BillingCity,
                                                BillingState,
                                                BillingCountry,
                                                    (
                                                        SELECT
                                                            Id,
                                                            MailingCountry,
                                                            MailingState, MailingCity,
                                                            MailingStreet
                                                        FROM
                                                            Contacts
                                                    )
                                            FROM
                                                Account]);
    }

    public void execute(Database.BatchableContext bc, List<Account> lstContas){
        List<Contact> lstContatosUpdate = new List<Contact>();

        for(Account conta : lstContas){
            if(conta.Contacts.size() >= 2){
                for(Contact contato : conta.Contacts){
                    contato.MailingCountry = conta.BillingCountry;
                    contato.MailingState = conta.BillingState;
                    contato.MailingCity = conta.BillingCity;
                    contato.MailingStreet = conta.BillingStreet;
                    lstContatosUpdate.add(contato);
                }
            }
        }

        update lstContatosUpdate;
        
    }

    public void finish(Database.BatchableContext bc){

    }




}
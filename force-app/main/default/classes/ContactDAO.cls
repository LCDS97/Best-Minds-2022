public with sharing class ContactDAO {
    
    public static List<Contact> buscarContatosPorIdConta(Set<Id> setIdContas){

        return [
            SELECT Id, AccountId FROM Contact WHERE AccountId =: setIdContas
        ];

    }
}


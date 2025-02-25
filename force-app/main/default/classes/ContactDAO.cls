public with sharing class ContactDAO {
    
    public static List<Contact> buscarContatosPorIdConta(Set<Id> setIdContas){

        return [
            SELECT Id, AccountId FROM Contact WHERE AccountId =: setIdContas
        ];
    }


    public static List<Contact> buscarContatosPorIdConta(Id idConta){

        return [
            SELECT Id, AccountId FROM Contact WHERE AccountId =: idConta
        ];

    }

    public static Contact buscarUnicoContatoPorId(Id idContato){
        return [
            SELECT Id, FirstName, LastName FROM Contact WHERE Id = :idContato
        ];
    }
}


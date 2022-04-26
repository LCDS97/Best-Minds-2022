public with sharing class AulaListas {
    public static void MapExemplo(){
        Map<Id,Account> mapcontaPorId = new Map<Id, Account>();
        List<Account> listAccount = [ SELECT Id, Name FROM Account];

        for(Account conta : listAccount) {
            mapcontaPorId.put(conta.Id, conta);
        }

        System.debug(JSON.serialize(mapcontaPorId));
    }
}

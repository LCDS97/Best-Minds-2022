public class MetodosFuturos {
    @future
    public static void goodbyeWorldFuture(Id accountId){
        Account conta = [SELECT Id, Name FROM Account WHERE Id =: accountId];

        account.name = 'Rafael';

        update account;
        System.debug(account);
    }

    public void chamandoMetodoFuturo(){
        MetodosFuturos.goodbyeWorldFuture(accountId);
    }
}

// Criar um método Futuro 

public class MetodosFuturos {
    @future
    public static void goodbyeWorldFuture(Id accountId){
        Account account = [SELECT Id, Name FROM Account WHERE Id =: accountId];

        account.name = 'Rafael';

        update account;
        System.debug(account);
    }

/*     public void chamandoMetodoFuturo(){
        MetodosFuturos.goodbyeWorldFuture(account);
    } */
}

// Criar um método Futuro 

@isTest
private class DadosBancariosBOTest{
    @TestSetup
    static void carregaDados(){
        List<Account> contas = new List<Account>();
        
        
        contas.add(new Account(
            Name='Nome Teste'
            ));

        insert contas;
    }
}
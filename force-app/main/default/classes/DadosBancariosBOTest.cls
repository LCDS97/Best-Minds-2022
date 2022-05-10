@isTest
private class DadosBancariosBOTest{
    @TestSetup
    static void dataSetup(){
        TestDataFactory.gerarConta();
        
    }

    @isTest
    static void insereDadosBancariosSucesso(){
        Account conta = [SELECT Id FROM Account LIMIT 1];

        User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');
        DadosBancariosBO classDB = new DadosBancariosBO();

        System.runAs(user){
            Test.startTest();
                classDB.insereDadosBancarios(conta.Id,'Itaú',123,456);
            Test.stopTest();
        }

        DadosBancarios__c dbTest = [SELECT Conta__c, Banco__c, Agencia__c, NumeroConta__c FROM DadosBancarios__c WHERE Conta__c =: conta.Id];

        System.assertEquals(conta.Id, dbTest.Conta__c);
        System.assertEquals('Itaú', dbTest.Banco__c);
        System.assertEquals(123, dbTest.Agencia__c);
        System.assertEquals(456, dbTest.NumeroConta__c);
    }

    @isTest
    static void insereDadosBancariosBancoNaoExiste(){
        String messageError;
        Account conta = [SELECT Id FROM Account LIMIT 1];

        User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');
        DadosBancariosBO classDB = new DadosBancariosBO();

        System.runAs(user){
            Test.startTest();
                try {
                    classDB.insereDadosBancarios(conta.Id,'Banco Falso',123,456);
                } catch (Exception e) {
                    messageError = e.getMessage();
                }
            Test.stopTest();
            System.assertEquals('Banco não disponível para inserção!', messageError);
        }
    }

    @isTest
    static void insereDadosBancariosBancoValorNumeroContaZero(){
        String messageError;
        Account conta = [SELECT Id FROM Account LIMIT 1];

        User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');
        DadosBancariosBO classDB = new DadosBancariosBO();

        System.runAs(user){
            Test.startTest();
                try {
                    classDB.insereDadosBancarios(conta.Id,'Santander',0,456);
                } catch (Exception e) {
                    messageError = e.getMessage();
                }
            Test.stopTest();
            System.assertEquals('Agência e Número de Conta não podem ser igual a zero!', messageError);
        }
    }

    @isTest
    static void insereDadosBancariosBancoValorAgenciaZero(){
        String messageError;
        Account conta = [SELECT Id FROM Account LIMIT 1];

        User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');
        DadosBancariosBO classDB = new DadosBancariosBO();

        System.runAs(user){
            Test.startTest();
                try {
                    classDB.insereDadosBancarios(conta.Id,'Santander',132,0);
                } catch (Exception e) {
                    messageError = e.getMessage();
                }
            Test.stopTest();
            System.assertEquals('Agência e Número de Conta não podem ser igual a zero!', messageError);
        }
    }
}
@isTest

private class ContractBOAtividadeTest{

  @TestSetup
  static void makeData(){
      TestDataFactory.gerarContasComDadosBancariosContratos(1,1,1);
      TestDataFactory.gerarContasComDadosBancariosContratos(1,1,0);
  }


    @isTest
    private static void criarTarefaSucesso(){
      List<Contract> lstContrato = [SELECT Id, AccountId From Contract];

      User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');

      System.runAs(user){
        Test.startTest();
          ContractBOAtividade.getInstance().criarTarefa(lstContrato);
        Test.stopTest();
      }


    }

     @isTest
    private static void criarTarefaSemDadosBancarios(){

      List<Account> lstContas = [SELECT Id, ( SELECT Id From DadosBancarios__r ) FROM Account];

      Set<Id> setIdAccounts = new Set<Id>();

      for(Account conta : lstContas){
        if(conta.DadosBancarios__r.isEmpty()){
          setIdAccounts.add(conta.Id);
        }
      }

      Account conta = [SELECT Id FROM Account WHERE Id =: SetIdAccounts LIMIT 1];
      List<Contract> lstContratos = [SELECT Id, AccountId FROM Contract WHERE AccountId = :setIdAccounts];
      Task taskTest = [SELECT WhatId, ActivityDate, Subject FROM Task WHERE WhatId =: conta.Id LIMIT 1];
      User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');

      conta.OwnerId = user.Id;
      update conta;

      for(Contract contrato: lstContratos){
        contrato.AccountId = conta.Id;
      }
      update lstContratos;

      System.runAs(user){
        Test.startTest();
          ContractBOAtividade.getInstance().criarTarefa(lstContratos);
        Test.stopTest();
      }


      System.assertEquals(conta.Id, taskTest.WhatId);
      System.assertEquals(Date.today(), taskTest.ActivityDate);
      System.assertEquals('Necessário cadastrar os dados bancários do cliente', taskTest.Subject);


    }

    @isTest
    private static void criarTarefaListaContratosVazios(){
      String messageError;
      List<Contract> lstContrato = new List<Contract>();

      User user = TestDataFactory.gerarUsuario(true, 'Custom: Sales Profile');

      System.runAs(user){
        Test.startTest();
          try {
            ContractBOAtividade.getInstance().criarTarefa(lstContrato);
          } catch (Exception e) {
            messageError = e.getMessage();
            System.assertEquals(messageError, e.getMessage(), 'A lista de contratos passada está vazia!');
          }
        Test.stopTest();
      }

    }
}
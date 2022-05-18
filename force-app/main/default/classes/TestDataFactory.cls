@isTest

public class TestDataFactory{

    public static void gerarConta(){
        List<Account> conta = new List<Account>();
        
        
        conta.add(new Account(
            Name='Nome Teste'
            ));

        insert conta;
    }

    public static List<Account> gerarContasComDadosBancariosContratos(Integer numAccts, Integer numcontratoPerAcct, Integer numDadosBancariosPerAcct){

      List<Account> accts = new List<Account>();
      for(Integer i=0;i<numAccts;i++) {
          Account a = new Account(Name='TestAccount' + i);
          accts.add(a);
      }
      insert accts;

      List<Contract> contrato = new List<Contract>();

      for(Integer c = 0; c < numAccts; c++){
        Account acct = accts[c];

        for(Integer k = 0; k < numcontratoPerAcct; k++){
          contrato.add(new Contract(
            Status='Draft',
            //CreatedDate=TODAY(),
            ContractTerm=12,
            AccountId=acct.Id));
        }
      }

      insert contrato;

      List<DadosBancarios__c> DadosBancarios = new List<DadosBancarios__c>();

      for(Integer c = 0; c < numAccts; c++){
        Account acct = accts[c];

        for(Integer k = 0; k < numDadosBancariosPerAcct; k++){
          DadosBancarios.add(new DadosBancarios__c(
            Conta__c = acct.Id,
            Agencia__c = 1234,
            NumeroConta__c = 4321
            ));
        }
      }

      insert DadosBancarios;
      return accts;
    }

    public static List<Account> criarContaComContato(Integer numAccts, Integer numCttsPerAcct){
      
      List<Account> accts = new List<Account>();
      for(Integer i=0;i<numAccts;i++) {
          Account a = new Account(Name='TestAccount' + i);
          accts.add(a);
      }
      insert accts;

      List<Contact> ctts = new List<Contact>();

      for(Integer c = 0; c < numAccts; c++){
        Account acct = accts[c];

        for(Integer k = 0; k < numCttsPerAcct; k++){
          ctts.add(new Contact(
            FirstName='Contato',
            LastName='Sobrenome ' + k,
            AccountId=acct.Id));
        }
      }
      insert ctts;
      return accts;
      
    }

    public static User gerarUsuario(Boolean opcaoDml, String strPerfil) {
        Profile objPerfil =[SELECT Id, Name FROM Profile WHERE Name =: strPerfil LIMIT 1 ];
        Long currentTimeMillis = System.currentTimeMillis();
        String emailUsuario = 'email+' + currentTimeMillis + '@bestminds.com';
        User usuarioComPapel = new User(
          FirstName = 'Nome',
          LastName = 'Sobrenome',
          Email = emailUsuario,
          Username = emailUsuario + '.' + currentTimeMillis,
          CompanyName = 'Everymind',
          Title = 'Desenvolvedor',
          Alias = 'nomsob',
          TimeZoneSidKey = 'America/Sao_Paulo',
          EmailEncodingKey = 'UTF-8',
          LanguageLocaleKey = 'pt_BR',
          LocaleSidKey = 'pt_BR',
          ProfileId = objPerfil.Id
        );
        if (opcaoDml)
          insert usuarioComPapel;
        return usuarioComPapel;
      }
      public static void atribuirPermissionSetToUser(User user, String permissionSetName) {
          PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName];
          PermissionSetAssignment psa = new PermissionSetAssignment();
          psa.AssigneeId = user.Id;
          psa.PermissionSetId = ps.Id;
          insert psa;
      }
}



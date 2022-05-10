@isTest

public class TestDataFactory{

    public static void gerarConta(){
        List<Account> conta = new List<Account>();
        
        
        conta.add(new Account(
            Name='Nome Teste'
            ));

        insert conta;
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
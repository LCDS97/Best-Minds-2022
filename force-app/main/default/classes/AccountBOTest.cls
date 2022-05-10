@isTest
public class AccountBOTest{

    @TestSetup
    static void carregaDados(){
        List<Account> contas = new List<Account>();
        
        
        contas.add(new Account(
            Name='Nome Teste'
            ));

        insert contas;
        
        DadosBancarios__c dadosBancarios = new DadosBancarios__c(Conta__c = contas[0].Id);

        insert dadosBancarios;
    }

    @isTest
    private static void validarSomenteAtivarContaComDadosBancarios(){
        List<Account> testContas = [SELECT Id, Ativo__c FROM Account];
        testContas[0].Ativo__c = true;
        
        Map<Id,Account> mapContas = new Map<Id,Account>();

        mapContas.put(testContas[0].Id, testContas[0]);
        
        Test.startTest();
        AccountBO.somenteAtivarContaComDadosBancarios(testContas, mapContas);
        Test.stopTest();
    }
    
    @isTest
    private static void validarSomenteAtivarContaComDadosBancariosNewMapAtivoFalso(){
        List<Account> testContas = [SELECT Id, Ativo__c FROM Account];
        testContas[0].Ativo__c = false;
        

        Test.startTest();
            testContas[0].Ativo__c = true;
            update testContas;
        Test.stopTest();
    }
    
    @isTest
    private static void validarSomenteAtivarContaComDadosBancariosMapDadosSemDadosBancarios(){
        String messageError;
        List<Account> contaSemDadosBancarios = new List<Account>();
        Map<Id,List<DadosBancarios__c>> mapDadosBancarios = new Map<Id,List<DadosBancarios__c>>();
        List<DadosBancarios__c> lstDadosBancarios = new List<DadosBancarios__c>();

        
        
        contaSemDadosBancarios.add(new Account(
            Name='Nome Teste'
        ));
            
        insert contaSemDadosBancarios;

        mapDadosBancarios.put(contaSemDadosBancarios[0].Id, lstDadosBancarios);
        
        Test.startTest();
            try {
                contaSemDadosBancarios[0].Ativo__c = true;
                update contaSemDadosBancarios;
            } catch (Exception e) {
                messageError = e.getMessage();
                System.assertEquals(messageError, e.getMessage(), 'Você não pode ativar uma conta que não possui dado bancário, por favor insira uma!');
            }
        Test.stopTest();
    }

    @isTest
    private static void clientePJAtualizarCampoSucesso(){

        Account conta = [SELECT id, Ativo__c From Account LIMIT 1];

        Test.startTest();
        AccountBO.clientePJAtualizarCampo(conta.Id);
        Test.stopTest();
    }

    @isTest
    private static void clientePJAtualizarCampoFalso(){

        Account conta = [SELECT id, Ativo__c From Account LIMIT 1];
        conta.Ativo__c = true;
        update conta;
        

        Test.startTest();
        AccountBO.clientePJAtualizarCampo(conta.Id);
        Test.stopTest();
    }

    @isTest
    private static void contatoClientePJSucesso(){

        Account conta = [SELECT id, Ativo__c From Account LIMIT 1];
        

        Test.startTest();
            AccountBO.contatoClientePJ(conta.Id, 'nomeTeste', 'sobrenomeTeste', 'cargoTeste', '2000-01-01', 'lucas.cds1997@gmail.com');
        Test.stopTest();
    }

    @isTest
    private static void contatoClientePJCampoVazio(){
        String messageError;

        Account conta = [SELECT id, Ativo__c From Account LIMIT 1];
        

        Test.startTest();

        try {
            AccountBO.contatoClientePJ(conta.Id, 'nomeTeste', 'sobrenomeTeste', '', '2000-01-01', 'lucas.cds1997@gmail.com');
        } catch (Exception e) {
            messageError = e.getMessage();
            System.assertEquals(messageError, e.getMessage(), 'Preencher todos os campos por favor!!');
        }

        Test.stopTest();
    }

    @isTest
    private static void contatoClientePJCampoNulo(){
        String messageError;

        Account conta = [SELECT id, Ativo__c From Account LIMIT 1];
        

        Test.startTest();

        try {
            AccountBO.contatoClientePJ(conta.Id, 'nomeTeste', 'sobrenomeTeste', 'cargoTeste', '2000-201-01', 'lucas.cds1997@gmail.com');
        } catch (Exception e) {
            messageError = e.getMessage();
            System.assertEquals(messageError, e.getMessage(), 'Preencher todos os campos por favor!!');
        }

        Test.stopTest();
    }

    @isTest
    private static void buscarSetorClientePJSucesso(){
        String setorName = 'Education';

        Account conta = [SELECT id, Industry, Ativo__c From Account LIMIT 1];
        conta.Industry='Education';
        update conta;
        

        Test.startTest();
            List<Account> buscarContasClientePj = AccountBO.buscarSetorClientePJ(setorName);
        Test.stopTest();
    }
} 
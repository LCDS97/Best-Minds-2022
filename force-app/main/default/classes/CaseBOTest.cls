@isTest
private class CaseBOTest {
    @TestSetup
    static void makeData(){
        Case objCase = new Case();
        objCase.status = 'New';
        objCase.Origin = 'Web';
        insert objCase;
    }
    
    @isTest 
    static void atualizacaoStatusCaseSucesso(){
        Case objCase = [SELECT Id FROM Case LIMIT 1];
        Test.startTest();
        CaseBO.atualizaStatusCaso(objCase.Id, 'Working');
        Test.stopTest();
        objCase = [SELECT Id, Origin, Status FROM Case WHERE Id = :objCase.Id];
        system.assertEquals('Working', objCase.Status);
        system.assertEquals('Email', objCase.Origin);
    }

    @isTest 
    static void atualizacaoStatusCaseStatusNaoExistente(){
        String messageError;

        Case objCase = [SELECT Id FROM Case LIMIT 1];

        Test.startTest();
        try {
            CaseBO.atualizaStatusCaso(objCase.Id, 'Errado');
        } catch (Exception e) {
            messageError = e.getMessage();
            System.assertEquals('Status inserido é inválido!', messageError);
        }
        Test.stopTest();

    }

    @isTest 
    static void atualizacaoStatusCaseIdNulo(){
        String messageError;
        
        Test.startTest();
        try {
            CaseBO.atualizaStatusCaso(null, 'Working');
        } catch (Exception e) {
            messageError = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals('Não encontrado nenhum caso para esse Id.', messageError);
    }
}
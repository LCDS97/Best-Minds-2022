@isTest
public class ContractBOTest{

    @TestSetup
    static void criarContasComContato(){
        Account [] contas = TestDataFactory.criarContaComContato(3, 4);
    }

    @isTest
    private static void validarCriarTarefa(){
        
    }
}


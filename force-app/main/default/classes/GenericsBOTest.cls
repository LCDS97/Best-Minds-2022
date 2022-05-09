@isTest
private class GenericsBOTest {
    @isTest
    static void somaCalculoSucesso(){
        Decimal resultadoSoma = GenericsBO.somarValores(1, 1);
        System.assertEquals(2, resultadoSoma);
    }
    @isTest
    static void somaCalculoNulo(){
        String messageError = '';
        try {
            Decimal resultadoSoma = GenericsBO.somarValores(null, 1);
        } catch (Exception e) {
            messageError = e.getMessage();
        }
        System.assertEquals('O valor 1 não pode ser nulo', messageError);
    }
    @isTest
    static void subtrairCalculoSucesso(){
        Decimal resultadoSubtrair = GenericsBO.subtrairValores(3, 2);
        System.assertEquals(1, resultadoSubtrair);
    }

    @isTest
    static void multiplicarValores(){
        Decimal resultadoMult = GenericsBO.multiplicarValores(5, 1);
        System.assertEquals(5, resultadoMult);
    }

    
}
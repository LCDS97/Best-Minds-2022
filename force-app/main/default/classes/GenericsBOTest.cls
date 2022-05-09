@isTest
private class GenericsBOTest {

    @TestSetup
    static void makeData(){
        List<String> lst1 = new List<String>();
        List<String> lst2 = new List<String>();

        lst1.add('OK');
        lst1.add('Okay');
        lst1.add('Okay');

        lst2.add('OK');
        lst2.add('Okay');
        lst2.add('Okay');
        lst2.add('veremos');
    }

    @isTest
    static void comparaListasSucesso(){
        List<String> lst1 = new List<String>();
        List<String> lst2 = new List<String>();

        lst1.add('OK');
        lst1.add('Okay');
        lst1.add('Okay');

        lst2.add('OK');
        lst2.add('Okay');
        lst2.add('Okay');
        lst2.add('veremos');


        Integer resultadoItensIguais = GenericsBO.comparacaoItensLista(lst1, lst2);
        System.assertEquals(2, resultadoItensIguais);
    }
    @isTest
    static void comparaLista1Nula(){
        String messageError;
        List<String> lst1 = new List<String>();
        List<String> lst2 = new List<String>();


        lst2.add('OK');
        lst2.add('Okay');
        lst2.add('Okay');
        lst2.add('veremos');

        try {
            if(lst1.isEmpty()){
                Integer resultadoItensIguais = GenericsBO.comparacaoItensLista(lst1, lst2);
            }
        } catch (Exception e) {
            messageError = e.getMessage();
            System.assertEquals('A lista esta vazia! A lista vazia é a Lista 1', messageError);
        }

    }
    @isTest
    static void comparaLista2Nula(){
        String messageError;
        List<String> lst1 = new List<String>();
        List<String> lst2 = new List<String>();


        lst1.add('OK');
        lst1.add('Okay');
        lst1.add('Okay');
        lst1.add('veremos');

        try {
            if(lst2.isEmpty()){
                Integer resultadoItensIguais = GenericsBO.comparacaoItensLista(lst1, lst2);
            }
        } catch (Exception e) {
            messageError = e.getMessage();
            System.assertEquals('A lista esta vazia! A lista vazia é a Lista 2', messageError);
        }

    }

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
    static void multiplicarValoresSucesso(){
        Decimal resultadoMult = GenericsBO.multiplicarValores(5, 1);
        System.assertEquals(5, resultadoMult);
    }

    @isTest
    static void dividirValoresSucesso(){
        Decimal resultadoDivisao = GenericsBO.dividirValores(10, 2);
        System.assertEquals(5, resultadoDivisao);
    }

    @isTest
    static void everyMindSeteAnos(){
        String stringResultado = GenericsBO.everymindSeteAnos('Legal');
        System.assertEquals('Legal #Everymind 7 anos', stringResultado);
    }

    @isTest
    static void mediaCincoValoresSucesso(){
        Decimal resultadoMedia = GenericsBO.mediaCincoValores(5, 5, 5, 5, 5);
        System.assertEquals(5, resultadoMedia);
    }

    @isTest
    static void concatenarStringSucesso(){
        String resultadoString = GenericsBO.concatenarString('Legal','Texto');
        System.assertEquals('Legal Texto', resultadoString);
    }

    @isTest
    static void quantidadeStringSucesso(){
        Integer resultadoContagemString = GenericsBO.quantidadeString('dois');

        System.assertEquals(4, resultadoContagemString);
    }



    
}
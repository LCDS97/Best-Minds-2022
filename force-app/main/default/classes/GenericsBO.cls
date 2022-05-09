public with sharing class GenericsBO {

    public class ListaVaziaException extends Exception{}
    public class CalculoNumero2 extends Exception{}

    public static Integer comparacaoItensLista(List<String> lista1,List<String> lista2){
        Set<String> valoresUnicos = new Set<String>();
        
        try {
            if(lista1.isEmpty()){
                throw new ListaVaziaException('A lista esta vazia! A lista vazia é a Lista 1');
            }
            if(lista2.isEmpty()){
                throw new ListaVaziaException('A lista esta vazia! A lista vazia é a Lista 2');
            }

            for(String item1 : lista1){
                for(String item2: lista2){
                    if(item1 == item2){
                        valoresUnicos.add(item1);
                    }
                }
            }

        } catch (ListaVaziaException e) {
            System.debug('### ExceptionListaVazia' + e.getMessage());
        }catch (Exception e) {
            System.debug('### Exception Padrão '  + e.getMessage());
            
        }
        Integer valoresRepetidos = valoresUnicos.size(); 
        System.debug('Itens iguais é ' + valoresRepetidos);
        return valoresRepetidos;
    }

            // 1 - Cria um método que receba dois valores numéricos e retorne a soma dos dois valores
            public static Decimal somarValores(Decimal primeiroValor, Decimal segundoValor) {

                if(primeiroValor == null){
                    AuraHandledException e = new AuraHandledException('O valor 1 não pode ser nulo');
                    e.setMessage('O valor 1 não pode ser nulo');
                    throw e;
                }

                Decimal resultadoSoma = primeiroValor + segundoValor;
        
                return resultadoSoma;
            }
            // 2 - Cria um método que receba dois valores numéricos e retorne a subtração dos dois valores
            public static Decimal subtrairValores(Decimal primeiroValor, Decimal segundoValor) {
                Decimal resultadoSubtracao = primeiroValor - segundoValor;
        
                return resultadoSubtracao;
            }
            // 3 - Cria um método que receba dois valores numéricos e retorne a multiplicação dos dois valores
            public static Decimal multiplicarValores(Decimal primeiroValor, Decimal segundoValor) {
                Decimal resultadoMultiplicacao = primeiroValor * segundoValor;
        
                return resultadoMultiplicacao;
            }
            // 4 - Cria um método que receba dois valores numéricos e retorne a divisão dos dois valores
            public static Decimal dividirValores(Decimal primeiroValor, Decimal segundoValor) {
                Decimal resultadoDivisao = primeiroValor / segundoValor;
        
                return resultadoDivisao;
            }
        
            // 5 - Cria um método que receba um texto e retorne o mesmo texto concatenado com o texto "#Everymind7anos"
            public static String everymindSeteAnos(String texto){
                String resultadoString = texto + ' #Everymind 7 anos';
                
                return resultadoString;
            }
        
            // 6 - Criar um método que receba 5 valores numéricos e retorne a média entre eles
            public static Decimal mediaCincoValores(
                                                Decimal valorUm,
                                                Decimal valorDois,
                                                Decimal valorTres,
                                                Decimal valorQuatro,
                                                Decimal valorCinco ){
                Decimal somaTotal = valorUm + valorDois + valorTres + valorQuatro + valorCinco;
        
                Decimal mediaValor = somaTotal / 5;
                                                
                return mediaValor;
                }
        
            // 7 - Cria um método que receba dois valores do Tipo String e retorne os dois concatenados
            public static String concatenarString(String textoUm, String textoDois){
                String resultadoConcatenar = textoUm + ' ' + textoDois;
                
                return resultadoConcatenar;
            }
            // 8 - Cria um método que receba um valor do tipo String e retorne a quantidade de caracteres dessa String
            public static Integer quantidadeString(String contarCaracteres){
        
                // Tratando texto para retirar espaços e contar somente os caracteres
                String pegarTexto = contarCaracteres.replaceAll(' ','');
        
                Integer resultadoContagem = pegarTexto.length();
        
                return resultadoContagem;
        
            }
}

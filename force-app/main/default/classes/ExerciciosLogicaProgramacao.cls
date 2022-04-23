public class ExerciciosLogicaProgramacao {
    // 1 - Cria um método que receba dois valores numéricos e retorne a soma dos dois valores
    public static Decimal somarValores(Decimal primeiroValor, Decimal segundoValor) {
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


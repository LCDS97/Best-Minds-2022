public with sharing class ExerciciosLacosRepeticao {

    public class ContaInativaException extends Exception{}
    public class ContatoNaoExistenteException extends Exception{}
    public class ValorBonusZeradoException extends Exception{}

    /* 1 - Criar um método que insira vários registros de Oportunidade.
    Este método deve receber um valor inteiro que representará a quantidade de Oportunidade a serem criadas
        1. Paramêtros:
            1. Id do Cliente (Id)
            2. Id do Contato (Id)
            3. Número de Oportunidades (Integer)
            4. Valor das Oportunidades (Decimal)
        2. Regras:
            1. O Nome da Oportunidade deve ser o número da Oportunidade que está sendo criada + nome da Conta,
            por exemplo: 1 - Conta Teste, 2 - Conta Teste...
    */
    public static void criarOportunidadePorQuantidade(Id idCliente, Id idContato, Integer numeroOportunidades, Decimal valorOportunidade){
        Account nomeOportunidade = [SELECT Id, Name FROM Account WHERE Id =: idCliente ];

        List<Opportunity> oportunidadesParaCadastrar = new List<Opportunity>();
        System.debug('Lista antes do While:' + oportunidadesParaCadastrar);
        
        Integer contador = 1;
        while(contador <= numeroOportunidades){
            Opportunity novaOportunidadeClientePJ = new Opportunity();
            novaOportunidadeClientePJ.AccountId = idCliente;
            novaOportunidadeClientePJ.Contato__c = idContato;
            novaOportunidadeClientePJ.Name = contador + ' - ' + nomeOportunidade.Name;
            novaOportunidadeClientePJ.StageName = 'Prospecting';
            novaOportunidadeClientePJ.CloseDate = date.today().addMonths(2);
            oportunidadesParaCadastrar.add(novaOportunidadeClientePJ);
            contador++;
            System.debug('Lista :' + oportunidadesParaCadastrar);
            System.debug('Oportunidade :' + novaOportunidadeClientePJ);
        }
        System.debug('Lista depois do While:' + oportunidadesParaCadastrar);
        insert oportunidadesParaCadastrar;

    }

    // 2 - Criar um método que receba uma lista de Oportunidades e retorna a quantidade de oportunidades que possui o valor maior que R$10.000,00
    
    public static Integer listaOportunidadesMenor(List <Opportunity> oportunidadeParams){
        Integer quantidadeOportunidades = 0;
        
        for( Opportunity oportunidade : oportunidadeParams){
            if( oportunidade.Amount > 10000){
                quantidadeOportunidades++;
            }
        }
        System.debug(quantidadeOportunidades);
        return quantidadeOportunidades;
    }
    
    /*
       3 - Criar um método que cria um registro no Objeto Bonûs para uma lista de contatos para uma lista de contatos de uma Conta
        1. Paramêtros: 
            1. Id da Conta (Id)
            2. Lista de Contatos (List<Contact>)
            3. Valor (Decimal)
        2. Validações
            1. Se a conta estiver inativa, é necessário lançar uma exceção indicando o erro
            2. Caso a lista recebida no paramêtro não possua nenhum item, lançar uma exceção informando que não possui Contatos
            3. Caso o valor da proposta seja menor ou igual a zero, lançar uma exceção informando o valor deve ser maior que zero
    */
    public static void criarBonusParaContatos(Id IdAccount, List<Contact> listContatos, Decimal valorBonus){

        
        try {
            Account buscarConta = [SELECT Id, Ativo__c FROM Account WHERE Id =: IdAccount];
            if(!buscarConta.Ativo__c){
                throw new ContaInativaException('É necessário a conta estar ativa!');
            }
            if(listContatos.isEmpty()){
                throw new ContatoNaoExistenteException('É Necessário ter contatos na lista');
            }
            if(valorBonus <= 0){
                throw new ValorBonusZeradoException('É Necessário o valor do Bônus maior que zero');
            }
            
        } catch (ContaInativaException e) {
            System.debug('#### ContaInativaException: ' + e.getMessage());
        } catch (ContatoNaoExistenteException e) {
            System.debug('#### ContatoNaoExistenteException: ' + e.getMessage());
        } catch (ValorBonusZeradoException e) {
            System.debug('#### ValorBonusZeradoException: ' + e.getMessage());
        } catch (Exception e) {
            System.debug('#### Exception Padrao: ' + e.getMessage());
            
        }
    }
}

public with sharing class ExerciciosLacosRepeticao {
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
            novaOportunidadeClientePJ.ContactId = idContato;
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
}

public with sharing class OpportunityBO {
    
    public static void atrelarUnicoContato(List<Opportunity> lstOpportunitiesTrigger){
/* 
    5 - Crie um Apex Trigger que, ao criar um registro de oportunidade (Opportunity),
        verifique se o Contato (Contact) não foi preenchido e se a Conta (Account) vinculada possui apenas 1 Contato (Contact).
            Caso isso aconteça, vincule automaticamente esse Contato (Contact) na Oportunidade (Opportunity). 
*/

    Set<Id> setFiltrarContaPorId = new Set<Id>();
    List<Opportunity> lstOportunidades = new List<Opportunity>();

    for(Opportunity oportunidade : lstOpportunitiesTrigger){

        if(oportunidade.ContactId == null){
            setFiltrarContaPorId.add(oportunidade.AccountId);
            lstOportunidades.add(oportunidade);
        }
    
    
    }
    
    if(lstOportunidades.isEmpty()) return;

    List<Contact> lstVerificarContatosPorConta = ContactDAO.buscarContatosPorIdConta(setFiltrarContaPorId);

        if(lstVerificarContatosPorConta.size() ==  1){

            for(Opportunity oportunidade : lstOportunidades){

                for(Contact contatoUnico : lstVerificarContatosPorConta){
                    oportunidade.Contato__c = contatoUnico.Id;
                }
            }
        }
    }

    // Desafio de Map na Aula de Trigger
    public static Map<Id,Integer> mapContaOportunidades(){
        Integer contador;
        
        Map<Id, Integer> mapQtdePorConta = new Map<Id, Integer>();
        List<Opportunity> oportunidades = OpportunityDAO.buscarOportunidadesContas(); // Aqui eu retorno o Id da Oportunidade e Id da Conta

            for(Opportunity oportunidade : oportunidades) {

                    
                    if(mapQtdePorConta.containsKey(oportunidade.AccountId)){
                        contador = mapQtdePorConta.get(oportunidade.AccountId);
                    }
                    else {
                        
                        contador = 0;
                    }
                    contador++;
                    mapQtdePorConta.put(oportunidade.AccountId,contador);
                }
        
            return mapQtdePorConta;
    }


    public static void atualizarValorOpp(Id idOportunidade, Decimal valorOportunidade){
        
        Opportunity oportunidadeAtualizar = new Opportunity();
        oportunidadeAtualizar.Id = idOportunidade;
        oportunidadeAtualizar.Amount = valorOportunidade;
                
        update oportunidadeAtualizar;
                
    }

    public static void criarOportunidadePorQuantidade(Id idCliente, Id idContato, Integer numeroOportunidades, Decimal valorOportunidade){
        
        Account nomeOportunidade = AccountDAO.buscarContaPorId(idCliente);

        List<Opportunity> oportunidadesParaCadastrar = new List<Opportunity>();
        
        Integer contador = 1;

        while(contador <= numeroOportunidades){

            Opportunity novaOportunidadeClientePJ = new Opportunity();
            novaOportunidadeClientePJ.AccountId = idCliente;
            novaOportunidadeClientePJ.Contato__c = idContato;
            novaOportunidadeClientePJ.ContactId = idContato;
            novaOportunidadeClientePJ.Name = contador + ' - ' + nomeOportunidade.Name;
            novaOportunidadeClientePJ.StageName = 'Prospecting';
            novaOportunidadeClientePJ.CloseDate = date.today().addMonths(2);
            oportunidadesParaCadastrar.add(novaOportunidadeClientePJ);

            contador++;
        }

        insert oportunidadesParaCadastrar;

    }

    public static Integer listaOportunidadesMaior(List <Opportunity> oportunidadeParams, Integer valorFiltrar){
        Integer quantidadeOportunidades = 0;
        
        for( Opportunity oportunidade : oportunidadeParams){

            if( oportunidade.Amount > valorFiltrar){
                quantidadeOportunidades++;
            }
        }

        return quantidadeOportunidades;
    }



    
}

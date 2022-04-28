public with sharing class DesafioApexCorreto {
    public static void queryForaDoFor(){
        Set<String> listaContas = new Set<String>();
        List<Opportunity> listaOportunidades = new List<Opportunity>();
        Integer contador = 0;
        
        // mapContasComOportunidades.put('<ID_DA_CONTA>', <LISTA_DE_OPORTUNIDADES>);
        Map<Id, Integer> mapQtdePorConta = new Map<Id, Integer>();
        List<Opportunity> oportunidades = [SELECT Id, AccountId FROM Opportunity]; // Aqui eu retorno o Id da Oportunidade e Id da Conta

            for(Opportunity oportunidade : oportunidades) {
                    listaContas.add(oportunidade.AccountId);
                    contador++;
                   //mapQtdePorConta.put(oportunidade.AccountId,contador);
                    if(listaContas.contains(oportunidade.AccountId)){
                        mapQtdePorConta.put(oportunidade.AccountId,contador);
                    }
                    //mapQtdePorConta.put(oportunidade.AccountId,contador);
                    contador = 0;
                }
        
            System.debug('####### Lista Contas =>' + JSON.serialize(listaContas));
            System.debug('####### MAp =>' + mapQtdePorConta);
        }
        public static Map<Id,Integer> mapDesafioBruno(){
            Integer contador;
            
            Map<Id, Integer> mapQtdePorConta = new Map<Id, Integer>();
            List<Opportunity> oportunidades = [SELECT Id, AccountId FROM Opportunity]; // Aqui eu retorno o Id da Oportunidade e Id da Conta
    
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
            
                System.debug('####### MAp =>' + mapQtdePorConta);
                return mapQtdePorConta;
    }}


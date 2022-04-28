public with sharing class DesafioApexCorreto {

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


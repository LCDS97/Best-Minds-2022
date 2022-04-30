Map<Id, DadosBancarios__c> mapResultado = ExerciciosLacosRepeticao.mapDadosBancarios();

System.debug(JSON.serialize(mapResultado));
System.debug(mapResultado.size());
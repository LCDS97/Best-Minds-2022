public with sharing class ExercicioDML {
	
    public static Parcela__c gerarParcelaContrato(Id idContrato, Decimal valorParcela){
        Parcela__c parcelaContrato = new Parcela__c();
        parcelaContrato.Contrato__c = idContrato;
        parcelaContrato.Moeda__c = valorParcela;
        
        System.debug('##### Parcela Antes Insert => ' + parcelaContrato);
        insert parcelaContrato;
        System.debug('##### Parcela Depois Insert => ' + parcelaContrato);
        return parcelaContrato;
        
    }
    
    //Exemplo de criação de um método para 'Insert' de vários registros que contem valor e id
    public static  List<Parcela__c> gerarVariasParcelaContrato(Id idContrato, List<Decimal> valoresParcela){
        List<Parcela__c> listParcelaInserir = new List<Parcela__c>();
        List<Decimal> listaValoresParcelas = new List<Decimal>();
        Parcela__c parcelaContrato;
        for(Decimal valor:valoresParcela){
            parcelaContrato = new Parcela__c();
            parcelaContrato.Moeda__c = valor;
            parcelaContrato.Contrato__c = idContrato;
            listParcelaInserir.add(parcelaContrato);
        }
        insert listParcelaInserir;
                return listParcelaInserir;
        //Aguardar metodo para testar
    }
}
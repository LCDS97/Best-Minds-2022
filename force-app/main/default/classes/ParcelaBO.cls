public with sharing class ParcelaBO {
    
    public static void atualizeCampoParcela(Id idParcela){
        Parcela__c parcelaAtualizar = new Parcela__c();
        parcelaAtualizar.Id = idParcela;
        parcelaAtualizar.Status__c = 'Paga';
        
        update parcelaAtualizar;
    }
    
    public static void deletarParcela(Id idParcela){
        Parcela__c parcelaDeletar = new Parcela__c();
        parcelaDeletar.Id = idParcela;
        
        delete parcelaDeletar;
    }
    
    public static List<Parcela__c> retornarParcelasMaiorValorDesejado(Integer valorFiltrar){
        List<Parcela__c> listParcelas = ParcelaDAO.retornarParcelasMaiorQueValorDesejado(valorFiltrar);
        
        for(Parcela__c parcela : listParcelas){
            System.debug('Parcela: ' + parcela.Name + ' do Valor R$' + parcela.Moeda__c + ' do Contrato ' + parcela.Contrato__c + ' da Conta: ' + parcela.Contrato__r.Account.Name);
        }
        
        if(listParcelas.size() != 0){
            System.debug('O total de Parcelas maiores que ' + valorFiltrar + ' foi de: ' + listParcelas.size()); 

        }
        else{
            System.debug('Não há parcelas maiores que ' + valorFiltrar);           
			
        }

        return listParcelas;


    }
}

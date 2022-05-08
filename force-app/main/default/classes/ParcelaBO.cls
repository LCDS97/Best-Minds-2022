public with sharing class ParcelaBO {
    
    // 3 - Criar um método que receba o Id de uma Parcela e atualize o campo Status para Paga
    public static void atualizeCampoParcela(Id idParcela){
        Parcela__c parcelaAtualizar = new Parcela__c();
        parcelaAtualizar.Id = idParcela;
        parcelaAtualizar.Status__c = 'Paga';
        
        update parcelaAtualizar;
    }
    
    // 4 - Criar um método que receba o Id de uma Parcela e delete o registro
    public static void deletarParcela(Id idParcela){
        Parcela__c parcelaDeletar = new Parcela__c();
        parcelaDeletar.Id = idParcela;
        
        delete parcelaDeletar;
    }    
}

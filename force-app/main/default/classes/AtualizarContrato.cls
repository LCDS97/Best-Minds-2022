public with sharing class AtualizarContrato {
    @future
    public static void ContarParcelas(Id idContrato){
        List<Parcela__c> lstNumeroParcelasPorContrato = [SELECT Id FROM Parcela__c WHERE Contrato__c =: idContrato];

        Contract contratoParatualizar = new Contract();
        contratoParatualizar.Id = idContrato;
        contratoParatualizar.NumeroParcelas__c = lstNumeroParcelasPorContrato.size();

        update contratoParatualizar;

    }

    public static void ChamarMetodoFeature(Id contrato){
        AtualizarContrato.ContarParcelas(contrato);
        System.debug('o Id de Contrato foi atualizado');
    }
}

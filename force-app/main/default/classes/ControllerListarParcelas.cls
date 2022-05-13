public with sharing class ControllerListarParcelas {
    
    @AuraEnabled
    public static List<ContractBO.ContractTO> buscarParcelasContrato(Id idContrato){
        return ContractBO.buscarParcelasDoContrato(idContrato);
    }
}

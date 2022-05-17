public with sharing class ControllerListarParcelas {
    
    @AuraEnabled
    public static List<ContractBO.ContractTO> buscarParcelasContrato(Id idContrato){
        return ContractBO.buscarParcelasDoContrato(idContrato);
    }

    @AuraEnabled
    public static Boolean salvarParcelas(List<ContractBO.ContractTO> lstParcelas){
        System.debug('####### LST PARCELA =>' + JSON.serialize(lstParcelas));
        return false;
    }
}

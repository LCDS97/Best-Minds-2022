public with sharing class ControllerListarParcelas {
    
    @AuraEnabled
    public static List<ContractBO.ParcelaTO> buscarParcelasContrato(Id idContrato){
        return ContractBO.buscarParcelasDoContrato(idContrato);
    }

    @AuraEnabled
    public static Boolean salvarParcelas(List<ContractBO.ParcelaTO> lstParcelasTO){
        System.debug('###### lstParcelasTO => ' + lstParcelasTO);
        return ContractBO.salvarParcelas(lstParcelasTO);
    }
}

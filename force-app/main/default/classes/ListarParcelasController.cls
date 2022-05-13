public with sharing class ListarParcelasController {
    
    @AuraEnabled
    public static List<ContractBO.ContractTO> buscarParcelasContrato(Id idContrato){
        return ContractBO.buscarParcelasDoContrato(idContrato);
    }
}

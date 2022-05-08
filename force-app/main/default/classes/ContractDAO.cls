public with sharing class ContractDAO {
    
    public static List<Contract> buscarCasosPorIdConta(Set<Id> setIdContas){
        return [
            SELECT Id, AccountId FROM Contract WHERE AccountId IN :setIdContas
        ];
    }

    public static List<Contract> buscarTodosContratos(){
        return [
            SELECT Id FROM Contract
        ];
    }

    public static List<Contract> buscarContratosPorStatus(String statusName){
        return [
            SELECT Id, Status FROM Contract WHERE Status =: statusName
        ];
    }

    public static List<AggregateResult> buscarContratosEmAberto(){
        return [
            SELECT Count(Status) FROM Contract WHERE Status = 'Em Aberto'
        ];
    }
}

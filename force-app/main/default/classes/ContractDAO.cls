public with sharing class ContractDAO {
    
    public static List<Contract> buscarCasosPorIdConta(Set<Id> setIdContas){
        return [
            SELECT Id, AccountId FROM Contract WHERE AccountId IN :setIdContas
        ];
    }
}

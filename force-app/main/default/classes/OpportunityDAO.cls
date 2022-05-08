public with sharing class OpportunityDAO {
    public static List<Opportunity> recuperarOportunidadesPorIdConta (Set<Id> setAccountsId){
        return [
            SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :setAccountsId
        ];
    }

    public static List<Opportunity> buscarOportunidadesContas(){
        return [
            SELECT Id, AccountId FROM Opportunity
        ];
    }

    public static Opportunity oportunidadeMaiorValor(){
        Opportunity oportunidadeComMaiorValor = [SELECT Id, Amount, Name FROM Opportunity ORDER BY Amount DESC NULLS LAST LIMIT 1];
        
        return oportunidadeComMaiorValor;
    }
}


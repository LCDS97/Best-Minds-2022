public with sharing class CaseDAO {
    
    public static List<Case> buscarCasosPorId(Set<Id> idCasos){
        return [
            SELECT
                Id,
                Status
            FROM
                Case
            WHERE
                Id
            IN
                :idCasos 
        ];
    }
}

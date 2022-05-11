public class AccountDAOAula {
    public static List<Account> buscarContasComDadosBancarios (Set<Id> accIds) {
        return [
                SELECT
                    Id,
                    OwnerId,
                    (
                        SELECT 
                            Id
                        FROM
                            DadosBancarios__r
                    )
                FROM
                    Account
                WHERE
                    Id IN : accIds
        ];
    }
}
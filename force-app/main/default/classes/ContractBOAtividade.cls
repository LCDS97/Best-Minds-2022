public class ContractBOAtividade {
    public static ContractBOAtividade instance = new ContractBOAtividade();
    public static ContractBOAtividade getInstance () {
        return instance;
    }
    public void criarTarefa (List<Contract> lstContract) {
        Set<Id> accIds = new Set<Id>();
        List<Account> lstAccWithDadosBancarios = new List<Account>();
        List<Task> lstTaskInsert = new List<Task>(); 
        if(lstContract.isEmpty()){
            throw new ContractBOException('A lista de contratos passada está vazia!');
        }
        for (Contract contract : lstContract) { 
            accIds.add(contract.AccountId);
        }
        lstAccWithDadosBancarios = AccountDAO.buscarContasComDadosBancarios(accIds);
        for (Account acc : lstAccWithDadosBancarios) {
            if (acc.DadosBancarios__r.isEmpty()) {
                Task tsk = new Task();
                tsk.OwnerId = acc.OwnerId;
                tsk.WhatId = acc.Id;
                    tsk.ActivityDate = Date.today();
                tsk.Subject = 'Necessário cadastrar os dados bancários do cliente';
                lstTaskInsert.add(tsk);
            }
        }
        if (!lstTaskInsert.isEmpty()){
            insert lstTaskInsert;
        }
    }
    public class ContractBOException extends Exception {}
}
public with sharing class CaseBO {

    public class AtualizarStatusCasoException extends Exception {}
    
    public static void naoAtivarContratoTipoSinistro(List<Case> lstCasosTriggers){
        /*
    3 - Crie um Apex Trigger que, ao criar ou atualizar um registro de Caso (Case) com o tipo “Sinistro”, valide se a conta vinculada
        possui um Contrato (Contract) ativo. Caso não possua, exibir uma mensagem que ele não pode abrir um sinistro sem um Contrato (Contract) ativo.
        Obs.: Utilizar o método addError.
*/
    
    
    List<Case> lstCasosAtivado = new List<Case>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdCasos = new Set<Id>();
    Map<Id,Boolean> mapEstaComContratos = new Map<Id,Boolean>();
    Map<Id, List<Contract>> mapCasosComContrato = new Map<Id, List<Contract>>();


        for(Case caso : lstCasosTriggers){

            if(caso.Type != 'Sinistro') continue;
            if(caso.AccountId == null) continue;

            setIdCasos.add(caso.AccountId);
            lstCasosAtivado.add(caso);

        }



    if(lstCasosAtivado.isEmpty()){
        return;
    }

    

    List<Contract> lstContratos = ContractDAO.buscarContratosPorIdContaSomenteAtivos(setIdCasos);
    for(Contract contrato : lstContratos){
        if(!mapEstaComContratos.containsKey(contrato.AccountId)){
            mapCasosComContrato.put(contrato.AccountId, new List<Contract>());
        }
        mapCasosComContrato.get(contrato.AccountId).add(contrato);
    }
    
    for(Case caso : lstCasosAtivado){
        if(!mapCasosComContrato.containsKey(caso.accountId)){
            caso.addError('Não é possível ter um Caso do Tipo Sinistro sem um Contrato, por favor, revise essa informação!');
        }
    }

    }

    public static Boolean casoCriado(Id IdAccount, String nomeConta){
        Boolean casoCriado = false;

        try {
            Case novoCaso = new Case();
            novoCaso.AccountId = IdAccount;
            novoCaso.Status = 'New';
            novoCaso.Origin = 'Apex';
            novoCaso.Type = 'Sinistro';
            novoCaso.Subject = 'Cliente ' + nomeConta + ' - Sinistro';
            casoCriado = true;
            insert novoCaso;
               
        } catch (Exception error) {
            System.Debug('### Exception padrão: ' + error);
        }
        return casoCriado;

    }


    public static void atualizaStatusCaso(Id caseId, String Status){
        Set<String> setStatus = new Set<String>{'New', 'Working','Escalated','Closed'};
        if(!setStatus.Contains(Status)){ //Se não conter o status na lista.
            throw new AtualizarStatusCasoException('Status inserido é inválido!');
        }
        List<Case> objCase = [SELECT Id FROM Case WHERE Id = :caseId];
        if(objCase.isEmpty()){
            throw new AtualizarStatusCasoException('Não encontrado nenhum caso para esse Id.');
        }
        objCase[0].Status = Status;
        objCase[0].Origin = 'Email';
        update objCase;
    }

    @future
    public static void metodoFuturoBestMinds(Set<Id> idCasos){
        List<Case> lstCasosFechados = CaseDAO.buscarCasosPorId(idCasos);
        List<CaseComment> lstComentariosCasosFechados = new List<CaseComment>();
        List<Case> lstCasosUpdate = new List<Case>();
        
        for(Case caso: lstCasosFechados){
            caso.Status = 'Escalated';
            CaseComment caseComment = new CaseComment();
            caseComment.CommentBody = 'Exercício Método Futuro Best Minds - Atualizando Casos';
            caseComment.ParentId = caso.Id;
            lstComentariosCasosFechados.add(caseComment);
            lstCasosUpdate.add(caso);


        }

        insert lstComentariosCasosFechados;
        update lstCasosUpdate;
    }


}

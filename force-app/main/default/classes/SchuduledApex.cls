public class SchuduledApex implements Schedulable {
    
    public void execute(SchedulableContext ctx){
        
        List<Case> lstCasosFechados = ([SELECT Id FROM Case WHERE Status = 'Closed']);
        List<CaseComment> lstComentariosCasosFechados = new List<CaseComment>();
        
        for(Case caso: lstCasosFechados){
            CaseComment caseComment = new CaseComment();
            caseComment.CommentBody = 'Caso fechado por ausência do Contrato';
            caseComment.ParentId = caso.Id;
            lstComentariosCasosFechados.add(caseComment);


        }

        insert lstComentariosCasosFechados;

    }

    public class ChamarLista implements Schedulable {
        public void execute (SchedulableContext ctx){
            List<Trainee> lstDosTrainess = ([SELECT Id From Everymind WHERE Role = 'Dev Trainee']);
            List<Kamilist> lstDaKamila = ([SELECT Id From Everymind WHERE Surname = 'Kamilista']);
            for(Trainee trainee : lstDosTrainess ){
                trainee.Presenca = 'Ok';
                trainee.Aula = 'Apex Async';
            }

            insert lstDaKamila;
        }
    }
}

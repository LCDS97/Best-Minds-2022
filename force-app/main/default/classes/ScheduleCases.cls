public class ScheduleCases  implements Schedulable{
    public void execute(SchedulableContext ctx){
        BatchAtribuirContatoMeuCasos batch = new BatchAtribuirContatoMeuCasos();
        String jobId = Database.executeBatch(batch);
    }
}

public class ScheduleAtualizarSalarios implements Schedulable{
    public void execute(SchedulableContext ctx){
        BatchAtualizarSalarios batch = new BatchAtualizarSalarios();
        Database.executeBatch(batch);
    }
}
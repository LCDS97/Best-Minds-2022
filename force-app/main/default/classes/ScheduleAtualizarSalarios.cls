public class ScheduleAtualizarSalarios implements Schedulable{
    public void execute(SchedulableContext ctx){
        ContactBO.DistribuirAltoFaturamento();
    }
}
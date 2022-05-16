DateTime dtCurrentTime = System.now().addminutes(1);
String minute = ''; 
String hour = ''; 
String dayOfMonth = ''; 
String month = '';
String year = '';
String sch = '';
minute = String.ValueOf(dtCurrentTime.minute());
hour = String.ValueOf(dtCurrentTime.hour());
dayOfMonth = String.ValueOf(dtCurrentTime.day());
month = String.ValueOf(dtCurrentTime.month());
year = String.ValueOf(dtCurrentTime.year());   
sch = '0 ' + minute + ' ' + hour + ' ' + dayOfMonth + ' ' + month + ' ? ' + year;

ScheduleAtualizarSalarios schedulere = new ScheduleAtualizarSalarios();

String jobId = System.schedule('ScheduleAtualizarSalarios', sch, schedulere);

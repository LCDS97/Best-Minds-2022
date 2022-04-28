// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

//List<Opportunity> lstOportunidades = [SELECT Id, Amount FROM Opportunity];




Boolean resultado = ExercicioDML.contatoClientePJ('0018b00001xpUKLAA2','','Ribeiro do Lol','Lolzeiro','2000-01-01','nicolaskadosheira@gmail.com');
System.debug('###################################### resultado deu :' + resultado);

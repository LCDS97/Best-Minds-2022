// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

//List<Opportunity> lstOportunidades = [SELECT Id, Amount FROM Opportunity];


//SELECT id FROM Opportunity WHERE AMOUNT > 50000

Boolean resultado = ExercicioDML.contatoClientePJ('0018b00001xUIAIAA4', 'nome', 'contato', 'blz', '1997-02-02', 'email@email.com.br');
System.debug(resultado);
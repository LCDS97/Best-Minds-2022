// Tipos primitivos
/*
String nome = 'Banana Split';
Integer numero = 1;
Decimal numerico = 1.5;
Boolean flag = true;
// Tipos complexos
Account conta = new Account();
conta.Name = nome;
conta.Ativo__c = flag;
insert conta;
Account contaRecuperada = [SELECT Id, Name, Ativo__c FROM Account WHERE Name = 'Nome da conta'];
*/
// Coleções
/* List
Banana    Caqui    Laranja    Melancia
   0         1         2          3
Exemplo de código 1:
String fruta = 'Melancia';
List<String> frutas = new List<String>();
frutas.add('Banana'); Index - 0
frutas.add('Banana'); Index - 1
frutas.add('Laranja'); Index - 2
frutas.add(fruta); Index - 3
frutas.remove(1);
frutas.add(1, 'Caqui');
frutas.size() - Tamanho da lista: 4
String fruta = frutas.get(1) == frutas[1];
for(Integer i = 0; i < frutas.size(); i++) {
    if(frutas[i] == 'Caqui') {
        break;
    }
}
for(String fruta : frutas) {
    if(fruta == 'Caqui') {
        break;
    }
}
Exemplo de código 2:
DadosBancarios__c objDadosBancarios1 = new DadosBancarios__c();
objDadosBancarios1.Agencia__c = 2;
objDadosBancarios1.NumeroConta__c = 22222;
DadosBancarios__c objDadosBancarios2 = new DadosBancarios__c();
objDadosBancarios2.Agencia__c = 1;
objDadosBancarios2.NumeroConta__c = 11111;
List<DadosBancarios__c> lstDadosBancarios = new List<DadosBancarios__c>();
lstDadosBancarios.add(objDadosBancarios1); - Index: 0
lstDadosBancarios.add(objDadosBancarios2); - Index: 1
*/
/* Set
Banana
Set<String> setFrutas = new Set<String>();
setFrutas.add('Banana');
setFrutas.add('Banana');
setFrutas.add('Morango');
setFrutas.add('Banana');
setFrutas.add('Melancia');
setFrutas.size() - 3
*/
/* Map
Banana    Caqui    Laranja    Melancia
 1000      235       22         3000
Map<String, String> mapFrutas = new Map<Integer, String>();
mapFrutas.put('1000', 'Banana');
mapFrutas.put('235', 'Caqui');
mapFrutas.put('22', 'Laranja');
mapFrutas.put('3000', 'Goiaba');
//Lista contas 
Name    Cnpj__c
Conta1    1
Conta2    2
Conta3    3
Account contaRecuperada;
// Exemplo de recuperação com mapa
Map<String, Account> mapContas = new Map<String, Account>();
for(Account conta : contas) {
    mapContas.put(conta.Cnpj__c, conta);
}
String cnpj;
contaRecuperada = mapContas.get(cnpj);
// Exemplo de recuperação com lista
for(Account conta : contas) {
    if(conta.Cnpj__c == '2') {
        contaRecuperada = conta;
        break;
    }
}
Map<Id, List<Opportunity>> mapContasComOportunidades = new Map<Id, List<Opportunity>>();
mapContasComOportunidades.put('<ID_DA_CONTA>', <LISTA_DE_OPORTUNIDADES>);
Map<Id, Integer> mapQtdePorConta = new Map<Id, Integer>();
List<Account> contas = [SELECT Id FROM Account];
for(Account conta : contas) {
    List<Opportunity> lstOpp = [SELECT Id FROM Opportunity WHERE AccountId = :conta.Id];
    mapQtdePorConta.put(conta.Id, lstOpp.size());
}
System.debug('### mapQtdePorConta' + mapQtdePorConta);
*/
/* Exemplo de subquery
List<Account> contas = [
    SELECT 
    Id, 
    Name,
    Cnpj__c,
    (
        SELECT 
            Id, 
            Agencia__c, 
            NumeroConta__c 
        FROM 
            DadosBancarios__r 
    ) 
    FROM 
        Account
];
for(Account conta : contas) {
    System.debug('### Id: ' + conta.Id);
    System.debug('### Name: ' + conta.Name);
    System.debug('### Dados Bancários: ' + conta.DadosBancarios__r.size());
    for(DadosBancarios__c db : conta.DadosBancarios__r) {
        System.debug('### Id: ' + db.Id);
        System.debug('### Agencia: ' + db.Agencia__c);
        System.debug('### Numero da conta: ' + db.NumeroConta__c);
    }
}
List<Account> contas = [
    SELECT 
    Id, 
    Name,
    (
        SELECT 
            Id, 
            Name, 
            Amount 
        FROM 
            Opportunities 
    ) 
    FROM 
        Account
];
*/
/* Exemplo de query com campos relacionados
List<DadosBancarios__c> lstDadosBancarios = [
    SELECT
        Id,
        Conta__c,
        Conta__r.Name,
        Conta__r.Cnpj__c
    FROM
        DadosBancarios__c
];
List<Opportunity> lstOpportunity = [
    SELECT
        Id,
        Name,
        AccountId,
        Account.Name
    FROM
        Opportunity
];
*/
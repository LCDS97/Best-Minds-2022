public class ExerciciosSOQL {
    // 1 - Criar um método que retorne todos os registros do objeto Contrato ( Apólice ) cadastrados no Salesforce.
    public static List<Contract> retornarApolices() {
        List<Contract> contractList = [SELECT Id, Name FROM Contract];
        List<AggregateResult> contratosTotal = [Select Count(id) FROM Contract];

        for(Contract c : contractList){
            System.debug('Apólice: ' + c.Id);
        }
        for (AggregateResult contrato : contratosTotal){
            System.debug('O número total de contratos retornado foi: ' + contrato.get('expr0'));
        }
        return contractList;
    }

    // 2 - Criar um método que retorne apenas os Contratos que estejam com o Status Finalizado ( Usei Draft para concluir o Desafio )
    public static List<Contract> retornarApoliceFinalizadaLista(){
        List<Contract> closedContracts = [SELECT Id, Status FROM Contract WHERE Status = 'Draft'];

            System.debug('O total de Apólices com o Status em Draft é de: ' + closedContracts.size());
        return closedContracts;
    }    
    

    // 3 - Cria um método que receberá o Id de um cliente e retornará a lista de Bônus para esse cliente
    public static List<Bonus__c> retornarBonusPorId(String valorId){
        List<Bonus__c> bonusPorId = [SELECT Id, Name, Conta__c, Conta__r.Name FROM Bonus__c WHERE Conta__c = :valorId];
        
        for(Bonus__c bonus : bonusPorId){
            System.debug('Bônus: ' + bonus.Name + ' da Conta ' + bonus.Conta__r.Name);
        }
        
        return bonusPorId;
        
    }
    // 4 - Cria um método que retornará apenas as Parcelas que o valor seja maior que 10 mil
    public static List<Parcela__c> parcelasMaiorQueMil(){
        List<Parcela__c> listParcelas = [SELECT Id, Name, Moeda__c, Contrato__c, Contrato__r.Account.Name FROM Parcela__c WHERE Moeda__c > 1000];
        
        for(Parcela__c parcela : listParcelas){
            System.debug('Parcela: ' + parcela.Name + ' do Valor R$' + parcela.Moeda__c + ' do Contrato ' + parcela.Contrato__c + ' da Conta: ' + parcela.Contrato__r.Account.Name);
        }
        
        if(listParcelas.size() != 0){
            System.debug('O total de Parcelas maiores que 10 mil foi de: ' + listParcelas.size()); 

        }
        else{
            System.debug('Não há parcelas maiores que 10 mil');           
			
        }

        return listParcelas;


    }
    
        // 5 - Criar um método que retorne a quantidade de todos os Contratos ( Apólice ) com o status em Aberto
    public static List<AggregateResult> contratosEmAberto(){
    	List<AggregateResult> contratosEmAberto = [Select Count(Status) FROM Contract WHERE Status = 'Em Aberto'];
        	for (AggregateResult contrato : contratosEmAberto){
            	System.debug('O número total de contratos em aberto foi: ' + contrato.get('expr0'));
        }
        return contratosEmAberto;
    }
    
    // 6 - Criar um método que receba o Id de um Contrato ( Apólice ) e retorne a soma de todas as parcelas desse contrato
    public static List<Parcela__c> retornaParcelasContratoPorId(String valorId){
        List<Parcela__c> parcelasContratoId = [SELECT Id, Contrato__c, Moeda__c, Contrato__r.Account.Name FROM Parcela__c WHERE Contrato__c = :valorId];
		Decimal valorTotal = 0;        
        
        for(Parcela__c parcela : parcelasContratoId){

            valorTotal += parcela.Moeda__c;
            System.debug('O valor atual da Parcela é de R$' + parcela.Moeda__c + ' da Conta ' + parcela.Contrato__r.Account.Name + ' com o total de R$' + valorTotal);
        }

        return parcelasContratoId;
        
        
    }    

}
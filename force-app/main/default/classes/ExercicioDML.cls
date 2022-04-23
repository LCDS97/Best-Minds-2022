public with sharing class ExercicioDML {
	
    // 1 - Criar um Método que atualize o valor da Oportunidade
                    // Paramêtros: Receber Id Oportunidade / Valor Decimal
    public static void atualizarValorOpp(Id idOportunidade, Decimal valorOportunidade){
        // Regra: O método deve buscar a oportunidade e atualizar o valor com o que foi recebido no método
        Opportunity oportunidadeAtualizar = new Opportunity();
        oportunidadeAtualizar.Id = idOportunidade;
        oportunidadeAtualizar.Amount = valorOportunidade;
        
        update oportunidadeAtualizar;

    }

    // 2 - Criar um método que receba o Id de um Cliente PJ e mude o campo Ativo para false ( Verificar com o Arthur depois sobre o campo )
    public static void clientePJAtualizarCampo(Id idAccount){
        Account clientePj = new Account();
        clientePj.Id = idAccount;
        clientePj.Ativo__c = false;

        update clientePj;
    }
    // 3 - Criar um método que receba o Id de uma Parcela e atualize o campo Status para Paga
    public static void atualizeCampoParcela(Id idParcela){
        Parcela__c parcelaAtualizar = new Parcela__c();
        parcelaAtualizar.Id = idParcela;
        parcelaAtualizar.Status__c = 'Paga';
        
        update parcelaAtualizar;
    }

    // 4 - Criar um método que receba o Id de uma Parcela e delete o registro
    public static void deletarParcela(Id idParcela){
        Parcela__c parcelaDeletar = new Parcela__c();
        System.debug('Verificando antes de deletar a parcela' + idParcela);
        parcelaDeletar.Id = idParcela;
        
        delete parcelaDeletar;
        System.debug('Verificando depois de deletar a parcela' + idParcela);
    }
}
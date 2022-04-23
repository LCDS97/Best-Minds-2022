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
}
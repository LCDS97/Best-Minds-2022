public with sharing class ExerciciosDML {
// Linhas comentadas servem para executar no Developer Console

    // Insert
        // Parcela__c parcelaRetornada = ExerciciosDML.gerarParcelaContrato('Colocar id aqui', colocar valor aqui)
    public static Parcela__c gerarParcelaContrato(Id idContrato, Decimal valorParcela){
        Parcela__c parcelaContrato = new Parcela__c();
        parcelaContrato.Apolice__c = idContrato;
        parcelaContrato.Valor__c = valorParcela;

        System.debug('#### Parcela Antes Insert 1 => ' + parcelaContrato);
        
        insert parcelaContrato;
        
        System.debug('#### Parcela Depois Insert 2 => ' + parcelaContrato);
        return parcelaContrato;
    }

    //Update
        // ExerciciosDML.atualizarParcelaInstancia('Colocar id aqui', colocar valor aqui);
    public static void atualizarParcelaInstancia(Id idParcela, Decimal valorParcelaAtualizar){
        Parcela__c parcelaAtualizar = new Parcela__c();
        parcelaAtualizar.Id = idParcela;
        parcelaAtualizar.Valor__c = valorParcelaAtualizar;

        update parcelaAtualizar;
    }

    // Delete
        // ExerciciosDML.deletarParcelaInstancia('Colocar id aqui');
        public static void deletarParcelaInstancia(Id idParcela){
            Parcela__c parcelaAtualizar = new Parcela__c();
            parcelaAtualizar.Id = idParcela;

            delete parcelaAtualizar;
        }

    // Upsert
        // ExerciciosDML.atualizarParcelaContrato('Colocar id aqui', 'Id externo aqui', valor da parcela);
    public static void atualizarParcelaContrato(Id idContrato, String idExternoParcela, Decimal valorParcela){
        Parcela__c parcela = new Parcela__c();
        parcela.Apolice__c = idContrato;
        parcela.IdExterno__c = idExternoParcela;
        parcela.Valor__c = valorParcela;

        upsert parcela IdExterno__c;
    }

    // Lista Agregagada
    public static void ListaAgregada(){
        List<AggregateResult> resultadoAgrupado = [SELECT Apolice__c, MAX(Valor__c) valorMaximo,
                                                    SUM(Valor__c) valorSomado, AVG(Valor__c) mediaValor
                                                    FROM Parcela__c GROUP BY Apolice__c];
        System.debug(resultadoAgrupado);

        for(AggregateResult resultado : resultadoAgrupado){
            System.debug(resultado.get('Apolice__c'));
            System.debug(resultado.get('valorMaximo'));
            System.debug(resultado.get('valorSomado'));
            System.debug(resultado.get('mediaValor'));
        }
    }

}

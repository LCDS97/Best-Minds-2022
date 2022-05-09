public with sharing class ParcelaBO {

    public class DataVencimentoVazioException extends Exception{}
    
    public static void atualizeCampoParcela(Id idParcela){
        Parcela__c parcelaAtualizar = new Parcela__c();
        parcelaAtualizar.Id = idParcela;
        parcelaAtualizar.Status__c = 'Paga';
        
        update parcelaAtualizar;
    }
    
    public static void deletarParcela(Id idParcela){
        Parcela__c parcelaDeletar = new Parcela__c();
        parcelaDeletar.Id = idParcela;
        
        delete parcelaDeletar;
    }
    
    public static List<Parcela__c> retornarParcelasMaiorValorDesejado(Integer valorFiltrar){
        List<Parcela__c> listParcelas = ParcelaDAO.retornarParcelasMaiorQueValorDesejado(valorFiltrar);
        
        for(Parcela__c parcela : listParcelas){
            System.debug('Parcela: ' + parcela.Name + ' do Valor R$' + parcela.Moeda__c + ' do Contrato ' + parcela.Contrato__c + ' da Conta: ' + parcela.Contrato__r.Account.Name);
        }
        
        if(listParcelas.size() != 0){
            System.debug('O total de Parcelas maiores que ' + valorFiltrar + ' foi de: ' + listParcelas.size()); 

        }
        else{
            System.debug('Não há parcelas maiores que ' + valorFiltrar);           
			
        }

        return listParcelas;

    }

    public static Decimal verificarParcela(Id IdParcela){
        Parcela__c pegarParcela = ParcelaDAO.retornarParcelaIdValorVencimento(IdParcela);
        Date dataHoje = Date.Today();
        Decimal valorParcelaAlterado = 0;

        try {
            Integer verificarVencimento = dataHoje.daysBetween(pegarParcela.DataVencimento__c);
            
            if( verificarVencimento > 0){
                valorParcelaAlterado = pegarParcela.Moeda__c - (pegarParcela.Moeda__c * 0.05);
        }   else if (verificarVencimento < 0 ){
                valorParcelaAlterado = pegarParcela.Moeda__c + (pegarParcela.Moeda__c * 0.1);
            
        }   else if(verificarVencimento == 0){
                valorParcelaAlterado = pegarParcela.Moeda__c;
                System.debug('Sem desconto pois é o dia do Vencimento');
        }   else {
                throw new DataVencimentoVazioException('Valor do campo Date está Nulo');
            } 
        } catch (DataVencimentoVazioException error) {
            System.debug('###Erro DataVencimentoException => :' + error.getMessage());
        } catch (NullPointerException error) {
            System.debug('###Erro Argumento Nulo => :' + error.getMessage());
        } catch(Exception error) {
            System.debug('###Erro Exception Padrão' + error.getMessage());
        }
        pegarParcela.Moeda__c = valorParcelaAlterado;
        update pegarParcela;
        return valorParcelaAlterado;
    }
}

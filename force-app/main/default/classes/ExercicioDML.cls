public with sharing class ExercicioDML {

    public class CampoVazioException extends Exception {}
	
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
        if (clientePj.Ativo__c == true){
            clientePj.Ativo__c = false;
            System.debug('Dentro do IF = VerificarCampo igual a ' + clientePj.Ativo__c);
        }
        System.debug('Fora do IF = VerificarCampo igual a ' + clientePj.Ativo__c);

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

    // 5 - Criar um método que crie um Contato para o Cliente PJ
    /* Paramêtros:
        1 - Id do Cliente PJ - (id)
        2 - Nome do Contato  - (String)
        3 - Cargo do Contato  - (String)
        4 - Data de Nascimento do Contato  - (Date)
        5 - E-mail do Contato  - (String)
    */
    /* Regras:
        1 - O método deve retornar um valor Boolean que indicará se o contato foi criada ou não
        2 - Se algum dos campos não estiver preenchido é necessário retornar false
        3 - Se todos os campos estiverem preenchidos, é necessário criar um registro de contato para o Cliente e retornar true
    */
      public static Boolean contatoClientePJ(
                            Id clientePJ,
                            String nomeContato,
                            String sobrenomeContato,
                            String cargoContato,
                            String dataNascimentoContato,
                            String emailContato){
                    Boolean contactWasCreated;
                    Contact novoContato = new Contact();
                    try {
                        if (
                            String.IsBlank(clientePJ) == false ||
                            String.isBlank(nomeContato) == false ||
                            String.isBlank(sobrenomeContato) == false ||
                            String.isBlank(cargoContato) == false ||
                            String.isBlank(dataNascimentoContato) == false ||
                            String.isBlank(emailContato) == false ){
                            
                            
                                Date dataConvertida = Date.valueOf(dataNascimentoContato);
                                novoContato.AccountId = clientePJ;
                                novoContato.FirstName = nomeContato;
                                novoContato.LastName = sobrenomeContato;
                                novoContato.Title = cargoContato;
                                novoContato.BirthDate = dataConvertida;
                                novoContato.Email = emailContato;
                                contactWasCreated = true;
    
                                insert novoContato;
                            
                            }
                                throw new CampoVazioException('Preencher todos os campos por favor!!');
                   
                        }
                    catch (CampoVazioException e) {
                        contactWasCreated = false;
                        System.debug('### Exception Personalizado => ' + e.getMessage());
                    }
                    catch(Exception e){
                        contactWasCreated = false;
                        System.debug('### Exception Padrão => ' + e.getMessage());
                    }
                        return contactWasCreated;    
                }
}
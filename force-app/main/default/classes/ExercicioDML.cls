public with sharing class ExercicioDML {

    public class CampoVazioException extends Exception {}
	







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
                    try {
                        if (
                            String.IsBlank(clientePJ) == false &&
                            String.isBlank(nomeContato) == false &&
                            String.isBlank(sobrenomeContato) == false &&
                            String.isBlank(cargoContato) == false &&
                            String.isBlank(dataNascimentoContato) == false &&
                            String.isBlank(emailContato) == false ){
                                
                                
                                Contact novoContato = new Contact();
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
                            else{
                                throw new CampoVazioException('Preencher todos os campos por favor!!');

                            }
                   
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
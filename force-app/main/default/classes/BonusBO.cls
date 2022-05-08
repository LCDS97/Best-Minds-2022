public with sharing class BonusBO {

    public class ContaInativaException extends Exception{}
    public class ContatoNaoExistenteException extends Exception{}
    public class ValorBonusZeradoException extends Exception{}

    public static List<Bonus__c> retornarBonusPorId(Id idConta){
        List<Bonus__c> bonusPorId = BonusDAO.retornarBonusPorIdConta(idConta);
        
        for(Bonus__c bonus : bonusPorId){
            System.debug('Bônus: ' + bonus.Name + ' da Conta ' + bonus.Conta__r.Name);
        }
        
        return bonusPorId;
        
    }

    public static void criarBonusParaContatos(Id IdAccount, List<Contact> listContatos, Decimal valorBonus){

        
        try {
            Account buscarConta = AccountDAO.buscarContaAtivoPorID(idAccount);
            if(!buscarConta.Ativo__c){
                throw new ContaInativaException('É necessário a conta estar ativa!');
            }
            if(listContatos.isEmpty()){
                throw new ContatoNaoExistenteException('É Necessário ter contatos na lista');
            }
            if(valorBonus <= 0){
                throw new ValorBonusZeradoException('É Necessário o valor do Bônus maior que zero');
            }

            List<Bonus__c> listaBonus = new List <Bonus__c>(); 

            for(Contact contato : listContatos){
                Bonus__c bonusParaContato = new Bonus__c();

                bonusParaContato.Conta__c = IdAccount;
                bonusParaContato.Contato__c = contato.Id;
                bonusParaContato.Pontos__c = valorBonus;

                listaBonus.add(bonusParaContato);
            }

            System.debug('A lista de bonus a ser criada é ' + listaBonus);
            insert listaBonus;
            
        } catch (ContaInativaException e) {
            System.debug('#### ContaInativaException: ' + e.getMessage());
        } catch (ContatoNaoExistenteException e) {
            System.debug('#### ContatoNaoExistenteException: ' + e.getMessage());
        } catch (ValorBonusZeradoException e) {
            System.debug('#### ValorBonusZeradoException: ' + e.getMessage());
        } catch (Exception e) {
            System.debug('#### Exception Padrao: ' + e.getMessage());
            
        }
    }
}

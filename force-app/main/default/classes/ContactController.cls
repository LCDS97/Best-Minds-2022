public with sharing class ContactController {
    
    @AuraEnabled
    public static string getContact(String Id){

        String sobrenomeContato = '';

        try {

            sobrenomeContato = ContactDAO.buscarUnicoContatoPorId(Id).Name;

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return sobrenomeContato;
    }

    @AuraEnabled
    public static Boolean updateContact (String Id, String sobrenomeContatoAtualizado){
        try {
            Contact objContact = ContactDAO.buscarUnicoContatoPorId(Id);
            objContact.LastName = sobrenomeContatoAtualizado;

            update objContact;
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}

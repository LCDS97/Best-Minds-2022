trigger VincularContatoUnicoPorOportunidadeTrigger on Opportunity (after insert) {

    /* 
    5 - Crie um Apex Trigger que, ao criar um registro de oportunidade (Opportunity),
        verifique se o Contato (Contact) não foi preenchido e se a Conta (Account) vinculada possui apenas 1 Contato (Contact).
        Caso isso aconteça, vincule automaticamente esse Contato (Contact) na Oportunidade (Opportunity). 
    */

    Set<Id> setDadosOportunidade = new Set<Id>();
    List<Opportunity> lstOportunidades = new List<Opportunity>();

    for(Opportunity oportunidade : Trigger.New){

        if(oportunidade.Contato__c = null){
            setDadosBancariosAtivo.add(oportunidade.Id);
            setFiltrarContaPorId.add(oportunidade.AccountId);
            lstOportunidades.add(oportunidade);
            }
        
        else return;
    
        }
    if(lstOportunidades.isEmpty()) return;

    

}
public with sharing class ResponseTO {
    @AuraEnabled
    public String mensagem {get;set;}
    @AuraEnabled
    public Boolean sucesso {get;set;}
    @AuraEnabled
    public string jsonRetorno{get;set;}

}


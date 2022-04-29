trigger TriggerExample on Account (after insert, after update) {
        Map<Id, Boolean> mapDevoCriarOpp = new Map<Id,Boolean>();
        List<Opportunity> lstOppDevoCriar = new List<Opportunity>();

        for(Account conta : Trigger.new){
            mapDevoCriarOpp.put(conta.Id, true);
        }

        List<Opportunity> lstOpp = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :mapDevoCriarOpp.keySet()];

        for(Opportunity opp : lstOpp){
            mapDevoCriarOpp.put(opp.AccountId, false);
        }

        for(Account conta : Trigger.new){
            Boolean devoCriar = mapDevoCriarOpp.get(conta.Id);

            if(devoCriar){
                Opportunity opp = new Opportunity();
                opp.AccountId = conta.Id;
                opp.Name = conta.Name + ' - Oportunidade nova';
                opp.StageName = 'Prospecting';
                opp.CloseDate = date.today().addMonths(1);
                lstOppDevoCriar.add(opp);
            }
            
        }
        insert lstOppDevoCriar;
}
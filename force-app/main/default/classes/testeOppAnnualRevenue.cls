public with sharing class testeOppAnnualRevenue {
        public static void atribuirAnnualRevenue() {
            List<Account> todasContas = [SELECT Id, AnnualRevenue, Name, (SELECT Id, Amount FROM Opportunities) FROM Account];
            for(Account conta : todasContas){
                if(conta.AnnualRevenue == null){
                    conta.AnnualRevenue = 0;
                    for(Opportunity oportunidade : conta.Opportunities){
                        if(oportunidade.Amount == null){
                            oportunidade.Amount = 0;
                            conta.AnnualRevenue += oportunidade.Amount;
                        }else {
                            conta.AnnualRevenue += oportunidade.Amount;
                        }
                    }
                }else{
                    
                    for(Opportunity oportunidade : conta.Opportunities){
                        if(oportunidade.Amount == null){
                            oportunidade.Amount = 0;
                            conta.AnnualRevenue += oportunidade.Amount;
                        }else {
                            conta.AnnualRevenue += oportunidade.Amount;
                        }
                    }
                }

                System.debug('O valor da conta com ID ' + conta.Id  + ' com o nome      ' + conta.Name + ' com o valor de Annual revennue R$' + conta.AnnualRevenue);
            }
        }
    }

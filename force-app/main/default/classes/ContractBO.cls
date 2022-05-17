public with sharing class ContractBO {
    
    
/*
    1. Crie um Apex Trigger que, ao criar um registro de Contrato (Contract), crie um registro de Tarefa (Task),
        caso a Conta (Account) vinculada não possua um registro de Dados Bancários (DadosBancarios__c):
            OwnerId = Proprietário da conta vinculado no caso
            WhatId = Conta vinculada ao caso
            ActivityDate = Data atual
            Subject = Necessário cadastrar os dados bancários do cliente
*/
    public static void criarTarefaContaSemDadosBancarios(List<Contract> lstTriggersContracts){

    List<Contract> lstContasAtivada = new List<Contract>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdsContasAtivadas = new Set<Id>();
    Map<Id,Boolean> mapDevoCriarTask = new Map<Id,Boolean>();

    for(Contract contrato : lstTriggersContracts){
        lstContasAtivada.add(contrato);
        mapDevoCriarTask.put(contrato.AccountId, true);
        setIdsContasAtivadas.add(contrato.AccountId);
    }
    
    List<Account> lstContas = AccountDAO.buscarContasPorId(setIdsContasAtivadas);
    List<DadosBancarios__c> lstDadosBancarios = DadosBancariosDAO.pegarContasPorDadoBancarios(setIdsContasAtivadas);
    for(DadosBancarios__c db : lstDadosBancarios){
        mapDevoCriarTask.put(db.Conta__c,false);
    }

    for(Account conta : lstContas){
        Boolean devoCriar = mapDevoCriarTask.get(conta.Id);

        if(devoCriar){
            
                Task task = new Task();
                task.WhatId = conta.Id;
                task.ActivityDate = Date.today();
                task.OwnerId = conta.OwnerId;
                task.Priority = 'High';
                task.Status = 'Not Started';
                task.Subject = 'Necessário cadastrar os dados bancários do cliente';
                lstTaskParaCriar.add(task);
            
            }


        }

        insert lstTaskParaCriar;
    }



/*
    2 - Crie um Apex Trigger que, ao ativar um Contrato (Contract) (Status = Activated), valide se a Conta (Account) vinculada possui um
        registro de Dados Bancários (DadosBancarios__c) ativo. Caso não possua, exibir uma mensagem que ele não pode ativar um Contrato (Contract)
            sem ter um registro de Dados Bancários (DadosBancarios__c) ativo. Obs.: Utilizar o método addError.
*/
    public static void naoAtivarContratoSemDadosBancarios(List<Contract> lstTriggersContracts, Map<Id,Contract> mapOldContract){
    
    List<Contract> lstContratosAtivado = new List<Contract>();
    List<Task> lstTaskParaCriar = new List<Task>();
    Set<Id> setIdContratosAtivo = new Set<Id>();
    Map<Id,Boolean> mapEstaComDadosBancarios = new Map<Id,Boolean>();
    Map<Id, List<DadosBancarios__c>> mapDadosPorContrato = new Map<Id, List<DadosBancarios__c>>();

    if(Trigger.isUpdate){
        for(Contract contratoNovo : lstTriggersContracts){
            Contract contratoAntigo = mapOldContract.get(contratoNovo.Id);
            if(contratoAntigo.Status != 'Activated' && contratoNovo.Status == 'Activated'){
                lstContratosAtivado.add(contratoNovo);
                setIdContratosAtivo.add(contratoNovo.AccountId);
            }
        }
    }

    if(Trigger.isInsert){
        for(Contract contratoNovo : lstTriggersContracts){
            if(contratoNovo.Status == 'Activated'){
                lstContratosAtivado.add(contratoNovo);
                setIdContratosAtivo.add(contratoNovo.AccountId);
            }
        }
    }

        if(lstContratosAtivado.isEmpty()) return;

        List<DadosBancarios__c> lstDadosBancarios = DadosBancariosDAO.pegarContasPorIdSomenteAtivos(setIdContratosAtivo);

        for(DadosBancarios__c db : lstDadosBancarios){

            if(!mapEstaComDadosBancarios.containsKey(db.Conta__c) || !db.Ativo__c){
                mapDadosPorContrato.put(db.Conta__c, new List<DadosBancarios__c>());
            }

            mapDadosPorContrato.get(db.Conta__c).add(db);
        }

        for(Contract contratoAtivo : lstContratosAtivado){
            if(!mapDadosPorContrato.containsKey(contratoAtivo.accountId) && Trigger.isUpdate){
                contratoAtivo.addError('Você não pode mudar a fase do Contrato sem um dado bancário ativo, preencha uma por favor!');
            }
            if(!mapDadosPorContrato.containsKey(contratoAtivo.accountId) && Trigger.isInsert){
                contratoAtivo.addError('Você não pode criar um contrato já ativado sem um dado bancário ativo, preencha uma por favor!');
            }
        }
    }

    public static Integer buscarParcelasContrato(Id IdContrato){
        Integer buscaParcelaPorContratoId = ParcelaDAO.buscarParcelasIdContrato(IdContrato).size();

        return buscaParcelaPorContratoId;
    }

    public static List<Contract> retornarApolices() {
        List<Contract> contractList = ContractDAO.buscarTodosContratos();

        return contractList;
    }

    public static List<Contract> retornarApoliceDraftLista(){
        List<Contract> closedContracts = ContractDAO.buscarContratosPorStatus('Draft');

        return closedContracts;
    }    

    public static List<AggregateResult> contratosEmAberto(){
    	List<AggregateResult> contratosEmAberto = ContractDAO.buscarContratosEmAberto();
        	for (AggregateResult contrato : contratosEmAberto){
            	System.debug('O número total de contratos em aberto foi: ' + contrato.get('expr0'));
        }
        return contratosEmAberto;
    }

    public static Decimal retornaParcelasContratoPorId(Id idContrato){
        
        List<Parcela__c> parcelasContratoId = ParcelaDAO.retornarIdContratoValorNome(idContrato);
		Decimal valorTotal = 0;
        
        for(Parcela__c parcela : parcelasContratoId){

            valorTotal += parcela.Moeda__c;
            System.debug('O valor atual da Parcela é de R$' + parcela.Moeda__c + ' da Conta ' + parcela.Contrato__r.Account.Name + ' com o total de R$' + valorTotal);
        }
        
        return valorTotal;
        
    }
    

    // Exemplos da Aula sobre Método Future
    @future
    private static void contarParcelas(Id idContrato){
        List<Parcela__c> lstNumeroParcelasPorContrato = ParcelaDAO.buscarParcelasIdContrato(idContrato);
        
        Contract contratoAtualizar = new Contract();
        contratoAtualizar.Id = idContrato;
        contratoAtualizar.NumeroParcelas__c = lstNumeroParcelasPorContrato.size();

        update contratoAtualizar;
    
    }

    public static void ChamarMetodoFeature(Id idContrato){
        contarParcelas(idContrato);
    }

    public static List<ParcelaTO> buscarParcelasDoContrato(Id idContrato){

        List<Parcela__c> lstParcelas = ParcelaDAO.buscarParcelasIdContrato(idContrato);
        List<ParcelaTO> lstParcelasContratoTO = transformarContratosEmTO(lstParcelas);
        return lstParcelasContratoTO;
    }

    public static Boolean salvarParcelas(List<ParcelaTO> lstParcelaTO){
        Boolean sucesso = false;
        try {
            
            List<Parcela__c> lstParcela = transformarListContratoTOParaListParcela(lstParcelaTO);
            update lstParcela;
            System.debug('######## lst parcelas dentro do boolean salvarParcelas' + lstParcela);
            sucesso = true;

        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }

        return sucesso;
    }

    private static List<ParcelaTO> transformarContratosEmTO(List<Parcela__c> lstParcelasDoContrato){
        List<ParcelaTO> lstContratoTO = new List<ParcelaTO>();

        for(Parcela__c parcela: lstParcelasDoContrato){
            ParcelaTO ParcelaTO = new ParcelaTO();
            ParcelaTO.id = parcela.Id;
            ParcelaTO.moeda = parcela.Moeda__c;
            ParcelaTO.contract = String.valueOf(parcela.Contrato__c);
            ParcelaTO.statusValidade = String.valueOf(parcela.Status_Validade__c);
            lstContratoTO.add(ParcelaTO);
        }

        return lstContratoTO;
    }

    private static List<Parcela__c> transformarListContratoTOParaListParcela(List<ParcelaTO> lstParcelasTO){
        List<Parcela__c> lstParcela = new List<Parcela__c>();

        for(ParcelaTO parcelaTO : lstParcelasTO){
            Parcela__c parcela = new Parcela__c();
            parcela.Id = parcelaTO.id;
            parcela.Moeda__c = parcelaTO.moeda;

            lstParcela.add(parcela);
        }

        return lstParcela;
    }

    public class ParcelaTO{
        @AuraEnabled
        public String id {get;set;}
        @AuraEnabled
        public Decimal moeda {get;set;}
        @AuraEnabled
        public String contract {get;set;}
        @AuraEnabled
        public String statusValidade {get;set;}
    }






}

({
    atualizarValor : function(component, event, helper) {
        // Definição de ação a ser utilizada (Método do apex)
        let action = component.get("c.setValue");
        
        // Obter valores e passagem de parametros
        let valorEntrada = component.find("entrada").get("v.value");

        //Obs. O nome do paramêtro "valor" deve ser o mesmo do método Apex
        action.setParams({valor : valorEntrada});

        // Criação do método de Callback "Ajax"
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.resultado", response.getReturnValue());
            }else{
                alert('Erro ao processar chamada');
            }
        });

        // Executa o método
        $A.enqueueAction(action);


    }
})

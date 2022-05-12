({
    doInit : function(component, event, helper) {

        let action = component.get("c.getContact");

        action.setParams({ id : component.get("v.recordId")});

        action.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.valorNomeContato", response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    },

    salvarContato: function(component){

        var action = component.get("c.updateContact");
        var recordId = component.get("v.recordId");
        var nomeContato = component.find("nomeContato").get("v.value");

        if(nomeContato != "" && nomeContato != null){

            action.setParams({ Id : recordId, sobrenomeContatoAtualizado : nomeContato});

            action.setCallback(this, function(response){
    
                if(response.getState() == "SUCCESS"){
    
                    $A.get('e.force:refreshView').fire();
                }else {
                    alert('Falha ao atualizar registro')
                }
            });
    
            $A.enqueueAction(action);

        }else {
            alert('Necessário preencher um sobrenome para atualizar')
        }


    },

    limparLabel: function(component){
        var nomeContato = component.find("nomeContato").get("v.value") ;

        if(nomeContato != '' && nomeContato != null){
            component.set("v.valorNomeContato","");
        } else {
            alert('Campo já esta limpo');
        }
    }



})

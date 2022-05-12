({
    doInit : function(component, event, helper) {

        let action = component.get("c.getAccount");

        action.setParams({id : component.get("v.recordId")});

        action.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.valorConta", response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    },

    salvarConta : function(component){

        var action = component.get("c.updateAccount");

        var recordId = component.get("v.recordId");

        var nomedaConta = component.find("nomeConta").get("v.value");

        action.setParams({Id : recordId, nomeAtualizado : nomedaConta});

        action.setCallback(this, function(response){

            if(response.getState() == "SUCCESS"){

                $A.get('e.force:refreshView').fire();

            }else{

                alert('Falha ao atualizar o registro');

            }

        });



        $A.enqueueAction(action);

    }
})

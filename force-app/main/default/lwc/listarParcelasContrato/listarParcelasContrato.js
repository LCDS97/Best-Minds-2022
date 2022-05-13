import { LightningElement, api, track } from 'lwc';

import buscarParcelasContratoService from '@salesforce/apex/ControllerListarParcelas.buscarParcelasContrato';

export default class ListarParcelasContrato extends LightningElement {
    @api recordId;

    @track listaParcelasContrato = [];

    connectedCallback(){
        this.buscarParcelasContrato();
    }

    buscarParcelasContrato(){
        buscarParcelasContratoService({idContrato : this.recordId})
            .then(response => {
                this.listaParcelasContrato = response;
            })
            .catch(error => {
                console.log(error);
            })
    }

}
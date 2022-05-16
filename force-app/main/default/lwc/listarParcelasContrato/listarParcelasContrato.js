import { LightningElement, api, track } from 'lwc';

import buscarParcelasContratoService from '@salesforce/apex/ControllerListarParcelas.buscarParcelasContrato';

export default class ListarParcelasContrato extends LightningElement {
    @api recordId;

    @track listaParcelasContrato = [];
    @track listaFiltrada = [];
    @track valorFiltro = '';

    connectedCallback(){
        this.buscarParcelasContrato();
    }

    buscarParcelasContrato(){
        buscarParcelasContratoService({idContrato : this.recordId})
            .then(response => {
                this.listaParcelasContrato = response;
                this.listaFiltrada = response;
            })
            .catch(error => {
                console.log(error);
            })
    }

    atualizarCampoHandler( event ){

        let valorCampo = event.currentTarget.value;
        this.valorFiltro = valorCampo;
        
    }

    filtrarBancos(event){
        let nomeBanco = this.valorFiltro;
        let listaFiltrar = this.listaParcelasContrato.map(value => Object.assign({}, value));
        this.listaFiltrada = [];

        this.listaFiltrada = listaFiltrar.filter(element => { return element.banco == nomeBanco });

/*         for(let itemLista of listaFiltrar){
            if(itemLista.banco == nomeBanco){
                this.listaFiltrada.push(itemLista);
            }
        } */
    }

}
import { LightningElement, api, track } from 'lwc';

import buscarParcelasContratoService from '@salesforce/apex/ControllerListarParcelas.buscarParcelasContrato';

export default class ListarParcelasContrato extends LightningElement {
    @api recordId;

    @track listaParcelasContrato = [];
    @track listaFiltrada = [];
    @track valorFiltro = '';
    @track temParcelas = true;

    connectedCallback(){
        this.buscarParcelasContrato();
    }

    buscarParcelasContrato(){
        buscarParcelasContratoService({idContrato : this.recordId})
            .then(response => {
                if (response.length != 0) {
                    this.listaParcelasContrato = response;
                    this.listaFiltrada = response;
                }else{
                    this.listaParcelasContrato = response;
                    this.listaFiltrada = response;
                    this.temParcelas = false;
                }
            })
            .catch(error => {
                console.log(error);
            })
    }

    

    atualizarCampoHandler( event ){

        let valorCampo = event.currentTarget.value;
        this.valorFiltro = valorCampo;
        
    }

    filtrarParcelas(event){
        let nomeStatusValidade = this.valorFiltro;
        let listaFiltrar = this.listaParcelasContrato.map(value => Object.assign({}, value));
        this.listaFiltrada = [];

        this.listaFiltrada = listaFiltrar.filter(element => { return element.statusValidade == nomeStatusValidade });

    }


}
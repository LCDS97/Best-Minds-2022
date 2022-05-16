import { LightningElement, api, track } from 'lwc';
import buscarDadosBancariosService from '@salesforce/apex/ControllerListarDadosBancarios.buscarDadosBancarios';

export default class ListarDadosBancarios extends LightningElement {
    @api recordId;
    
    @track listarDadosBancarios = [];
    @track listaFiltrada = [];
    @track valorFiltro = '';

    connectedCallback(){
        this.buscarDadosBancariosSalesforce();
    }

    buscarDadosBancariosSalesforce(){
        buscarDadosBancariosService({idConta: this.recordId})
            .then(response => {
                this.listarDadosBancarios = response;
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
        let listaFiltrar = this.listarDadosBancarios.map(value => Object.assign({}, value));
        this.listaFiltrada = [];

        this.listaFiltrada = listaFiltrar.filter(element => { return element.banco == nomeBanco });

    }

}
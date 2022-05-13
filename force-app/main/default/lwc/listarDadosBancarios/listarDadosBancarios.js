import { LightningElement, api, track } from 'lwc';
import buscarDadosBancariosService from '@salesforce/apex/ControllerListarDadosBancarios.buscarDadosBancarios';

export default class ListarDadosBancarios extends LightningElement {
    @api recordId;
    
    @track listarDadosBancarios = [];

    connectedCallback(){
        this.buscarDadosBancariosSalesforce();
    }

    buscarDadosBancariosSalesforce(){
        buscarDadosBancariosService({idConta: this.recordId})
            .then(response => {
                this.listarDadosBancarios = response;
            })
            .catch(error => {
                console.log(error);
            })
    }

}
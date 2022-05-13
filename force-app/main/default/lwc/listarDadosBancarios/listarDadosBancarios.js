import { LightningElement, api, track } from 'lwc';
import buscarDadosBancariosService from '@salesforce/apex/DadosBancariosBO.buscarDadosBancarios';

export default class ListarDadosBancarios extends LightningElement {
    @api recordId;
    
    @track lista = [];

    connectedCallback(){
        this.buscarDadosBancariosSalesforce();
    }

    buscarDadosBancariosSalesforce(){
        buscarDadosBancariosService({idConta: this.recordId})
            .then(response => {
                this.lista = response;
            })
            .catch(error => {
                console.log(error);
            })
    }

}
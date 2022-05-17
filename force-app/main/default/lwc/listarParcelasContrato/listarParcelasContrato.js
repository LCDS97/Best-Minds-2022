import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import buscarParcelasContratoService from '@salesforce/apex/ControllerListarParcelas.buscarParcelasContrato';
import salvarParcelasService from '@salesforce/apex/ControllerListarParcelas.salvarParcelas'

export default class ListarParcelasContrato extends LightningElement {
    @api recordId;

    @track listaParcelasContrato = [];
    @track listaFiltrada = [];
    @track valorFiltro = '';
    @track temParcelas = true;

    connectedCallback(){
        this.buscarParcelasContrato(this.recordId);
    }

    buscarParcelasContrato(idContrato){
        buscarParcelasContratoService({idContrato})
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


    filtrarParcelas(event){
        let valorDigitadoStatus = this.valorFiltro;
        let listaParcelasOriginal = this.clonarListaOriginal() // Transformar ela em método

        if(valorDigitadoStatus == ''){
            this.listaFiltrada = listaParcelasOriginal;
            return;
        }

        this.listaFiltrada = [];

        this.listaFiltrada = listaParcelasOriginal.filter(element => { return element.statusValidade.toUpperCase() == valorDigitadoStatus.toUpperCase() });

    }

    salvarParcelas(){
        let lstParcelas = this.clonarListaOriginal();

        salvarParcelasService({lstParcelas})
            .then(response => {
                if(response){
                    this.apresentarMensagemToast('Boa!','Suas parcelas foram salvas com sucesso','success')
                } else {
                    this.apresentarMensagemToast('Ih rapaz...','Ocorreu um erro ao fazer atualização do suas parcelas','error')
                }

            })
            .catch(error => {
                console.log(error)
            })

    }

    atualizarCampoHandler( event ){
        let valorCampo = event.currentTarget.value;
        this.valorFiltro = valorCampo;
    }

    alterarValorParcelaHandler( event ){
        let idParcelaEditada = event.currentTarget.dataset.id
        let valorEditadoParcela = parseFloat(event.currentTarget.value)
        let listaOriginalClonada = this.clonarListaOriginal()

        for(let itemLista of listaOriginalClonada){
            if(itemLista.id == idParcelaEditada){
                itemLista.moeda = valorEditadoParcela
            }
        }

        this.atualizarListaOriginal(listaOriginalClonada)
        
    }

    clonarListaOriginal(){
        return this.listaParcelasContrato.map(value => Object.assign({}, value));
    }

    atualizarListaOriginal(listaOriginalAtualizada){
        this.listaParcelasContrato = listaOriginalAtualizada
    }

    apresentarMensagemToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }




}
public with sharing class GenericsBO {
    
    public static Integer comparacaoItensLista(List<String> lista1,List<String> lista2){
        Set<String> valoresUnicos = new Set<String>();
        
        try {
            if(lista1.isEmpty()){
                throw new ListaVaziaException('A lista esta vazia! A lista vazia é a Lista 1');
            }
            if(lista2.isEmpty()){
                throw new ListaVaziaException('A lista esta vazia! A lista vazia é a Lista 2');
            }

            for(String item1 : lista1){
                for(String item2: lista2){
                    if(item1 == item2){
                        valoresUnicos.add(item1);
                    }
                }
            }

        } catch (ListaVaziaException e) {
            System.debug('### ExceptionListaVazia' + e.getMessage());
        }catch (Exception e) {
            System.debug('### Exception Padrão '  + e.getMessage());
            
        }
        Integer valoresRepetidos = valoresUnicos.size(); 
        System.debug('Itens iguais é ' + valoresRepetidos);
        return valoresRepetidos;
    }
}

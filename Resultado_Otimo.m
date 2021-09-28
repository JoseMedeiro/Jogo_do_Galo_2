%   FUNCAO DE DETETAR RESULTADO OTIMO

function resultado = Resultado_Otimo(jogadas, RESULTADOS_OTIMOS)
    
    %   No pior caso
    resultado = RESULTADOS_OTIMOS(size(RESULTADOS_OTIMOS,2));
    
    for c=1:size(jogadas,2)
        
        switch jogadas(c).status
            case RESULTADOS_OTIMOS(1)
                resultado = RESULTADOS_OTIMOS(1);
                break
            case RESULTADOS_OTIMOS(2)
                resultado = RESULTADOS_OTIMOS(2); 
        end
        
    end
    
end
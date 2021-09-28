%   FUNCAO DE DETETAR JOGADAS IGUAIS

function resultado = Vetores_Iguais(jogada_1, jogada_2, limite)
    
    resultado = 1;
    
    for c=1:limite
        
        if(jogada_1(c)~=jogada_2(c))
            resultado = 0;
            break
        end
        
    end
    
    
end
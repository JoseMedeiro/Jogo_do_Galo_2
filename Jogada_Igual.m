%   FUNCAO DE ENCONTRAR AS JOGADAS IGUAIS

function posicao = Jogada_Igual(jogadas, jogada_atual, limite)
    
    c = 1;
    while((jogada_atual - c > 0)&&(Vetores_Iguais(jogadas(jogada_atual).movimentos, jogadas(jogada_atual - c).movimentos, limite)==1))
        
        c = c +1;
        
    end
    
    posicao = jogada_atual - c+1;
    
end
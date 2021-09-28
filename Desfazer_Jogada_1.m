%   FUNCAO DE DESFAZER UMA JOGADA (^1)

function novo = Desfazer_Jogada_1(tabuleiro, jogada)
    
    if(jogada > 0)
        tabuleiro(jogada) = 1;
    end
    
    novo = tabuleiro;
    
end
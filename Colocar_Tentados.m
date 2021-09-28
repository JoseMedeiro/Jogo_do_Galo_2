%   FUNCAO DE COLOCAR TENTATIVAS

function novo = Colocar_Tentados(tabuleiro, jogadas, movimento)
    
    %   No pior caso
    novo = tabuleiro;
    
    for c=1:size(jogadas,2)
        if(jogadas(c).movimentos(movimento) > 0)
            novo(jogadas(c).movimentos(movimento)) = 4;
        end
        
    end
    
end
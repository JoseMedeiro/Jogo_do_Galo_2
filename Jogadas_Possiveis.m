%   FUNCAO DE DETETAR JOGADAS POSSIVEIS

function jogo = Jogadas_Possiveis(TABULEIRO, MAX_JOGADAS)
    
    lista   = zeros(1,MAX_JOGADAS);
    d       = 1;
    
    for c=1:size(TABULEIRO,2)
        if(TABULEIRO(c)==1)
            lista(d)=c;
            d = d +1;
        end
    end
    
    jogo = lista(1:d-1);
end
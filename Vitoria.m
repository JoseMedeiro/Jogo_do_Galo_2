%   FUNCAO DE DETETAR VITORIA/DERROTA

function resultado = Vitoria(TABULEIRO, JOGADORES)

    resultado = 1;
    %   Verificacao de linhas
    for c=0:2
        linha = TABULEIRO(c*3 +1)*TABULEIRO(c*3 +2)* TABULEIRO(c*3 +3);
        if (linha==JOGADORES(1)^3)
            resultado = JOGADORES(1);
            break
        end
        if (linha==JOGADORES(2)^3)
            resultado = JOGADORES(2);
            break
        end        
    end
    %   Verificacao de colunas
    if(resultado==1)
        for c=1:3
            linha = TABULEIRO(c)*TABULEIRO(c +3)* TABULEIRO(c +6);
            if (linha==JOGADORES(1)^3)
                resultado = JOGADORES(1);
                break
            end
            if (linha==JOGADORES(2)^3)
                resultado = JOGADORES(2);
                break
            end        
        end            
    end
    %   Verificacao de diagonais
    if(resultado==1)
        for c=0:1
            linha = TABULEIRO(c*2 +1)*TABULEIRO(5)* TABULEIRO(-c*2 +9);
            if (linha==JOGADORES(1)^3)
                resultado = JOGADORES(1);
                break
            end
            if (linha==JOGADORES(2)^3)
                resultado = JOGADORES(2);
                break
            end        
        end            
    end
end
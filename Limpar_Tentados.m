%   FUNCAO DE LIMPAR O TABULEIRO DE POSSIBILIDADES

function limpo = Limpar_Tentados(tabuleiro, TENTADO)

    for c=1:size(tabuleiro,2)
        if(tabuleiro(c)==TENTADO)
            tabuleiro(c)=1;
        end
    end
    
    limpo = tabuleiro;
end
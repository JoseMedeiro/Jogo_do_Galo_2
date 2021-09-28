%   FUNCAO DE REESCREVER JOGADA

function vetor = Reescrever_Jogada(MOVIMENTOS, RESULTADO, TAMANHO, LIMITE_JOGADAS)

    vetor.movimentos    = zeros(1, LIMITE_JOGADAS);
    
    vetor.status        = RESULTADO;
    vetor.tamanho       = TAMANHO;
    if(TAMANHO > 0)
        for c=1:TAMANHO

            vetor.movimentos(c) = MOVIMENTOS(c);

        end
    end
    
end
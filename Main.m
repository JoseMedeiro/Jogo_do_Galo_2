%   Constantes
NULO            = 0;
JOGADORES       = 2:3;
TENTADO         = 4;
LIMITE_JOGADAS  = 9;
%   Estados
EM_JOGO         = 0;
VITORIA         = 1;
EMPATE          = 2;
SEM_OPCOES      = 3;
TRANSIENTE      = 4;

%   Criar um tabuleiro limpo
tabuleiro   = 1:9;
tabuleiro   = tabuleiro.^0;

jogadas(1).tamanho      = 0;
jogadas(1).status       = 0;
jogadas(1).movimentos   = zeros(1, LIMITE_JOGADAS);

%   Vamos testar uma jogada que da vitoria

%jogadas(1).tamanho      = 2;
%jogadas(1).status       = 0;
%jogadas(1).movimentos   = zeros(1, LIMITE_JOGADAS);
%jogadas(1).movimentos   = [8, 5, 3,  
%jogadas(2) = jogadas(1);

for c=1:jogadas(1).tamanho
    tabuleiro = Fazer_Jogada_1(tabuleiro, jogadas(1).movimentos(c), JOGADORES(2 - mod(c,2)));
end

ESTADO_CONCLUSAO        = EM_JOGO;
jogada_atual            = 1;
while ~(jogadas(1).tamanho==0 && jogadas(1).status~=0)
    
    %   Verifica-se se o jogo corrente foi ganho
    if (ESTADO_CONCLUSAO==EM_JOGO)
        if (Vitoria(tabuleiro, JOGADORES)~=1)
            ESTADO_CONCLUSAO = VITORIA;
            jogadas(jogada_atual).status = Vitoria(tabuleiro, JOGADORES);
        end
    end
    %   Se o jogo ainda se estiver a jogar ou estivermos a recuar
    if(ESTADO_CONCLUSAO~=VITORIA && ESTADO_CONCLUSAO~=SEM_OPCOES)
        %   Procuram-se as jogadas possiveis
        JOGADAS_POSSIVEIS   = Jogadas_Possiveis(tabuleiro, LIMITE_JOGADAS);
        tabuleiro           = Limpar_Tentados(tabuleiro, TENTADO);
        %   Verifica-se se o jogo corrente foi empatado
        if(size(JOGADAS_POSSIVEIS,2)==0)
            if (ESTADO_CONCLUSAO==EM_JOGO)
                ESTADO_CONCLUSAO = EMPATE;
                jogadas(jogada_atual).status = 1;
            else
                ESTADO_CONCLUSAO = SEM_OPCOES;
            end
        %   Realiza-se a proxima jogada
        else
            %   Escolhe a jogada
            %alternativa = ceil(rand*(size(JOGADAS_POSSIVEIS,2)));
            %   Atualiza a linha temporal
            jogadas(jogada_atual).tamanho   = jogadas(jogada_atual).tamanho +1;
            jogadas(jogada_atual).status    = 0;
            jogadas(jogada_atual).movimentos(jogadas(jogada_atual).tamanho) = JOGADAS_POSSIVEIS(1);
            %   Coloca a jogada no tabuleiro
            tabuleiro = Fazer_Jogada_1(tabuleiro, jogadas(jogada_atual).movimentos(jogadas(jogada_atual).tamanho), JOGADORES(2 - mod(jogadas(jogada_atual).tamanho,2)));
            
            ESTADO_CONCLUSAO = EM_JOGO;
        end
    end
    %   Se o jogo acabou
    if (ESTADO_CONCLUSAO~=EM_JOGO)
        if(jogadas(jogada_atual).tamanho > 0)
            tabuleiro = Desfazer_Jogada_1(tabuleiro, jogadas(jogada_atual).movimentos(jogadas(jogada_atual).tamanho));
        end
        tabuleiro = Limpar_Tentados(tabuleiro, TENTADO);
        switch ESTADO_CONCLUSAO
     	% 	E for vitoria 
            case VITORIA
                %   Encontramos todos os que tenham percursos semenhantes (e que
                %   ficaram agora obseletos)
                if(jogadas(jogada_atual).tamanho-1 > 0)
                    mais_antigo = Jogada_Igual(jogadas, jogada_atual, jogadas(jogada_atual).tamanho-1);
                else
                    mais_antigo = 1;
                end
                ESTADO_CONCLUSAO = TRANSIENTE;
        %	E for empate
            case EMPATE
                mais_antigo = jogada_atual;
                jogadas(jogada_atual).tamanho = jogadas(jogada_atual).tamanho +1;
                ESTADO_CONCLUSAO = TRANSIENTE;
        %	E se não houver mais opcoes    
            case SEM_OPCOES
                ESTADO_CONCLUSAO = TRANSIENTE;
                %   Encontramos todos os que tenham percursos semenhantes
                mais_antigo = Jogada_Igual(jogadas, jogada_atual, jogadas(jogada_atual).tamanho);
                %   Encontramos o resultado otimo destas jogadas
                    %   Se for jogada impar
                if (mod(jogadas(jogada_atual).tamanho,2)==1)
                    jogadas(jogada_atual).status = Resultado_Otimo(jogadas(mais_antigo:jogada_atual),[3, 1, 2]);
                    if(jogadas(jogada_atual).status==2)
                        ESTADO_CONCLUSAO = SEM_OPCOES;
                    end                      
                    %   Se for jogada par
                else
                    jogadas(jogada_atual).status = Resultado_Otimo(jogadas(mais_antigo:jogada_atual),[2, 1, 3]);
                    if(jogadas(jogada_atual).status==3)
                        ESTADO_CONCLUSAO = SEM_OPCOES;
                    end   
                end
                jogadas(jogada_atual).tamanho = jogadas(jogada_atual).tamanho +1;
        end
        %   Substituicao dos dados do mais antigo pelo novo
        jogadas(mais_antigo) = Reescrever_Jogada(jogadas(jogada_atual).movimentos,jogadas(jogada_atual).status,jogadas(jogada_atual).tamanho-1,LIMITE_JOGADAS);
        for c=(mais_antigo+1):jogada_atual
            jogadas(c) = Reescrever_Jogada(jogadas(jogada_atual).movimentos,0,0,LIMITE_JOGADAS);
        end
            
        %   Criacao de uma nova tentativa
        jogada_atual = mais_antigo + 1;
        if(jogadas(mais_antigo).tamanho > 0)
            b = 1;
        else
            b = 0;
        end
        jogadas(jogada_atual) = Reescrever_Jogada(jogadas(mais_antigo).movimentos,jogadas(mais_antigo).status,jogadas(mais_antigo).tamanho-b,LIMITE_JOGADAS);
        
        %   Para debug
        %if(jogadas(jogada_atual).tamanho==0&&jogadas(1).tamanho==1)
        %    a = jogadas(mais_antigo);
        %end
        
        %   Vai colocar as jogadas tentadas no tabuleiro
        mais_antigo = Jogada_Igual(jogadas, jogada_atual, jogadas(jogada_atual).tamanho);
        tabuleiro   = Colocar_Tentados(tabuleiro, jogadas(mais_antigo:(jogada_atual-1)), jogadas(jogada_atual).tamanho+1);
    end
    
end

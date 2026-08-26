#!/bin/bash

sudo chown -R $USER:$USER ./flow ./frontend
docker compose up -d

# --- LÓGICA DO SPINNER E VERIFICAÇÃO ---
echo ""
echo -n "Instalando o Next.js e dependências. Isso pode levar alguns minutos... "

spinner() {
    local mensagem="$1"       # O primeiro texto que você passar
    local duracao_segundos="$2" # O tempo em segundos
    local spin='-\|/'
    local i=0
    
    # Calcula em que segundo o spinner deve parar
    local fim=$(( SECONDS + duracao_segundos ))

    # Continua rodando enquanto o tempo atual for menor que o tempo final
    while [ $SECONDS -lt $fim ]; do
        i=$(( (i+1) % 4 ))
        printf "\r%s %s" "$mensagem" "${spin:$i:1}"
        sleep 0.25 # Tempo menor para o spinner girar mais suavemente
    done

    # Limpa a linha e mostra a mensagem de conclusão
    printf "\r%s Concluído! ✅ \n" "$mensagem"
}

# Caracteres do spinner
spin='-\|/'
i=0

# Loop que verifica os logs do frontend aguardando a inicialização do Next.js
while ! docker compose logs frontend | grep -qiE "Success!"; do
    
    # Prevenção de loop infinito: verifica se o container "morreu" por algum erro
    STATUS=$(docker compose ps -q frontend | xargs docker inspect -f '{{.State.Status}}' 2>/dev/null)
    if [ "$STATUS" != "running" ]; then
        echo -e "\n❌ Erro: O container do frontend parou inesperadamente."
        echo "Verifique o que aconteceu rodando: docker compose logs frontend"
        exit 1
    fi
    
    # Atualiza o spinner no terminal
    i=$(( (i+1) %4 ))
    printf "\rInstalando o Next.js e dependências. Isso pode levar alguns minutos... ${spin:$i:1}"
    sleep 0.5
done

# Limpa o spinner e mostra mensagem de sucesso
printf "\rInstalando o Next.js e dependências. Isso pode levar alguns minutos... Concluído! ✅ \n"
# ---------------------------------------


spinner "Finalizando a instalação do Next.js. Aguarde..." 5
echo ""

spinner "Ajustando permissões dos novos arquivos..." 1
sudo chown -R $USER:$USER ./flow ./frontend
echo ""

spinner "Desconectando do template base e criando um novo repositório..." 1
rm -rf .git 
git init 
echo ""

spinner "Gerando commit inicial do seu repositório local..." 1
git add .
git commit -m "feat: initial commit from template dc-mes"
echo ""

spinner "Removendo o script de instalação..." 1
rm -- "$0" 

echo ""
echo "------------------------------------------------------"
echo "✅ Ambiente pronto! Acesse no seu navegador:"
echo "👉 Next.js:  http://localhost:${NEXT_PORT:-3000}"
echo "👉 Node-RED: http://localhost:${NODERED_PORT:-1880}"
echo "------------------------------------------------------"

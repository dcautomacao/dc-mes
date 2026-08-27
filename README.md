# Instalação
1. No terminal digite o comando `git clone git@github.com:dcautomacao/dc-mes.git <nome do projeto>`. Por padrão use `dc-mes_<nome-do-cliente>`.
2. Em seguida entre na pasta do projeto `cd <nome-do-projeto>`.
3. Peça ao administrador o arquivo de variáveis de ambiente (`.env`) e copie para a pasta raíz do seu projeto.
4. De volta ao terminal digite `./install.sh`. Em seguida digite a senha de SUDO do seu computador, caso solicite.
5. Aguarde a instalação finalizar.
6. Muito provavelmente você vai precisar de um outro arquivo de variáveis de ambiente (`.env`), específico para o *frontend*, solicite ao administrador e copie para a pasta `/frontend` do seu projeto.
7. Reinicie os containers do Docker para que as variáveis de ambiente sejam adicionadas em tempo de execução. Na raiz do projeto digite `docker compose restart`.
8. Pronto! Pode iniciar o desenvolvimento.

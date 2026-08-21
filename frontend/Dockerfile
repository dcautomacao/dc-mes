# ./frontend/Dockerfile
FROM node:20-alpine

WORKDIR /frontend

# Copia apenas os arquivos de dependências primeiro (otimiza o cache do Docker)
COPY package*.json ./
RUN npm ci

# Copia o resto do código
COPY . .

ARG NEXT_PUBLIC_APP_NAME
ARG NEXT_PUBLIC_APP_SLUG
ARG NEXT_PUBLIC_APP_DESCRIPTION

ENV NEXT_PUBLIC_APP_NAME=$NEXT_PUBLIC_APP_NAME
ENV NEXT_PUBLIC_APP_SLUG=$NEXT_PUBLIC_APP_SLUG
ENV NEXT_PUBLIC_APP_DESCRIPTION=$NEXT_PUBLIC_APP_DESCRIPTION

# Faz o build de produção do Next.js
# Atenção: O Next.js precisa das variáveis NEXT_PUBLIC_ no momento do build!
RUN npm run build

# Expõe a porta e inicia o servidor de produção
EXPOSE 3000
CMD ["npm", "start"]
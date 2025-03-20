FROM node:22-alpine

WORKDIR /usr/src/app

COPY ./packages ./packages
COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json
COPY ./bun.lock /bun.lock
COPY ./turbo.json ./turbo.json 

RUN npm install

COPY ./apps/websocket ./apps/websocket

COPY . .

RUN bun install
RUN bun run db:generate

EXPOSE 8081

CMD ["bun", "run", "start:websocket"]
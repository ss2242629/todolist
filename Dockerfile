FROM node:18.17.0 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ENV NODE_OPTIONS --openssl-legacy-provider
RUN npm run build

FROM node:18.17.0-slim AS final
WORKDIR /app
ENV NODE_OPTIONS --openssl-legacy-provider
COPY --from=build /app .
#COPY --from=build /app/package*.json ./
EXPOSE 4000
CMD ["npm","start"]

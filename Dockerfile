FROM node:24 AS build
WORKDIR /app
COPY src src
COPY package*.json .
COPY tsconfig*.json .
RUN npm install
RUN npm run build

FROM node:24-alpine AS run
WORKDIR /app
COPY package*.json .
COPY --from=build /app/dist /app/dist
RUN npm install --only=production
CMD ["node", "dist/main.js"]
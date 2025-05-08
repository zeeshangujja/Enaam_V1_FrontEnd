# Stage 1: Build React App
FROM node:18-alpine as build

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve React App
FROM node:18-alpine

WORKDIR /app
RUN npm install -g serve

COPY --from=build /app/build ./build

EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]


FROM node:16-alpine as builder
WORKDIR '/app'

COPY package.json .
RUN npm config set strict-ssl false --global
RUN npm install npm -g --ca=""
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

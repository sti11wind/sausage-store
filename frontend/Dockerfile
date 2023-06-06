FROM node:8 as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


FROM nginxproxy/nginx-proxy
WORKDIR /app
COPY --from=builder /usr/src/app/dist/frontend ./frontend/
COPY --from=builder /usr/src/app/*.json ./
COPY ./nginx.tmpl /app/nginx.tmpl
EXPOSE 80


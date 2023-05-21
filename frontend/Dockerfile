FROM node:8 AS builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install 
RUN npm build

FROM node:16-alpine
WORKDIR /usr/src/app
RUN npm install -g http-server
COPY --from=builder /usr/src/app/dist/frontend  ./frontend/
COPY --from=builder /usr/src/app/dist/*.json  ./
RUN ls -lsa
EXPOSE 80
ENTRYPOINT ["http-server", "./public_html/", "-p", "80", "--proxy", "http://backend:8080"]

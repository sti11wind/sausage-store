FROM node:8 as builder
# Create app directory
WORKDIR /usr/src/app
RUN npm install
RUN npm run build
COPY . .

FROM node:16-alpine
WORKDIR /usr/src/app
RUN npm install -g http-server
COPY --from=builder /usr/src/app/dist/frontend ./fontend/
COPY --from=builder /usr/src/app/dist/*.json ./
RUN ls -lsa
EXPOSE 80
ENTRYPOINT ["http-server", "frontend/", "-p", "80", "--proxy", "http://backend:8080"]

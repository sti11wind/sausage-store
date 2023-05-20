FROM node:14.17.3-slim
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm install -g http-server
EXPOSE 80
ENTRYPOINT ["http-server", "./public_html/", "-p", "80", "--proxy", "http://backend:8080"]

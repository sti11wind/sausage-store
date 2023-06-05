FROM python:3.9-slim
RUN apt-get update && apt-get install -y \
curl
COPY app /app
WORKDIR /app
RUN curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080

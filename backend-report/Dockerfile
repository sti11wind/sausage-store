FROM python:latest
ADD app /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt && keytool -importcert -file YandexInternalRootCA.crt \
    -alias yandex -cacerts -storepass changeit -noprompt \
    && rm -rf YandexInternalRootCA.crt \
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080

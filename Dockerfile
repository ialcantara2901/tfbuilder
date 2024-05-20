# Use uma imagem base Python
FROM python:3.9-alpine
    
# Instale as dependências Python
RUN pip install --upgrade pip
RUN pip install pika
RUN pip install python-dotenv

# Copie o código fonte para o contêiner
COPY ./app /app
WORKDIR /app

# Execute o aplicativo
CMD ["python", "app.py"]
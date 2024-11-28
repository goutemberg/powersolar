FROM python:3.11.3-alpine3.18
LABEL maintainer="goutemberg@icloud.com"

# Variáveis de ambiente
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Diretório de trabalho no container
WORKDIR /projeto_solar

# Copiar arquivos necessários para o projeto
COPY ./ /projeto_solar
COPY scripts /scripts
COPY requirements.txt /projeto_solar/requirements.txt

# Instalar dependências e configurar ambiente
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /projeto_solar/requirements.txt && \
    adduser --disabled-password --no-create-home duser && \
    mkdir -p /data/web/static && \
    mkdir -p /data/web/media && \
    mkdir -p /projeto_solar/staticfiles && \
    chown -R duser:duser /projeto_solar/staticfiles && \
    chown -R duser:duser /venv && \
    chown -R duser:duser /data/web/static && \
    chown -R duser:duser /data/web/media && \
    chmod -R 755 /data/web/static && \
    chmod -R 755 /data/web/media && \
    chmod -R 755 /projeto_solar/staticfiles && \
    chmod -R +x /scripts

# Definir variáveis de ambiente para o PATH
ENV PATH="/scripts:/venv/bin:$PATH"

# Usuário não root
USER duser

# Porta exposta
EXPOSE 8000

# Comando para iniciar o projeto
CMD ["commands.sh"]

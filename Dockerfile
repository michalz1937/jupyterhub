# Bazowy obraz z JupyterHub
FROM jupyterhub/k8s-hub:latest

# Przełącz na użytkownika root
USER root

# Instalacja Pythona 3.6 i niezbędnych narzędzi
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y \
    python3.6 \
    python3.6-venv \
    python3.6-dev \
    python3-pip \
    libkrb5-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Ustawienie Pythona 3.6 jako domyślnego
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 \
    && update-alternatives --set python3 /usr/bin/python3.6

# Aktualizacja pip dla Python 3.6
RUN python3 -m pip install --upgrade pip

# Instalacja PySpark 2.3.2 (zgodnego z Pythonem 3.6)
RUN pip3 install pyspark==2.3.2

# Opcjonalne: Kopiowanie konfiguracji Kerberosa, Hadoop lub innych plików
#COPY krb5.conf /etc/krb5.conf
#COPY hadoop_conf/* /etc/hadoop/conf/

# Ustawienie zmiennych środowiskowych
ENV SPARK_HOME=/usr/local/spark \
    PYSPARK_PYTHON=python3 \
    PYSPARK_DRIVER_PYTHON=python3 \
    HADOOP_CONF_DIR=/etc/hadoop/conf \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PATH="$PATH:/usr/local/spark/bin:/usr/local/spark/sbin"

# Powrót do użytkownika non-root (domyślnie jovyan)
USER jovyan

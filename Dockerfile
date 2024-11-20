FROM michalz1937/jupyterhub:latest

USER root
# Ustaw zmienne środowiskowe, aby zapobiec interaktywnym zapytaniom
# Zainstaluj virtualenv
#RUN python3.7 -m pip install --upgrade pip && \
#    python3.7 -m pip install virtualenv

# Utwórz nowe środowisko wirtualne
#RUN python3.7 -m venv /opt/venv

# Aktywuj środowisko wirtualne i zainstaluj pyspark 2.3.2 oraz Jupyter
#RUN /opt/venv/bin/pip install pyspark==2.3.2 jupyter

# Zainstaluj kernel Jupyter dla środowiska wirtualnego
#RUN /opt/venv/bin/python -m pip install ipykernel && \
#    /opt/venv/bin/python -m ipykernel install --user --name=pyspark-2.3.2 --display-name "Python 3.7 (PySpark 2.3.2)"

# Sprawdzenie wersji Pythona i pyspark w środowisku
#RUN /opt/venv/bin/python --version && \
#    /opt/venv/bin/python -c "import pyspark; print(pyspark.__version__)"

# Instalacja Javy i Spark
RUN apt-get update && apt-get install -y openjdk-8-jdk curl && \
    curl -o /tmp/spark.tgz https://archive.apache.org/dist/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz && \
    tar -xzf /tmp/spark.tgz -C /opt && \
    ln -s /opt/spark-2.3.2-bin-hadoop2.7 /opt/spark && \
    rm /tmp/spark.tgz

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Instalacja PySpark i klienta HDFS kompatybilnego z Hadooop 2.7
RUN pip install pyspark==2.3.2 hdfs==2.5.8

# Kopia plików konfiguracyjnych Spark
#COPY spark-defaults.conf $SPARK_HOME/conf/
#COPY hdfs-site.xml /etc/hadoop/
#COPY core-site.xml /etc/hadoop/

#USER jovyan

FROM quay.io/jupyterhub/k8s-singleuser-sample:4.0.0

# Ustawienie zmiennej środowiskowej dla debiana, aby działał bez interakcji
ARG DEBIAN_FRONTEND=noninteractive

# Instalacja Pythona 3.6
RUN apt-get update && \
    apt-get install -y python3.6 python3.6-dev python3-pip && \
    python3.6 -m pip install --upgrade pip

# Instalacja PySpark 2.3.2
RUN python3.6 -m pip install pyspark==2.3.2

# Dodanie nowego kernela do Jupyter
RUN python3.6 -m pip install ipykernel && \
    python3.6 -m ipykernel install --name "python3.6-pyspark-2.3.2" --display-name "Python 3.6 with PySpark 2.3.2"

# Czyszczenie niepotrzebnych plików
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ustawienie Pythona 3.6 jako domyślnego python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1

USER $NB_UID

# Uruchomienie kontenera
CMD ["start-singleuser.sh"]

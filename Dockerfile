FROM quay.io/jupyterhub/k8s-singleuser-sample:4.0.0

USER root
# Ustaw zmienne środowiskowe, aby zapobiec interaktywnym zapytaniom
ENV DEBIAN_FRONTEND=noninteractive

# Zaktualizuj system i zainstaluj wymagane pakiety, w tym 'software-properties-common'
RUN apt update && \
    apt install -y \
    software-properties-common \
    curl \
    lsb-release \
    gnupg2 \
    ca-certificates

# Dodaj repozytorium deadsnakes, aby zainstalować Pythona 3.7
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt update

# Zainstaluj Pythona 3.7 oraz inne przydatne narzędzia (np. pip)
RUN apt install -y python3.7 python3.7-distutils python3.7-dev

# Zainstaluj pip dla Pythona 3.7
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.7 get-pip.py

# Ustaw Python 3.7 jako domyślny dla python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

# Zainstaluj pip dla Pythona 3.7, aby można było instalować pakiety
RUN python3 -m pip install --upgrade pip

# Sprawdź zainstalowaną wersję Pythona i pip
RUN python3 --version && python3 -m pip --version

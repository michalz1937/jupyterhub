FROM quay.io/jupyterhub/k8s-singleuser-sample:4.0.0

USER root
# Ustaw zmienne środowiskowe, aby zapobiec interaktywnym zapytaniom
ENV DEBIAN_FRONTEND=noninteractive

# Zaktualizuj system i zainstaluj wymagane pakiety, w tym curl, build-essential i zależności dla Pythona
RUN apt update && \
    apt install -y \
    build-essential \
    curl \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    liblzma-dev \
    tk-dev \
    libffi-dev \
    libsqlite3-dev \
    libreadline-dev \
    libncursesw5-dev \
    libgdbm-compat-dev \
    ca-certificates \
    git

# Pobierz i zbuduj Pythona 3.7
RUN wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz && \
    tar -xvzf Python-3.7.9.tgz && \
    cd Python-3.7.9 && \
    ./configure --enable-optimizations && \
    make -j 4 && \
    make altinstall

# Ustaw Python 3.7 jako domyślny dla python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 1

# Zainstaluj pip dla Pythona 3.7 (z dedykowanego linku)
RUN curl https://bootstrap.pypa.io/pip/3.7/get-pip.py -o get-pip.py && \
    python3.7 get-pip.py

# Zainstaluj pip dla Pythona 3.7, aby można było instalować pakiety
RUN python3 -m pip install --upgrade pip

# Sprawdź zainstalowaną wersję Pythona i pip
RUN python3 --version && python3 -m pip --version


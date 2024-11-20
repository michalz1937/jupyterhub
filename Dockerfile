FROM quay.io/jupyterhub/k8s-singleuser-sample:4.0.0

USER root

RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt update

# Zainstaluj Pythona 3.7 oraz inne przydatne narzędzia (np. pip)
RUN apt install -y python3.7 python3.7-distutils python3.7-dev

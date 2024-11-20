FROM michalz1937/jupyterhub:latest

USER root
# Ustaw zmienne środowiskowe, aby zapobiec interaktywnym zapytaniom
# Zainstaluj virtualenv
RUN python3.7 -m pip install --upgrade pip && \
    python3.7 -m pip install virtualenv

# Utwórz nowe środowisko wirtualne
RUN python3.7 -m venv /opt/venv

# Aktywuj środowisko wirtualne i zainstaluj pyspark 2.3.2 oraz Jupyter
RUN /opt/venv/bin/pip install pyspark==2.3.2 jupyter

# Zainstaluj kernel Jupyter dla środowiska wirtualnego
RUN /opt/venv/bin/python -m pip install ipykernel && \
    /opt/venv/bin/python -m ipykernel install --user --name=pyspark-2.3.2 --display-name "Python 3.7 (PySpark 2.3.2)"

# Sprawdzenie wersji Pythona i pyspark w środowisku
RUN /opt/venv/bin/python --version && \
    /opt/venv/bin/python -c "import pyspark; print(pyspark.__version__)"

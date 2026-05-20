# Usar una imagen base oficial de Python ligera y compatible con bibliotecas científicas
FROM python:3.10-slim

# Evitar diálogos interactivos durante la instalación de paquetes de Debian
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema y compiladores necesarios para compilar CPS y pysurf96
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    libx11-dev \
    libncurses-dev \
    git \
    libgfortran5 \
    && rm -rf /var/lib/apt/lists/*

# Actualizar pip e instalar dependencias básicas de Python de forma directa y limpia
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    numpy \
    scipy \
    matplotlib \
    obspy \
    pathos \
    scikit-learn \
    dill

# Instalar pysurf96 para disponer de todas las capacidades nativas de curvas de dispersión en pyBEL1D
RUN pip install --no-cache-dir --no-build-isolation git+https://github.com/hadrienmichel/pysurf96

# Copiar y compilar CPS en un directorio del sistema (/opt/CPS) a salvo de montajes de volumen
COPY CPS /opt/CPS

# Re-compilar CPS dentro de su ruta destino
RUN cd /opt/CPS/PROGRAMS.330 && \
    ./Setup LINUX6440 && \
    ./C

# Establecer la variable de entorno para que el script de Python localice los binarios de CPS compatibles con el contenedor
ENV CPS_BIN=/opt/CPS/PROGRAMS.330/bin

# Configurar el directorio de trabajo principal en el contenedor
WORKDIR /app

# Copiar el resto del contenido del proyecto local al contenedor
COPY . /app

# Definir el comando por defecto para ejecutar la inversión del campo de ondas
CMD ["python", "main_wavefield.py"]

# MASW Seismic Inversion Pipeline

Este proyecto contiene una canalización (pipeline) para la inversión del campo de ondas utilizando **pyBEL1D** y **CPS (Computer Programs in Seismology)**.

---

## Requisitos Previos para Windows

Para ejecutar este proyecto en Windows, se requiere **Docker Desktop** con el motor de **WSL2 (Windows Subsystem for Linux)** activado.
* **WSL2** es el entorno de Linux en Windows que permite la compatibilidad y el rendimiento óptimo de las herramientas científicas compiladas (como CPS).

---

## Instrucciones de Ejecución

### 1. Construir la Imagen de Docker

Abre tu terminal y ejecuta:

```bash
docker build -t masw-inversion .
```

### 2. Ejecutar el Contenedor

Dependiendo de la terminal que utilices en tu sistema operativo, el comando para montar el volumen actual varía:

#### 🐧 En Linux y macOS (o Git Bash en Windows):
```bash
docker run --rm -v $(pwd):/app masw-inversion
```

#### 🪟 En Windows (PowerShell):
```bash
docker run --rm -v ${PWD}:/app masw-inversion
```

#### 🪟 En Windows (Símbolo del Sistema / CMD):
```bash
docker run --rm -v %cd%:/app masw-inversion
```

---

## Diagnóstico y Notas Técnicas para Windows

Si experimentas problemas al compilar o ejecutar en Windows, ten en cuenta lo siguiente:

1. **Saltos de Línea (CRLF vs LF):** 
   Windows utiliza de manera predeterminada saltos de línea del tipo `CRLF` (`\r\n`), mientras que Linux utiliza `LF` (`\n`). Si clonas este repositorio en Windows sin configuración adicional, los scripts de CPS y compilación darán errores como `\r: command not found`.
   * **Solución implementada:** Se ha agregado un archivo `.gitattributes` en la raíz del proyecto para asegurar que Git siempre descargue los archivos con formato `LF`, previniendo este problema de forma automática al clonar.

2. **Ejecución Nativa (Sin Docker):**
   No se recomienda ejecutar `main_wavefield.py` directamente en Windows nativo, ya que **CPS** está compuesto por binarios ELF de Linux y **pysurf96** (dependencia de pyBEL1D) requiere compiladores nativos C/Fortran (`gcc`, `gfortran`) para instalarse. Si deseas ejecutarlo de forma nativa en Windows, se sugiere hacerlo dentro de un entorno **WSL2** (Ubuntu/Debian) o mediante **MSYS2**.
## Instrucciones de Ejecución

### 1. Construir la Imagen de Docker
```bash
docker build -t masw-inversion .
```

### 2. Ejecutar el Contenedor

#### En Linux:
```bash
docker run --rm -v $(pwd):/app masw-inversion
```

#### En Windows:
```bash
docker run --rm -v ${PWD}:/app masw-inversion
```
Para construir el contenedor:
docker build -t masw-inversion .

Para ejecutar el contenedor:
docker run --rm -v $(pwd):/app masw-inversion
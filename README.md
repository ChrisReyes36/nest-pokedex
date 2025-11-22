<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

## Ejecutar en desarrollo

1. Clonar repositorio
2. Ejecutar

```bash
yarn install
```

3. Tener Nest CLI instalado

```bash
npm i -g @nestjs/cli
```

4. Clonar el archivo ```.env.example``` y renombrar la copia a __.env__

5. Llenar las variables de entorno definidas en el ```.env```

6. Compilar y correr el proyecto

```bash
# desarrollo
yarn run start

# observar
yarn run start:dev

# producción
yarn run start:prod
```

7. Levantar la base de datos

```bash
docker compose up -d
```

8. Reconstruir la base de datos con la semilla

```bash
http://localhost:3000/api/v2/seed
```

## Stack usado

* MongoDB
* Nest

# Production Build
1. Crear el archivo ```.env.prod```
2. Llenar las variables de entorno de prod
3. Crear la nueva imagen
```
docker-compose -f docker-compose.prod.yaml --env-file .env.prod up --build
```
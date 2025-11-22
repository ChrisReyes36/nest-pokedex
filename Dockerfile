# FROM node:22-alpine3.22

# # Establecer directorio de trabajo
# RUN mkdir -p /var/www/pokedex
# WORKDIR /var/www/pokedex

# # Copiar el directorio y su contenido
# COPY . ./var/www/pokedex
# COPY package.json tsconfig.json tsconfig.build.json /var/www/pokedex/
# RUN yarn install --prod
# RUN yarn build


# # Dar permiso para ejecutar la aplicación
# RUN adduser --disabled-password pokeuser
# RUN chown -R pokeuser:pokeuser /var/www/pokedex
# USER pokeuser

# # Limpiar el caché
# RUN yarn cache clean --force

# EXPOSE 3000

# CMD [ "yarn","start" ]

# Instalar dependencias solo cuando sea necesario
FROM node:22-alpine3.22 AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Construya la aplicación con dependencias de caché
FROM node:22-alpine3.22 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN yarn build


# Imagen de producción, copie todos los archivos y ejecute el siguiente
FROM node:22-alpine3.22 AS runner

# Establecer directorio de trabajo
WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install --prod

COPY --from=builder /app/dist ./dist

# # Copiar el directorio y su contenido
# RUN mkdir -p ./pokedex

# COPY --from=builder ./app/dist/ ./app
# COPY ./.env ./app/.env

# # Dar permiso para ejecutar la applicación
# RUN adduser --disabled-password pokeuser
# RUN chown -R pokeuser:pokeuser ./pokedex
# USER pokeuser

# EXPOSE 3000

CMD [ "node","dist/main" ]

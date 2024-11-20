# Utiliza una imagen base de Node.js
FROM node:18-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copia el archivo package.json y package-lock.json (si existe) al contenedor
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todo el código fuente del servidor al contenedor
COPY . .

# Expone el puerto en el que la app va a correr (puedes cambiarlo si lo necesitas)
EXPOSE 4000

# Comando para iniciar la aplicación cuando el contenedor esté listo
CMD ["node", "producer-julian.js"]


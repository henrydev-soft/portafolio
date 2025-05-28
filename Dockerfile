# Etapa de construcción
FROM node:22 AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Etapa de producción con NGINX
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Remueve archivos por defecto y copia configuración (opcional)
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80
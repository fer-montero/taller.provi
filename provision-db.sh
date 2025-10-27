#!/usr/bin/env bash
set -e

echo "==> Instalando PostgreSQL y configurando base de datos..."

# Actualizar paquetes e instalar PostgreSQL
sudo apt-get update -y
sudo apt-get install -y postgresql postgresql-contrib

# Detectar versión de PostgreSQL instalada
PG_VERSION=$(ls /etc/postgresql | head -n1)
PG_CONF="/etc/postgresql/${PG_VERSION}/main/postgresql.conf"
PG_HBA="/etc/postgresql/${PG_VERSION}/main/pg_hba.conf"

# Configurar para aceptar conexiones desde la red privada
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" "$PG_CONF"
echo "host    all             all             192.168.56.0/24            md5" | sudo tee -a "$PG_HBA"

# Reiniciar el servicio
sudo systemctl restart postgresql

# Crear usuario y base de datos de prueba
sudo -u postgres psql <<EOF
CREATE ROLE vagrant WITH LOGIN PASSWORD 'vagrantpass';
CREATE DATABASE prueba_db OWNER vagrant;
\c prueba_db
CREATE TABLE personas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100)
);
INSERT INTO personas (nombre, correo) VALUES
('Ana Pérez','ana@example.com'),
('Juan López','juan@example.com');
EOF

echo "==> PostgreSQL configurado correctamente."
#debes completar este archivo con los comandos necesarios para provisionar la base de datos

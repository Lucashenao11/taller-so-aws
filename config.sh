#!/bin/bash

# Crea entorno virtual (usa venv)
python3 -m venv /home/ubuntu/venv

# Activa venv
source /home/ubuntu/venv/bin/activate

# Clona el repo de GitHub (reemplaza con tu URL)
git clone https://github.com/tu-usuario/taller-so-aws.git /home/ubuntu/taller-so-aws

# Entra al directorio
cd /home/ubuntu/taller-so-aws

# Instala librerías
pip install -r requirements.txt

# Configura el servicio systemd (copia el archivo)
sudo cp fastapi.srv /etc/systemd/system/fastapi.service

# Recarga systemd y inicia el servicio
sudo systemctl daemon-reload
sudo systemctl start fastapi
sudo systemctl enable fastapi

# Otras configs en EC2 (no en este script, hazlo manual):
# - Configura IAM role para EC2 con permisos S3 (AmazonS3FullAccess).
# - Abre puerto 80 en Security Group de EC2.

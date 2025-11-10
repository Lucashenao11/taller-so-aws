cat > config.sh << 'EOF'
#!/bin/bash
set -e

echo "Activando entorno virtual..."
source ~/venv/bin/activate

echo "Actualizando pip..."
pip install --upgrade pip

echo "Instalando dependencias..."
pip install fastapi uvicorn pydantic boto3

echo "Copiando servicio..."
sudo cp fastapi.srv /etc/systemd/system/fastapi.service

echo "Ajustando paths..."
sudo sed -i 's|/path/to/your/repo|/home/ubuntu/taller-so-aws|g' /etc/systemd/system/fastapi.service
sudo sed -i 's|/path/to/venv|/home/ubuntu/venv|g' /etc/systemd/system/fastapi.service

echo "Iniciando API..."
sudo systemctl daemon-reload
sudo systemctl restart fastapi
sudo systemctl enable fastapi

echo "¡API CORRIENDO EN http://35.170.64.81/insert !"
EOF

cat > config.sh << 'EOF'
#!/bin/bash
set -e

echo "Creando entorno virtual..."
python3 -m venv ~/venv
source ~/venv/bin/activate

echo "Instalando dependencias..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Copiando servicio..."
sudo cp fastapi.srv /etc/systemd/system/fastapi.service

echo "Ajustando paths..."
sudo sed -i 's|/path/to/your/repo|/home/ubuntu/taller-so-aws|g' /etc/systemd/system/fastapi.service
sudo sed -i 's|/path/to/venv|/home/ubuntu/venv|g' /etc/systemd/system/fastapi.service

echo "Iniciando API..."
sudo systemctl daemon-reload
sudo systemctl start fastapi
sudo systemctl enable fastapi

echo "¡API LISTA! IP: $(curl -s ifconfig.me)"
echo "Prueba: curl -X POST http://$(curl -s ifconfig.me)/insert -d '{\"nombre\":\"Test\",\"edad\":1,\"email\":\"t@t.com\"}'"
EOF

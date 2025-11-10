from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import boto3
import json
import uuid

app = FastAPI()

# Modelo Pydantic para validar los datos de la persona
class Persona(BaseModel):
    nombre: str
    edad: int
    email: str

# Configura boto3 para S3 (usa credenciales de IAM en EC2, no hardcodees keys)
s3 = boto3.client('s3')
BUCKET_NAME = 'mi-bucket-so-2025'

@app.post("/insert")
async def insert_persona(persona: Persona):
    try:
        # Genera un nombre único para el archivo JSON
        file_name = f"{uuid.uuid4()}.json"
        
        # Convierte el modelo a dict y luego a JSON
        persona_data = persona.model_dump()
        json_data = json.dumps(persona_data)
        
        # Sube el JSON a S3
        s3.put_object(Bucket=BUCKET_NAME, Key=file_name, Body=json_data, ContentType='application/json')
        
        # Cuenta los archivos en el bucket
        response = s3.list_objects_v2(Bucket=BUCKET_NAME)
        file_count = response.get('KeyCount', 0)
        
        return {"archivos_en_bucket": file_count}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

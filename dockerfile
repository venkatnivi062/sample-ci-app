FROM python:3.10-slim
 
WORKDIR /app
COPY requirement.txt .
RUN pip install -r requirement.txt
 
COPY . .
CMD ["python", "app.py"]

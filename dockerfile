#FROM python:3.10-slim
 
#WORKDIR /app
#COPY requirements.txt .
#RUN pip install -r requirements.txt
 
# COPY . .
#CMD ["python", "app.py"]

# Stage 1: Build
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim
WORKDIR /app

# Create non-root user
RUN useradd -m appuser
USER appuser

# Copy installed packages and source code
COPY --from=builder /root/.local /home/appuser/.local
COPY . .

# Exposing port
EXPOSE 5000

# Ensure PATH includes user-installed packages
ENV PATH=/home/appuser/.local/bin:$PATH

CMD ["python", "app.py"]

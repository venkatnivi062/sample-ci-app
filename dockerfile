# Stage 1: Builder
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

# Copy python dependencies
COPY --from=builder /root/.local /home/appuser/.local

# Copy application source code (THIS IS THE KEY)
COPY app.py .
COPY templates ./templates

ENV PATH=/home/appuser/.local/bin:$PATH
EXPOSE 5000

CMD ["python", "app.py"]

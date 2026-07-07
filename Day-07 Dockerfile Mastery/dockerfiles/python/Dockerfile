# ---- Stage 1: Install Dependencies ----
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --user --no-cache-dir -r requirements.txt

# ---- Stage 2: Final Runtime Image ----
FROM python:3.12-slim

WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /root/.local /root/.local

# Copy application source code
COPY . .

ENV PATH=/root/.local/bin:$PATH

# Run as non-root user
RUN useradd -m appuser
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]

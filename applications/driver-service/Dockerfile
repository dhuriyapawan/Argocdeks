FROM python:3.11.16-slim

RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app
COPY requirements.txt .
# If requirements.txt is empty, add a minimal requirement. Note: COPY will fail the build
# if requirements.txt is missing from the build context. This RUN only ensures a default
# content when the file exists but is empty. Merge check and install into one layer.
RUN ( [ -s requirements.txt ] || echo "Flask" > requirements.txt ) \
	&& pip install --no-cache-dir -r requirements.txt
COPY src/ /app/src/

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000
CMD ["python", "src/app.py"]

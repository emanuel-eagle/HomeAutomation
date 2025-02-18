FROM python:3.11

RUN pip3 install requests

# Copy function code
COPY weather_alerts.py ./

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD ["python", "weather_alerts.py"]

FROM public.ecr.aws/lambda/python:3.11

RUN pip3 install requests

# Copy function code
COPY weather_alerts/weather_alerts.py ${LAMBDA_TASK_ROOT}/

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD ["weather_alerts.lambda_handler"]

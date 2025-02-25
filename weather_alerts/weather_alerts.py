import requests 
import os

def rain_check(forecast_content):
    precip_info = forecast_content["probabilityOfPrecipitation"]
    if precip_info["value"] >= 30:
        return True
    return False

def lambda_handler(event, context):
    print("started")
    nws_url = os.environ["NWS_URL"]
    alert_range = int(os.environ["ALERT_RANGE"])
    ifttt_webhook = os.environ["WEBHOOK_URL"]
    print("got environmental variables")
    rain_alert_sent = False
    weather_request = requests.get(nws_url)
    # weather_response_content = weather_request.json()["properties"]["periods"][:alert_range]
    # for hourly_forecast in weather_response_content:
    #     forecast_time = hourly_forecast["startTime"]
    #     if rain_check(hourly_forecast) and rain_alert_sent == False:
    #         rain_alert_sent = True
    requests.post(ifttt_webhook)
    return {
            "statusCode": weather_request.status_code,
            "message": "Successfully ran alerting lambda."
        }
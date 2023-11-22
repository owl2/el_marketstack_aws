from tools.aws import get_secret
import requests
import boto3
from datetime import date
import json
# import logging


# logger = logging.getLogger()

today = date.today()


def handler(event, context):
    print("Begin the el_marketstack lambda function...")
    print("Get the secret...")
    marketstack_secret_manager = get_secret()
    secret = marketstack_secret_manager['marketstack_api']
    print("Got the secret")

    api_request = f"""http://api.marketstack.com/v1/eod?access_key={secret}&symbols=AAPL"""

    print("Call the marketapi ...")
    api_response = requests.get(api_request)
    data = api_response.json()
    print("Got the response.")

    s3 = boto3.client('s3')
    target_bucket = 'lmu-marketstack-poc'
    key = f"bronze/eod/marketstack_eod_aapl_{today.strftime('%d-%m-%Y')}.json"

    s3.put_object(Body=json.dumps(data), Bucket=target_bucket, Key=key)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


if __name__ == "__main__":
    handler(event={}, context="")

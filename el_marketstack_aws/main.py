from tools.aws import get_secret
import requests
import boto3
from datetime import date
import json


today = date.today()
marketstack_secret_api = get_secret()

def handler(event, context):
    api_endpoint = 'http://api.marketstack.com/v1/eod'

    params = {
        'access_key': marketstack_secret_api,
        'symbols': 'AAPL'
    }

    api_response = requests.get(api_endpoint, params=params)

    data = api_response.json()

    s3 = boto3.client('s3')
    target_bucket = 'lmu-marketstack-poc'
    key = f"bronze/eod/marketstack_eod_aapl_{today.strftime('%d-%m-%Y')}.json"

    s3.put_object(Body=json.dumps(data), Bucket=target_bucket, Key=key)

if __name__ == "__main__":
    event = {}
    context = ''
    handler(event, context)
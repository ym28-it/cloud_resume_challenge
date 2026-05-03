import boto3
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError


# --- Initialize ---
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('crc-prac-db')
COUNTER_ID = 'counter'

def lambda_handler(event, context):
    try:
        new_visitor = increase_visit_count()
        response = {
            "statusCode": 200,
            "headers": {
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            "body": str(new_visitor)
        }
        return response
    except ClientError as e:
        error_code = e.response['Error']['Code']
        print(f'DynamoDB error: {error_code}')
        raise

def increase_visit_count():
    response = table.update_item(
        Key={'id': COUNTER_ID},
        UpdateExpression='ADD #val :increment',
        ExpressionAttributeNames = {'#val': 'value'},
        ExpressionAttributeValues={':increment': 1},
        ReturnValues='ALL_NEW'
    )
    return response['Attributes']['value']

# visitor = 0
# def increase_visitor():
#     global visitor
#     visitor += 1
#     return visitor



def lambda_handler(event, context):
    new_visitor = increase_visitor()
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


visitor = 0
def increase_visitor():
    global visitor
    visitor += 1
    return visitor

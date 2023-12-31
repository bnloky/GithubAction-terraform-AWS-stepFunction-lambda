import json
import boto3

dynamodb = boto3.resource('dynamodb')
table_name = 'GameScores'  # Replace with your DynamoDB table name

def lambda_handler(event, context):
    # Parse the event data (if needed)
    data = json.loads(event['body'])

    # Access the DynamoDB table
    table = dynamodb.Table(table_name)

    # Add a new record to the DynamoDB table
    response = table.put_item(
        Item={
            'PrimaryKeyName': data['1'],
            'AttributeName1': data['football'],
            'AttributeName2': data['10'],
            # Add more attributes as needed
        }
    )

    return {
        'statusCode': 200,
        'body': json.dumps('Record added successfully')
    }

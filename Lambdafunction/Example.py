import boto3

# Initialize the DynamoDB client
dynamodb = boto3.client('dynamodb', region_name='ap-south-1')

# Define the table name
table_name = 'GameScorese'

# Define the item (record) you want to add
new_item = {
    'PrimaryKeyName': {'S': 'Primary_Key_Value'},
    'AttributeName1': {'S': 'Value1'},
    'AttributeName2': {'N': '123'},
    # Add more attributes as needed
}

# Add the item to the DynamoDB table
try:
    response = dynamodb.put_item(
        TableName=GameScores,
        Item=new_item
    )
    print("Item added successfully!")
except Exception as e:
    print(f"Error adding item: {str(e)}")

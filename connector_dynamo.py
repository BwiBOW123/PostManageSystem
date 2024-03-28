import boto3
from dotenv import load_dotenv
import os

def connDynamo():
    try:
        load_dotenv()
        dynamodb = boto3.resource('dynamodb', endpoint_url=os.getenv("dynamo_endpoint"))
        print("Connection to DynamoDB established successfully!")
        return dynamodb
    except Exception as e:
        print("Error connecting to DynamoDB:", e)
        return False

def create_item(table, item_data):
    try:
        response = table.put_item(Item=item_data)
        print("Item created successfully!")
        return True
    except Exception as e:
        print("Error creating item:", e)
        return False

def read_item(table, key):
    try:
        response = table.get_item(Key=key)
        item = response.get('Item')
        if item:
            print("Item found:", item)
            return item
        else:
            print("Item not found.")
            return None
    except Exception as e:
        print("Error reading item:", e)
        return None

def read_item_table(dynamodb,tableName):
    try:
        table = dynamodb.Table(tableName)
        response = table.scan()
        return response['Items']
    except Exception as e:
        print("Error scanning table:", e)
        return None
    


def update_item(table, key, update_expression, expression_attribute_values):
    try:
        response = table.update_item(
            Key=key,
            UpdateExpression=update_expression,
            ExpressionAttributeValues=expression_attribute_values,
            ReturnValues="UPDATED_NEW"
        )
        print("Item updated successfully!")
        return response.get('Attributes')
    except Exception as e:
        print("Error updating item:", e)
        return None

def delete_item(table, key):
    try:
        response = table.delete_item(Key=key)
        print("Item deleted successfully!")
        return True
    except Exception as e:
        print("Error deleting item:", e)
        return False

import json
import urllib.request
import boto3
import os

def lambda_handler(event, context):
    """
    Fetch NBA players data from Sportsdata.io API and upload it to an S3 bucket.
    """
    # Configuration
    API_KEY = os.getenv("SPORTSDATA_API_KEY")  # API key for Sportsdata.io
    S3_BUCKET = os.getenv("BUCKET_NAME")  
    API_URL = "https://api.sportsdata.io/v3/nba/scores/json/Players" # Target S3 bucket 
    
    # Validate configuration
    if not API_KEY or not S3_BUCKET:
        return {
            "statusCode": 500,
            "body": json.dumps("Missing configuration: Ensure API_KEY and S3_BUCKET are set.")
        }
    
    try:
        # Fetch players data from Sportsdata.io
        print("Fetching players data from Sportsdata.io...")
        headers = {"Ocp-Apim-Subscription-Key": API_KEY}
        req = urllib.request.Request(API_URL, headers=headers)
        
        with urllib.request.urlopen(req) as response:
            if response.status != 200:
                raise Exception(f"Failed to fetch data: {response.status}")

            # Parse response data
            original_data = response.read()
            players_data = json.loads(original_data.decode('utf-8'))
            
            # Convert to line-delimited JSON and upload to S3
            upload_data_to_s3(players_data, S3_BUCKET)
            
            return {
                "statusCode": 200,
                "body": json.dumps("Successfully uploaded NBA players data to S3")
            }
            
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps(f"Error: {str(e)}")
        }

def convert_to_line_delimited_json(data):
    """Convert data to line-delimited JSON format."""
    print("Converting data to line-delimited JSON format...")
    return "\n".join([json.dumps(record) for record in data])    

def upload_data_to_s3(data, bucket_name):
    """Upload NBA data to the S3 bucket."""
    try:
        # Convert data to line-delimited JSON
        line_delimited_data = convert_to_line_delimited_json(data)

        # Define S3 object key
        file_key = "raw-data/nba_player_data.json"

        # Initialize S3 client
        s3_client = boto3.client('s3')

        # Upload JSON data to S3
        s3_client.put_object(
            Bucket=bucket_name,
            Key=file_key,
            Body=line_delimited_data
        )
        print(f"Uploaded data to S3: {file_key}")
    except Exception as e:
        print(f"Error uploading data to S3: {e}")
        raise e

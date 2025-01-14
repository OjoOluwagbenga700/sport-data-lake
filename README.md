# NBA sport-data-lake

This repository contains the terraform codes which automates the creation of a data lake for NBA analytics using AWS services. The terraform code automates the creation and integration of Amazon API Gateway, AWS Lambda, Amazon S3, AWS Glue, and Amazon Athena needed to store and query NBA-related data.

The architecture leverages the following components:

•	Amazon S3: Serves as the central data lake for storing raw, processed, and curated NBA data in JSON format.
•	AWS Lambda: Lambda functions Fetches NBA Data from sportdata.io, formats it and upload to Amazon S3
•	Amazon API Gateway: Provides a RESTful API triggers the Lambda function to fetch NBA data from sportdata.io and upload to an S3 bucket.   
•	AWS Glue: Automatically discovers and catalogs the data stored in S3 into a schema using the Glue Database Catalog and Glue crawler for efficient querying.
•	Amazon Athena: Enables serverless querying of the data lake using standard SQL, allowing users to retrieve insights from the curated NBA data and store result in an Amazon S3 bucket


Technologies

•	Iac: Terraform
•	Cloud Provider: AWS
•	Core Services: API Gateway, Lambda, S3, Glue, Athena
•	External API: NBA Game API (SportsData.io)
•	Programming Language: Python 3.x
•	IAM Security: Least privilege policies for Lambda, S3, and Api Gateway.


Step 1: Clone the Terraform Code

Clone Repository: Use the git clone command to clone the Terraform code repository to your local machine. Ensure that you have Git installed and configured on your system.


Ensure that the terraform.tfvars is updated with your API KEY generated from  sportdata.io before running terraform commands

Step 2: Running Terraform Commands

Terraform init: Initialize Terraform in the project directory to download necessary plugins and modules



Terraform Plan: Generate an execution plan to preview the changes that Terraform will make to the infrastructure


Terraform Apply: Apply the Terraform execution plan to create infrastructure resources as needed. Respond with yes to confirm the execution plan.


Testing:

To trigger the lambda function to retrieve, process and upload NBA data to S3 , we will send a GET request through the API Gateway Invoke Url as ouputed in the Terraform Apply phase. Ensure you add the /dev/data indicating the stage and path. See below
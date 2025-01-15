# Serverless NBA Data Lake Application with API Gateway, AWS Lambda, Amazon S3, AWS Glue and Athena Using Terraform

This repository contains the terraform codes which automates the creation of a data lake for NBA analytics using AWS services. The terraform code automates the creation and integration of Amazon API Gateway, AWS Lambda, Amazon S3, AWS Glue, and Amazon Athena needed to efficiently stores, processes, and queries NBA data.

**System Architecture Overview**

The architecture leverages the following components:

• **Amazon S3**: Serves as the central data lake for storing raw, processed, and curated NBA data in JSON format.

• **AWS Lambda**: Lambda functions Fetches NBA Data from sportdata.io, formats it and upload to Amazon S3

• **Amazon API Gateway**: Provides a RESTful API that triggers the Lambda function to fetch NBA data from sportdata.io and upload to an S3 bucket. 

• **AWS Glue**: Automatically discovers and catalogs the data stored in S3 into a schema using the Glue Database Catalog and Glue crawler for efficient querying.

• **Amazon Athena**: Enables serverless querying of the data lake using standard SQL, allowing users to retrieve insights from the curated NBA data and store result in an Amazon S3 bucket,

<img width="352" alt="image" src="https://github.com/user-attachments/assets/8d64ec3f-cdf9-4e59-90c8-b0cd435b742f" />


**Prerequisites**:

• AWS account with required access and permission to configure services such as Lambda, SNS, and EventBridge.

• Experience with programming languages supported by AWS Lambda, such as Python.

• Terraform installed on your local machine

• AWS CLI Installed and configured on your local machine.


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

<img width="451" alt="image" src="https://github.com/user-attachments/assets/71364e77-2064-4be7-b91d-135e15849db8" />

Step 2: Running Terraform Commands

Terraform init: Initialize Terraform in the project directory to download necessary plugins and modules

<img width="340" alt="image" src="https://github.com/user-attachments/assets/462f418b-135b-42d9-81c1-fa39d73bba5b" />

Terraform Plan: Generate an execution plan to preview the changes that Terraform will make to the infrastructure

<img width="340" alt="image" src="https://github.com/user-attachments/assets/128d0ec3-81d2-43f4-9f01-1d893f085ef2" />

**Terraform Apply**: Run `terraform apply --auto-approve` to deploy the infrastructure on AWS

<img width="341" alt="image" src="https://github.com/user-attachments/assets/851d358f-06bc-418a-a618-6bce0a2574b0" />

Testing the Application

To trigger the lambda function to retrieve, process and upload NBA data to S3, we will send a GET request through the API Gateway Invoke URL.  
Copy the API Gateway invoke url to your browser, add /dev/data to indicate the API stage and path and click enter

(https://r3zks22udh.execute-api.us-east-1.amazonaws.com/dev/data)


<img width="451" alt="image" src="https://github.com/user-attachments/assets/5490e2a5-7727-4e6c-9281-c0ad05a25e2b" />


<img width="451" alt="image" src="https://github.com/user-attachments/assets/f0f7c1e4-6a79-4598-98c4-e00841d80089" />

NBA Data Uploaded into  S3

<img width="451" alt="image" src="https://github.com/user-attachments/assets/19409e7e-2817-4782-bce2-7e5836dcbf1f" />


<img width="451" alt="image" src="https://github.com/user-attachments/assets/7bb02ec2-b8f7-42cf-8515-aeae0be8af26" />


<img width="451" alt="image" src="https://github.com/user-attachments/assets/61c738c7-d1fe-45f5-94a5-2157e66a0dbf" />


Preview data table in Athena

<img width="451" alt="image" src="https://github.com/user-attachments/assets/a5c302b8-380c-4958-a13c-2ef056c44b83" />


**Performing Simple SQL query in Athena**

<img width="417" alt="image" src="https://github.com/user-attachments/assets/7812a735-2d80-40a1-95ca-7d492c344d10" />

**Athena Query Result** 

Query results are stored in a defined folder in the s3 bucket and can be downloaded accordingly. See below

<img width="451" alt="image" src="https://github.com/user-attachments/assets/82240bf9-b583-4cde-8837-8fbcc2c30899" />

<img width="451" alt="image" src="https://github.com/user-attachments/assets/8c08e0cd-616a-4c31-b315-4410bda88cc9" />

**Conclusion**: Congratulations!!!, we have successfully built a Serverless NBA Data Lake Application by leveraging AWS services like API Gateway, Lambda, S3, Glue, and Athena. Terraform adds to the elegance by ensuring your infrastructure is provisioned consistently and can be replicated or modified with ease. This architecture not only showcases the potential of serverless computing but also opens up endless possibilities for expanding into other domains, such as real-time analytics, machine learning, or personalized user experiences.

**To Clean up**: Run terraform destroy to delete all infrastructure deployed by the terraform codes.

<img width="451" alt="image" src="https://github.com/user-attachments/assets/7e685df3-558a-4eaf-a946-26592ed84212" />

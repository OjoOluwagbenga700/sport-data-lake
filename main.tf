
# IAM role module - creates necessary IAM roles and policies
module "iam_role" {
  source                     = "./infra/modules/iam_role"
  region                     = var.region
  sport_data_lake_bucket_arn = module.s3.sport_data_lake_bucket_arn
}

# S3 module - creates S3 bucket for storing sport data
module "s3" {
  source      = "./infra/modules/s3"
  bucket_name = var.bucket_name
}

# Glue module - sets up Glue crawler and database for data cataloging
module "glue" {
  source                    = "./infra/modules/glue"
  glue_database_name        = var.glue_database_name
  glue_crawler_name         = var.glue_crawler_name
  glue_crawler_role_id      = module.iam_role.glue_crawler_role_id
  sport_data_lake_bucket_id = module.s3.sport_data_lake_bucket_id
  glue_crawler_role_arn     = module.iam_role.glue_crawler_role_arn

}

# Athena module - configures Athena workgroup for querying data
module "athena" {
  source                    = "./infra/modules/athena"
  sport_data_lake_bucket_id = module.s3.sport_data_lake_bucket_id
  athena_workgroup_name     = var.athena_workgroup_name
}

# Lambda module - creates Lambda function for processing sport data
module "lambda" {
  source          = "./infra/modules/lambda"
  lambda_role_arn = module.iam_role.lambda_role_arn
  function_name   = var.function_name
  nba_api_key     = var.nba_api_key
  bucket_name     = var.bucket_name

}

# API Gateway module - creates API endpoint to trigger Lambda function
module "api_gateway" {
  source                     = "./infra/modules/api_gateway"
  sport_lambda_invoke_arn    = module.lambda.sport_lambda_invoke_arn
  sport_lambda_function_name = module.lambda.sport_lambda_function_name
  region                     = var.region
}

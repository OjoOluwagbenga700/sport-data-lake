data "archive_file" "sport_zip" {
  type        = "zip"
  source_dir = "src"
  output_path = "sport.zip"
}

resource "aws_lambda_function" "sport_lambda_function"  {
  filename      = data.archive_file.sport_zip.output_path
  function_name = var.function_name
  role          = var.lambda_role_arn
  handler       = "sport.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.sport_zip.output_path)
  runtime = "python3.8"
  timeout = 5
  environment {
    variables = {
      "SPORTSDATA_API_KEY" = var.nba_api_key
      "BUCKET_NAME"=var.bucket_name
    }
  }
}

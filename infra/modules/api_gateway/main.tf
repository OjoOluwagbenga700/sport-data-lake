data "aws_caller_identity" "current"  {}

resource "aws_api_gateway_rest_api" "sport_data_api" {
  name        = "sport_data_api"
  description = "API Gateway for sport data lake"
}

resource "aws_api_gateway_resource" "sport_data_resource" {
  rest_api_id = aws_api_gateway_rest_api.sport_data_api.id
  parent_id   = aws_api_gateway_rest_api.sport_data_api.root_resource_id
  path_part   = "data"
}

resource "aws_api_gateway_method" "sport_data_method" {
  rest_api_id   = aws_api_gateway_rest_api.sport_data_api.id
  resource_id   = aws_api_gateway_resource.sport_data_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sport_data_api.id
  resource_id             = aws_api_gateway_resource.sport_data_resource.id
  http_method             = aws_api_gateway_method.sport_data_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.sport_lambda_invoke_arn
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.sport_lambda_function_name
  principal     = "apigateway.amazonaws.com"
   source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.sport_data_api.id}/*/${aws_api_gateway_method.sport_data_method.http_method}${aws_api_gateway_resource.sport_data_resource.path}"
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.sport_data_api.id
  resource_id = aws_api_gateway_resource.sport_data_resource.id
  http_method = aws_api_gateway_method.sport_data_method.http_method
  status_code = "200"

}

resource "aws_api_gateway_integration_response" "sport_data_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.sport_data_api.id
  resource_id = aws_api_gateway_resource.sport_data_resource.id
  http_method = aws_api_gateway_method.sport_data_method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code


  depends_on = [ aws_api_gateway_integration.lambda_integration ]
  
}

resource "aws_api_gateway_deployment" "sport_data_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.sport_data_api.id
  depends_on  = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_method.sport_data_method,
    aws_api_gateway_integration_response.sport_data_integration_response,
    aws_api_gateway_method_response.response_200
  ]
}
  
  resource "aws_api_gateway_stage" "sport_data_stage" {
  deployment_id = aws_api_gateway_deployment.sport_data_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.sport_data_api.id
  stage_name    = "dev"
}

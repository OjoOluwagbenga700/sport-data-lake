
resource "aws_athena_workgroup" "athena_analysis_workgroup" {

    name = var.athena_workgroup_name
    force_destroy = true 

    configuration {
      result_configuration {
        output_location = "s3://${var.sport_data_lake_bucket_id}/athena-results"
      }
    }
  
}
resource "aws_s3_bucket" "sport_data_lake_bucket" {
   bucket = var.bucket_name
   force_destroy = true  
   }

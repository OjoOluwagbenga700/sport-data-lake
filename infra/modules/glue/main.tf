# Database definition for AWS Glue Catalog
resource "aws_glue_catalog_database" "glue_database" {
    name = var.glue_database_name
}

# Table definition for NBA players data
resource "aws_glue_catalog_table" "glue_table" {
  name          = "nba_players"
  database_name = aws_glue_catalog_database.glue_database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    "classification" = "json"
    "typeOfData"      = "file"
  }

  storage_descriptor {
    # S3 location for raw data files
    location      = "s3://${var.sport_data_lake_bucket_id}/raw-data/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    # JSON SerDe configuration
    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    # Define columns with their names and types
    columns {
      name = "PlayerID"
      type = "int"
    }

    columns {
      name = "FirstName"
      type = "string"
    }

    columns {
      name = "LastName"
      type = "string"
    }

    columns {
      name = "Position"
      type = "string"
    }

    columns {
      name = "Points"
      type = "int"
    }

    columns {
      name = "Team"
      type = "string"
    }
  }
}

# Crawler to automatically detect schema changes
resource "aws_glue_crawler" "sport_data_crawler" {

    name = var.glue_crawler_name
    role = var.glue_crawler_role_arn
    database_name = aws_glue_catalog_database.glue_database.name
    s3_target {
        path = "s3://${var.sport_data_lake_bucket_id}/raw-data/"
    }
}

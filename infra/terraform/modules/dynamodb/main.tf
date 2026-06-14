resource "aws_dynamodb_table" "this" {
  name         = "crc-prac-db"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}



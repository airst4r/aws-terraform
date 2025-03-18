terraform {
  backend "s3" {
    bucket         = "ssedutech-tfstate"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "sstech_tf_lockid"
  }
}
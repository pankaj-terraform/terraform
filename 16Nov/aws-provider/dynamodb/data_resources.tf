data "aws_kms_alias" "kms"{
  name = "alias/var.application_id/cmkalias/dynamodb"
  #name = "alias/kms-ue2-np-tempest-ms-devops"  
}
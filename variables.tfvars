ami_id = "ami-0d5d9d301c853a04a" // Ubuntu Server 18.04 LTS (HVM), SSD Volume Type

vpc_id    = "vpc-64b5f70d"
region    = "us-east-2"
subnet_id = "subnet-966331ff"

instance_type = "t2.micro"
key           = "perfJesusKey"
instance_name = "rampup_jenkins"

jenkins_port = "8080"

bucket_name  = "rampup-jpazb"
user_name    = "jpazb"
project_name = "Rampup"

# Create S3 bucket for Python Flask app
resource "aws_s3_bucket" "eb_bucket" {
  bucket = "demmo503" # Name of S3 bucket to create for Flask app deployment needs to be unique 
  acl    = "private"
}
# Define App files to be uploaded to S3
resource "aws_s3_object" "eb_bucket_obj" {
  bucket = aws_s3_bucket.eb_bucket.id
  key    = "ElasticBeanStalk/flask_app.zip" # S3 Bucket path to upload app files
  source = "flask_app.zip"                  # Name of the file to upload to S3
}

# Create Elastic Beanstalk environment for application with defining environment settings
resource "aws_elastic_beanstalk_application_version" "eb_app_ver" {
  bucket      = aws_s3_bucket.eb_bucket.id                        # S3 bucket name
  key         = aws_s3_object.eb_bucket_obj.id                    # S3 key path 
  application = aws_elastic_beanstalk_application.elasticapp.name # Elastic Beanstalk application name
  name        = "enes-eb-tf-app-version-lable"                    # Version label for Elastic Beanstalk application
}



# Create elastic beanstalk application

resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.elasticapp
}

# Create elastic beanstalk Environment

resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = var.beanstalkappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier
  version_label       = aws_elastic_beanstalk_application_version.eb_app_ver.name # Define version label
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role" # Create EC2 role with name aws-elasticbeanstalk-ec2-role
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.public_subnets)
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.Instance_type
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.minsize
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.maxsize
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

}
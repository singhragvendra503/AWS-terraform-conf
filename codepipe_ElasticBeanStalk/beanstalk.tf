
# Create a new Elastic Beanstalk application
resource "aws_elastic_beanstalk_application" "sample_app" {
  name        = "${var.env}-app"         # Update with your desired application name
  description = "Sample application" # Update with your desired application description
}

# Create a new Elastic Beanstalk environment
resource "aws_elastic_beanstalk_environment" "sample_env" {
  name                = "${var.env}-env" # Update with your desired environment name
  application         = aws_elastic_beanstalk_application.sample_app.name
  tier                = var.application_tier
  solution_stack_name = var.solution_stack_name # Update with your desired solution stack

  # Configure environment properties
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type # Update with your desired instance type
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = var.environment_type # Update with "LoadBalanced" if you want a load-balanced environment
  }

  # Configure environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "APP_ENV"
    value     = "production" # Update with your desired environment variable
  }

  # Create a new S3 bucket for storing application versions
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentBucketName"
    value     = aws_s3_bucket.mybucket.bucket # Update with your desired S3 bucket name
  }

  # Create a new IAM instance profile for EC2 instances
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role" # Update with your desired IAM instance profile
  }
}

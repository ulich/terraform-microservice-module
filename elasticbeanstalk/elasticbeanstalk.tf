# Please refer to https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html

resource "aws_elastic_beanstalk_application" "application" {
  count = "${local.workspace["create_application"]}"
  name = "${var.app_name}"
}

resource "aws_elastic_beanstalk_environment" "environment" {
  depends_on          = ["aws_elastic_beanstalk_application.application"]
  name                = "${var.app_name}-${local.workspace["environment_name"]}"
  application         = "${var.app_name}"
  solution_stack_name = "64bit Amazon Linux 2017.09 v2.6.5 running Java 8"
  tier                = "WebServer"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "SERVER_PORT"
    value = "5000"
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name = "LowerThreshold"
    value = "1000"
  }
}

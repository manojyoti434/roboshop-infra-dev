module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = true
  name    = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb #
  vpc_id  = local.vpc_id
  subnets = local.private_subnet_ids
  create_security_group = false
  security_groups = [local.backend_alb_sg_id]

  version = "9.16.0" 



  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-backend_alb"
        
     }
  )
}



resource "aws_lb_listener" "backend_alb" {

  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, i am from backend alb</h1>"
      status_code  = "200"
    }
  }
}

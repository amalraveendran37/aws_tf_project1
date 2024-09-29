# load balancer
resource "aws_lb" "project_load_balancer" {
    internal = false 
    name = "project-load-balancer"
    security_groups = [aws_security_group.project_security_group.id]
    subnets = [ aws_subnet.public_subnet.id,aws_subnet.public_subnet_2.id ]
    load_balancer_type = "application"

  
}
resource "aws_lb_listener" "project_listener" {
    load_balancer_arn = aws_lb.project_load_balancer.arn 
    port=80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.project_target_group.arn

    }

  
}
# target group
resource "aws_lb_target_group" "project_target_group" {
    name="project-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.myvpc.id
  
}
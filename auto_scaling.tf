# auto scaling group
resource "aws_autoscaling_group" "project_auto_scaling" {
    max_size = 2 
    min_size = 1
    desired_capacity = 1 
    launch_template {
      id= aws_launch_template.project_launch_template.id
      version = "$Latest"


    }
    vpc_zone_identifier = [ aws_subnet.public_subnet.id,aws_subnet.public_subnet_2.id ]
    health_check_grace_period = 60
    target_group_arns = [ aws_lb_target_group.project_target_group.arn ]

  
}

resource "aws_autoscaling_attachment" "prj_asg_att" {
  autoscaling_group_name = aws_autoscaling_group.project_auto_scaling.id
 lb_target_group_arn = aws_lb_target_group.project_target_group.arn
  
}
# ec2 instance creation

resource "aws_launch_template" "project_launch_template" {
    name= "project_launch_template"
    block_device_mappings {
      
      device_name = "/dev/xvda"
      ebs {
        volume_size = 15
        volume_type = "gp2"
      }
    }
    block_device_mappings {
      
      device_name = "/dev/sdf"
      ebs {
        volume_size = 15
        volume_type = "gp2"
      }

    }
    
    image_id = "ami-02c21308fed24a8ab"
    instance_type = "t2.micro"
    key_name = "next"
    network_interfaces {
      associate_public_ip_address = false
      security_groups = [aws_security_group.project_security_group.id]
    }

    # user data
    user_data = filebase64("./user_data.sh")
    
  
}


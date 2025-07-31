resource "aws_launch_template" "launch_template" {
  name          = "launch-template"
  image_id      = var.LT_image_id
  instance_type = var.LT_instance_type
  user_data = base64encode(<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
)

  network_interfaces {
    associate_public_ip_address = var.LT_associate_public_ip_address
    delete_on_termination       = true
    security_groups             = var.LT_vpc_security_group_ids # <-- Yahan specify karo
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "launch-template"
    }
  }
}

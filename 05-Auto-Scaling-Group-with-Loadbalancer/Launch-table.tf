resource "aws_launch_template" "my-launch-template" {  # Defines a launch template resource for EC2 instances, used by Auto Scaling Group to launch instances with predefined settings.
  name          = "my-launch-template"                 # The name of the launch template. It's used to reference this template in other AWS services.
  image_id      = "ami-0d0ad8bb301edb745"              # The AMI ID of the EC2 instance to launch; it defines the operating system and pre-installed software.

  instance_type = "t2.nano"                            # Instance type defines the hardware (CPU, memory) — t2.nano is a small, cost-effective instance.

  network_interfaces {                                 # Configures the network interface of the EC2 instance.
    associate_public_ip_address = true                 # Assigns a public IP to the instance, allowing internet access (only works if subnet is public).
    security_groups             = [aws_security_group.my-SG.id]  # Attaches the specified security group for controlling inbound/outbound traffic rules.
  }

  tag_specifications {                                 # Specifies tags for different resources created with this template.
    resource_type = "instance"                         # Indicates that these tags are for the EC2 instance (not volumes or interfaces).
    tags = {
      Name = "my-instance"                             # Tags the instance with a human-readable name "my-instance" for easier identification.
    }
  }

  user_data = base64encode((file("./user_data.sh")))   # Provides startup script (user data) that runs when the instance boots, such as installing packages or configuring services. It is base64 encoded as required by AWS.

  block_device_mappings {                              # Defines how storage devices (like EBS volumes) are attached to the instance.
    device_name = "/dev/sdf"                           # The device name for the EBS volume that will be attached to the instance.
    ebs {
      volume_size           = 1                        # Size of the EBS volume in GiB.
      volume_type           = "gp3"                    # Type of volume — gp3 is a general-purpose SSD with better baseline performance than gp2.
      delete_on_termination = true                     # Automatically deletes the volume when the instance is terminated, to avoid unused volume charges.
    }
  }
}

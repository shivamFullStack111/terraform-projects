resource "aws_key_pair" "new-key-pair" {
  key_name   = "new-key-pair"
  public_key = file("./new-key-pair.pub")
  tags = {
    Name = "new-key-pair"
  }
}

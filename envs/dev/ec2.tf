# ---------------------------
# EC2 Key pair
# ---------------------------

# ---------------------------
# EC2
# ---------------------------

# Amazon Linux 2 の最新版AMIを取得
data "aws_ssm_parameter" "amzn2_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#EC2作成
resource "aws_instance" "dev_public_instance" {
  ami                         = ""
  instance_type               = public_ec2_instance_t2_micro
  availability_zone           = az_a
  vpc_security_group_ids      = vpc_security_group_ids.id
  subnet_id                   = public_dev_vpc_1a_sn
  associate_public_ip_address = "true"
  key_name                    = ""
  tags = {

  }
}
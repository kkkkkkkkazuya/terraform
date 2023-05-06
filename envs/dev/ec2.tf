# ---------------------------
# EC2 Key pair
# ---------------------------

# 秘密鍵のアルゴリズム設定
resource "tls_private_key" "dev_private_key" {
    algorithm = "RSA"
    rsa_bits  = 2048
}

# クライアントPCにKey pair（秘密鍵と公開鍵）を作成
# - [terraform apply] 実行後はクライアントPCの公開鍵は自動削除される
locals {
  public_key_file  = "C:\\terraform_handson\\${var.key_name}.id_rsa.pub"
  private_key_file = "C:\\terraform_handson\\${var.key_name}.id_rsa"
}

resource "local_file" "dev_private_key_pem" {
  filename = "${local.private_key_file}"
  content  = "${tls_private_key.handson_private_key.private_key_pem}"
}

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
    Name = "dev_public_instance"
  }
}
resource "aws_security_group" "test_sg" {
  name        = "test_sg_${var.service_name}"
  description = "Allow HTTP inbound traffic"
  vpc_id = "${var.vpc}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami = "${data.aws_ami.ubuntu_1604.id}"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "${var.html_content}" > index.html
  nohup busybox httpd -f -p 80 &
  EOF

  tags {
    Name = "${var.service_name}"
  }
}

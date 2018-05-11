resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${aws_vpc.test_vpc.id}"

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
  subnet_id = "${aws_subnet.test_subnet.id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "${var.html_content}" > index.html
  nohup busybox httpd -f -p 80 &
  EOF
}

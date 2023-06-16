FROM python:3.9

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Set a root password for SSH (replace 'your_password' with your desired password)
RUN echo 'root:root' | chpasswd

# Permit root login via SSH and allow passing all environment variables
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY env.py .

# Start SSH server and run Python code
CMD ["/bin/sh", "-c", " python /app/env.py & /usr/sbin/sshd -D" ]

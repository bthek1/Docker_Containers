FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install necessary packages
RUN apt update && apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt install -y \
       xfce4 \
       xfce4-goodies \
       tightvncserver \
       novnc \
       websockify \
       git \
       wget \
       sudo \
       net-tools \
       curl \
       supervisor \
       dbus-x11 \
       x11-utils

# Create a user
ENV USER ubuntu
ENV PASSWORD ubuntu

RUN useradd -m $USER && echo "$USER:$PASSWORD" | chpasswd && adduser $USER sudo

# Expose ports for VNC and noVNC
EXPOSE 5901 6080

# Copy supervisord.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Set working directory
WORKDIR /home/$USER

# Start Supervisor
CMD ["/usr/bin/supervisord"]

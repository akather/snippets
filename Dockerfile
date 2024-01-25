# Use the official Jenkins JNLP agent image as the base image
FROM jenkins/inbound-agent:latest

# Switch to the root user to install additional tools
USER root

# Install Maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && \
    apt-get install -y kubectl && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the Jenkins user
USER jenkins

# Set the working directory for the Jenkins user
WORKDIR /home/jenkins/agent

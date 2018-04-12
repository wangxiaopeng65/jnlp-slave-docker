FROM jenkins/jnlp-slave:latest

USER root

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository \
         "deb [arch=amd64] https://download.docker.com/linux/debian \
         $(lsb_release -cs) \
         stable" \
    && apt-get update \
    && apt-get -y install docker-ce

# Install Kubectl
RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.8.3/bin/linux/amd64/kubectl > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Link .dockerconfig to Jenkins user
RUN ln -sf /root/.dockercfg /home/jenkins/

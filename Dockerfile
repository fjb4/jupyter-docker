FROM jupyter/base-notebook:latest

USER root

RUN apt-get -y update && \
    apt-get install -y gnupg2 && \
    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get -y update && \
    apt-get install -y zsh && \
    apt-get install -y cf-cli && \
    apt-get install -y kubectl

RUN python3 -mpip install notebook zsh_jupyter_kernel && \
    python3 -mzsh_jupyter_kernel.install --sys-prefix

ENTRYPOINT ["jupyter", "lab", "--allow-root"]

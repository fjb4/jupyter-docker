FROM jupyter/base-notebook:latest

USER root

RUN apt-get -qq update && \
    apt-get install -qq ca-certificates && \
    apt-get install -qq apt-transport-https && \
    apt-get install -qq gnupg2 && \
    apt-get install -qq software-properties-common && \
    apt-get install -qq bash && \
    apt-get install -qq git && \
    apt-get install -qq curl && \
    apt-get install -qq wget && \
    apt-get install -qq jq

# cf
RUN apt-key adv --fetch-keys https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key && \
    add-apt-repository -y "deb https://packages.cloudfoundry.org/debian stable main" && \
    apt-get -qq update && \
    apt-get install -qq cf-cli

# kubectl
RUN apt-key adv --fetch-keys https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    add-apt-repository -y "deb https://apt.kubernetes.io/ kubernetes-xenial main" && \
    apt-get -qq update && \
    apt-get install -qq kubectl

# helm
RUN apt-key adv --fetch-keys https://helm.baltorepo.com/organization/signing.asc && \
    add-apt-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main" && \
    apt-get -qq update && \
    apt-get install -qq helm

# yq
RUN add-apt-repository -y ppa:rmescandon/yq && \
    apt-get -qq update && \
    apt-get install -qq yq

# kubectx & kubens
RUN curl -sL -o /usr/local/bin/kubectx https://github.com/ahmetb/kubectx/releases/latest/download/kubectx && \
    chmod +x /usr/local/bin/kubectx && \
    curl -sL -o /usr/local/bin/kubens https://github.com/ahmetb/kubectx/releases/latest/download/kubens && \
    chmod +x /usr/local/bin/kubens

# hr
RUN curl -sL -o /usr/local/bin/hr https://raw.githubusercontent.com/LuRsT/hr/master/hr && \
    chmod +x /usr/local/bin/hr

# tmc (TODO: is there a URL that will always install the latest version?)
RUN curl -sL -o /usr/local/bin/tmc https://vmware.bintray.com/tmc/0.1.0-1778aa17/linux/x64/tmc && \
    chmod +x /usr/local/bin/tmc

# jupyter & bash_kernel
RUN python3 -m pip install jupyter_nbextensions_configurator && \
    python3 -m pip install bash_kernel && \
    python3 -m bash_kernel.install --sys-prefix

ENTRYPOINT ["jupyter", "lab", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
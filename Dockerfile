FROM jupyter/base-notebook:latest

USER root

RUN apt-get -y -qq update && \
    apt-get install -y -qq apt-transport-https gnupg2 software-properties-common curl && \
    # add cf repo
    apt-key adv --fetch-keys https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key && \
    add-apt-repository -y "deb https://packages.cloudfoundry.org/debian stable main" && \
    # add kubectl repo
    apt-key adv --fetch-keys https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    add-apt-repository -y "deb https://apt.kubernetes.io/ kubernetes-xenial main" && \
    # add helm repo
    apt-key adv --fetch-keys https://helm.baltorepo.com/organization/signing.asc && \
    add-apt-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main" && \
    # add yq repo
    add-apt-repository -y ppa:rmescandon/yq && \
    apt-get -y -qq update && \
    apt-get install -y -qq ca-certificates zsh cf-cli kubectl helm jq yq && \
    # install kubectx
    curl https://github.com/ahmetb/kubectx/releases/latest/download/kubectx > /usr/local/bin/kubectx && \
    chmod +x /usr/local/bin/kubectx && \
    # install kubens
    curl https://github.com/ahmetb/kubectx/releases/latest/download/kubens > /usr/local/bin/kubens && \
    chmod +x /usr/local/bin/kubens && \
    # install hr
    curl https://raw.githubusercontent.com/LuRsT/hr/master/hr > /usr/local/bin/hr && \
    chmod +x /usr/local/bin/hr && \
    # install tmc
    curl https://vmware.bintray.com/tmc/0.1.0-1778aa17/linux/x64/tmc > /usr/local/bin/tmc && \
    chmod +x /usr/local/bin/tmc

RUN python3 -m pip install notebook zsh_jupyter_kernel
RUN python3 -m pip install jupyter_nbextensions_configurator
RUN python3 -m zsh_jupyter_kernel.install --sys-prefix

ENTRYPOINT ["jupyter", "lab", "--allow-root"]
FROM jupyter/base-notebook:latest

USER root

RUN apt-get -y -qq update && \
    apt-get install -y -qq apt-transport-https gnupg2 software-properties-common zsh git curl

RUN apt-key adv --fetch-keys https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key && \
    add-apt-repository -y "deb https://packages.cloudfoundry.org/debian stable main" && \
    apt-key adv --fetch-keys https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    add-apt-repository -y "deb https://apt.kubernetes.io/ kubernetes-xenial main" && \
    apt-key adv --fetch-keys https://helm.baltorepo.com/organization/signing.asc && \
    add-apt-repository -y "deb https://baltocdn.com/helm/stable/debian/ all main" && \
    add-apt-repository -y ppa:rmescandon/yq && \
    apt-get -y -qq update

RUN sh -c "$(curl -sL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN apt-get install -y -qq ca-certificates cf-cli kubectl helm jq yq

RUN curl -sL -o /usr/local/bin/kubectx https://github.com/ahmetb/kubectx/releases/latest/download/kubectx && \
    chmod +x /usr/local/bin/kubectx && \
    curl -sL -o /usr/local/bin/kubens https://github.com/ahmetb/kubectx/releases/latest/download/kubens && \
    chmod +x /usr/local/bin/kubens

RUN curl -sL -o /usr/local/bin/hr https://raw.githubusercontent.com/LuRsT/hr/master/hr && \
    chmod +x /usr/local/bin/hr

RUN curl -sL -o /usr/local/bin/tmc https://vmware.bintray.com/tmc/0.1.0-1778aa17/linux/x64/tmc && \
    chmod +x /usr/local/bin/tmc

RUN python3 -m pip install jupyter_nbextensions_configurator && \
    python3 -m pip install lab zsh_jupyter_kernel && \
    python3 -m zsh_jupyter_kernel.install --sys-prefix

ENTRYPOINT ["jupyter", "lab", "--allow-root"]
# Tanzu Jupyter

Docker image that runs [Project Jupyter](https://jupyter.org/) and is purpose-built for [Tanzu](https://tanzu.vmware.com/tanzu) demos.

A prebuilt image is [available on Docker Hub](https://hub.docker.com/repository/docker/fjb4/tanzu-jupyter). This image extends the [jupyter/base-notebook](https://hub.docker.com/r/jupyter/base-notebook/) image. Documentation is available at https://jupyter-docker-stacks.readthedocs.io/en/latest/.

Installed software includes:
- [Jupyter](https://jupyter.org/) with [zsh kernel](https://github.com/dan-oak/zsh-jupyter-kernel)
- zsh
- [cf](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)
- [jq](https://stedolan.github.io/jq/)
- [yq](https://mikefarah.gitbook.io/yq/)
- [kubectx & kubens](https://github.com/ahmetb/kubectx)
- [hr](https://github.com/LuRsT/hr)
- [tmc](https://tanzu.vmware.com/mission-control)

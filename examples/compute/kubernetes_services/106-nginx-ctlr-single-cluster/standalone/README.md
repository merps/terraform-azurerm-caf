# Azure F5 NGINX+ Ingress Controller

[![license](https://img.shields.io/github/license/:merps/:f5-nginx-codex.svg)](LICENSE)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

This is sample deployment to demonstrate the use of Microsoft Azure Cloud Adoption Framework (CAF) for the deployment of; 

* CAF LandingZone pattern
* Kubernetes upon Azure AKS,
* NGINX+ Controller (ctlr)
      

## Table of Contents

- [Background](#background)
- [Getting Started](#getting)
- [Install](#install)
- [Contributing](#contributing)
- [Credits](#credits)
- [License](#license)


## Background

This is a demonstration of the interoperability of NGINX+ Kubernetes Ingress Controller (KIC) deployment with AKS leveraging the [Microsoft Cloud Adoption Framework for Azure](https://docs.microsoft.com/en-gb/azure/cloud-adoption-framework/)


## Prerequisites

To support this deployment pattern the following components are required:

* [NGINX+ & Controller Licenses](https://docs.nginx.com/nginx-controller/v3/try-nginx-controller/)
* [Azure Cloud Adoption Framework](https://github.com/Azure/caf-terraform-landingzones-starter)
* [Docker](https://www.docker.com/)
* [VSCode](https://code.visualstudio.com/)

***Optional***

If there is the desire to install the full demo stack the additional tools/accounts are suggested:

* [Terraform CLI](https://www.terraform.io/docs/cli-index.html)
* [git](https://git-scm.com/)
* [Azure CLI](https://docs.microsoft.com/en-gb/cli/azure/) access.
* [Launchpad](https://github.com/aztfmod/level0)
* [Rover](https://github.com/aztfmod/rover)



## Getting Started

It's recommend to use *Rover* for the deployment of this example, this contains all the necessary tools required to deploy Launchpad's, Controller and other examples;

>  *Check the [getting started guide](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md) for detailed instructions.*


## Run this Example

This module can be tested outside the landing zone framework as follows:

```
cd /tf/caf/examples/compute/kubernetes_services/106-nginx-ctlr-single-cluster/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../aks.tfvars \
  -var-file ../networking.tfvars \
  -var-file ../diagnostics.tfvars \
  -var-file ../nginx-ctlr.tfvars
```


## Contributing

See [the contributing file](CONTRIBUTING.md)!

PRs accepted.

## Credits

* [Laurent Petroque]
* [Fouad Chmainy](https://github.com/fchmainy)
* [Arnaud Lheureux](https://github.com/arnaudlh)


## License

[MIT © Michael Kennedy.](../LICENSE)
### Requirements

In order to launch the project locally you need the following:

* docker engine
* `docker-compose`
* `minikube`
* `make`
* `kubectl`

### Local run

To launch the app locally using your local docker engine, make sure port `8000` is not allocated on your host machine and launch

```bash
make run
```

`run` target in Makefile launches `dev` service from `docker-compose.yaml` which launches `uvicorn` daemon with `--reload` option allowing you to change the source and see the changes locally.

Once `make run` succeeds, you should be able to navigate to `http://127.0.0.1/` and see something like 

```bash
{"timestamp":1680353669.5468233,"hostname":"42bc3f9174d9"}
```

To stop all the containers:

```bash
make stop
```

To launch the whole test suite locally:

```bash
make test
```

Do not launch `test` service via docker-compose without `MY_GID` and `MY_UID` env vars set to your GID and UID respectively. This will make the linter make changes on behalf of root user inside the container and will change the permissions of your source files. 

### Local run in K8S

We selected [minikube](https://minikube.sigs.k8s.io/docs/start/) as the local k8s provider. Used docker driver for testing purposes. We will not use Helm or any other release/template manager as it was not requested in the task. We will store the whole manifest in a single `k8s.yaml` file in the project root.

Enable `registry` addon of `minikube` to be able to use the local container registry (we could also use Github CR, Google CR, JFrog artifactory local install, but this is out of scope of this task). I created a command that enables the registry addon in minikube as well as forwards port `80` from registry service to port `5000` on your host machine (make sure it's not allocated): 
```bash
make registry
```

Build and push the current prod version of the app image to the local minikube registry:

```bash
make push-registry
```
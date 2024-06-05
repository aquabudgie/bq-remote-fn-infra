# bq-remote-fn-starter
Starter repository for the deployment of a BigQuery remote function.

## Requirements
- 

## Authentication

This project has been authenticated using Google Application Default Credentials. The easiest way to generate the credentials file is to run `gcloud auth application-default login`, if you already have gcloud installed. If you don't already have the gcloud cli, you can install it from [here](https://cloud.google.com/sdk/docs/install).

## Usage

### Initialise OpenTofu
run `bash bin/init.sh`


### Run a Tofu Plan to see what will be created
run `bash bin/plan.sh`

### Run a Tofu Apply to deploy infrastructure
run `bash bin/deploy.sh`


## License
This project is licensed under the unlicense License. See [LICENSE](./LICENSE) for more information.

The exception is `function_source/data_file/51Degrees-LiteV4.1.hash` which is licensed under EUPL v1.2, please see `function_source/data_file/LICENSE`.
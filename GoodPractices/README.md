## Execution
In order to execute the Terraform script you have to move into the Environment directory and then type the next commands in the Terminal.

The command `init` load the source of the modules from the directory or the repositories.
> NOTE: This command also could be used to check the syntaxis.

```bash
terraform init
```
Throuth the `plan` command you can check what changes will be applied before to apply the changes.
```bash
terraform plan
```
Finally you have to type the command `apply` to execute the changes on the AWS environment, before to apply the changes it will request for approval and show you a similar output that the `plan` command.
```bash
terraform apply
```

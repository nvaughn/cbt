# Terraform Cloud Overview and Demo

This is a simple Terraform configuration to demonstrate the features of Terraform and Terraform Cloud

## What will this do?

This configuration will provision an EC2 instance in your AWS account. 

## What are the prerequisites?

AWS account

Terraform Cloud Account & Organization

Coffee

Quickstart
----------

The first thing you need to do is clone the repository. 
```bash
    $ git clone git@github.com:nvaughn/cbt.git <ENTER>
```

The main branch contains standard Terraform IaC for use with Terraform Cloud.

Alternatively, if you don't have Git installed on your system you can simply click on the green button 'Clone or Download' available in the top of this Github repository. This will download a fresh copy of the code straight from the main branch.

Next, navigate to the cloned folder and set up the access_key and secret_key credentials needed for your AWS provider in the **cloud.auto.tfvars** file. Or set the environment variables TF_VAR_access_key and TF_VAR_secret_key. Modify main.tf cloud stanza to CHANGE **organization** and **workspace** name for Terraform Cloud.

All other parameters are optional and have default values.  However, feel free to change the Class Name, Region, instance type etc.. as needed with the **cloud.auto.tfvars** file.

Finally, you will need to run Terraform (which you can [download from here](https://www.terraform.io/downloads.html) if you do not have it already). While under the cloned folder, run:

```bash
    $ terraform login <ENTER>

```

You will need to Copy&Paste the session key generated in the browser onto the command line.

Next run:

```bash
    $ terraform init <ENTER>
    $ terraform plan <ENTER>
    $ terraform apply <ENTER>
```
Once complete the output will display the classroom instances public IP address.  EC2 Console can be used to access more details.

Alternative:

Utilize Terraform Cloud WebUI to ingest the github repo directly into a workspace.


License
-------

The project is licensed under the MITs license.

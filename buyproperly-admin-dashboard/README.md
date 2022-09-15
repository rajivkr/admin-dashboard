# Get Started

## Setting up CodePipeline & Github Connection

- Go to the folder named **codestar**. This code will create a connection to GitHub. First we need to setup this because then only our CodePipeline  will fetch the code of the reactJs app from the repository.
- Run terraform init command to initialize the dependencies that terraform needed.
- Then run **terraform plan** command to see what are the resources going to created.
- You can see this code will going to create connection to GitHub. So, now run the **terraform apply** command to deploy the code to AWS.
- Once the code is applied successfully, go to your AWS account and search for **CodePipeline** and click it.
- It navigates you to the CodePipeline page. Here click  the **settings** and then connections.
You can see there is a connection that will be created, but is in a pending status. Because we need to **authorize** the AWS account to access the **GitHub** account.
- So, click the name `buyproperly-admin-pipeline` that will be under the column connection name.
- Here you will see the **pending connection** state. Click the **Update pending connection** button it opens a page GitHub Connection settings, select your GitHub account to access.
- If you can’t see your account, click **Install** a new app button to connect your GitHub account.
- Once you finish the connection you can see the status of the connection is Active.

> Note the Arn that is present in the right side of the page as mentioned in the above image. This is the one we are going to use in our next code.


## Create CodePipeline with S3 bucket for Static Web Hosting
> Note: In this project, we have used different Var Files for Staging and Prodcution


- Go to your VS Code editor and open the terminal.
- Run the command “cd ../ to navigate to the previous folder. 
  - Run the command “cd staging” to navigate to the staging folder for pushing staging infrastructure. 
  - Run the command “cd production” to navigate to the production folder for pushing production infrastructure. 
- Then run **terraform init** command to initialize the dependency packages for terraform 
- Open **variables.tf** file. Here we are specified some of the variables that we use in the code.
- For **pipeline_bucket_name**, provide a unique name for S3 bucket that stores the artifacts of the CodePipeline .
- For **app_bucket_name**, provide a unique name for S3 bucket that hosts a static website of your ReactJs app.
- For **projectname**, provide a name that identifies these resources from all of the other services in your AWS Account.
- So, **repo_id** and **repo_branch_name**, provide the id of your repository that you have your Reactjs code and enter a branch name.
- And for the **connection_arn**, provide the Arn that you note from the previous step.
- Once all the variables setup is finished, run **terraform apply** command. For this purpose I am straightly running the apply command.
- - But the best practice is first run **plan** command to know what is going to happen, then only run apply.
- So, when you run the apply command it asks some values for access_key and secret_key. You can provide it here.
- Pls verify whether this code is delete anything or change anything. For here it is not going to delete or modify anything. It is just ‘10 to add and 0 to change and 0 to destroy‘. Enter yes to proceed.
- If the application is completed, Go to your AWS account and go to CodePipeline page and select the pipeline.
- Wait until it completes all the processes from **Source** to **Deploy**.
- All the three steps should be completed successfully.
- Once successful, navigate to the terminal and you can see **static_website_endpoint**. This is the endpoint of the S3 bucket’s website hosting.
- Copy the value and paste it on the browser. If the application is perfectly deployed, It looks like the below image.
- For additionally you can point this endpoint to your Domain using Route53.
- In the Route53 section create a hosted zone for your domain name.
- Then create a “A” type record, add a subdomain and route the traffic to your AWS S3 bucket which is hosted by your ReactJs app.
- But you must have to note one thing. If you need to route traffic from a S3 bucket static website hosting to a domain, you must provide the S3 bucket name same as the custom domain name.

## Instructions for Staging Deployment
- **CD** into **staging** directory
- Change the Terraform Back-end S3 key in `provider.tf` file to: `staging/state/terraform_state.tfstate`
- Use a `terraform.tfvars` file with staging details like this one:
  
```yaml
pipeline_bucket_name = "buyproperly-admin-dashboard-staging-pipeline"
app_bucket_name      = "buyproperly-admin-dashboard-staging-app"
projectname          = "buyproperly-admin-dashboard-staging"
repo_id              = "BuyProperly/buyproperly-admin-dashboard"
repo_branch_name     = "dev"
connection_arn       = "YOUR_CODESTAR_CONNECTION_ARN"
```

- Add any extra variables if needed
- Run the commands:
```bash
terraform plan
terraform apply
```

## Instructions for Production Deployment
- **CD** into **production** directory
- Change the Terraform Back-end S3 key in `provider.tf` file to: `production/state/terraform_state.tfstate`
- Use a `terraform.tfvars` file with produciton details like this one:
  
```yaml
pipeline_bucket_name = "buyproperly-admin-dashboard-pipeline"
app_bucket_name      = "buyproperly-admin-dashboard-app"
projectname          = "buyproperly-admin-dashboard"
repo_id              = "BuyProperly/buyproperly-admin-dashboard"
repo_branch_name     = "main"
connection_arn       = "YOUR_CODESTAR_CONNECTION_ARN"
```

- Add any extra variables if needed
- Run the commands:
```bash
terraform plan
terraform apply
```

## References
- https://www.easydeploy.io/blog/reactjs-application-terraform-automation-codepipeline/
- https://github.com/easydeploy-cloud/s3-bucket-static-webhosting-with-codepipeline-terraform/blob/main/app_s3.tf
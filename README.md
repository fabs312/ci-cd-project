# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and c## New Featuresompleteness with required fields, date restrictions, and card number validation.

- **Delivery Date column:** The delivery_date column allows for precise tracking of when orders are due to be delivered, an essential aspect of customer service and logistics management.
This was removed from prod with changes reverted back to the original database configuration. The code changes can be seen [here](https://github.com/fabs312/ci-cd-project/commit/2f4fc789828b581e6c5486e0f5e57266c65f9e9c) for future reference.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Using docker to run flask application

You can containerise your Flask application using the provided Dockerfile. This Dockerfile sets up the necessary environment to run your Flask app inside a Docker container.

Dockerfile:
```
FROM python:3.8-slim
WORKDIR /app
COPY . /app
RUN pip install --upgrade pip && \
    pip install --trusted-host pypi.python.org -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
```
- Building and Running the Docker Image Locally

Build the Docker Image In the directory containing your Dockerfile and application code, run:
```docker build -t python_app . ```

This command builds the Docker image and tags it as python_app.

- Run the Docker Container

Once the image is built, start the container using:

```docker run -p 5000:5000 python_app```

This command maps port 5000 of the container to port 5000 on your host machine.

- Access the Flask Application

The Flask application will be accessible at http://localhost:5000 in your web browser.

## Usage Instructions for Pulling Image from Docker Hub
Ensure Docker is Installed and Running.
Before pulling and running the Docker image, make sure Docker is installed on your machine and the Docker daemon is running.

- Pull the Image from Docker Hub using:
```docker pull fabs312/python_app:1.0```

This command downloads the python_app image with the tag 1.0 from the Docker Hub account fabs312.

- Run the Container after pulling the image with:
```docker run -p 5000:5000 fabs312/python_app:1.0```

This maps port 5000 of the container to port 5000 on your host machine.

- Access the Flask Application:

Just like when running locally, the application will be accessible at http://localhost:5000.

# Terraform Networking Module for AKS
This Terraform module is designed to create essential networking resources in Azure for deploying an AKS cluster. The module sets up a Virtual Network (VNet), subnets for control plane and worker nodes, and a Network Security Group (NSG) with specific rules.

## Resources Created

### Azure Resource Group
- **Name**: Specified by the `resource_group_name` variable.
- **Purpose**: Acts as a container that holds related resources for an Azure solution.

### Virtual Network (VNet)
- **Name**: `aks-vnet`
- **Purpose**: Provides a private network in Azure and is used to allocate private IP addresses to resources within the resource group.

### Subnets
- **Control Plane Subnet**
  - **Name**: `control-plane-subnet`
  - **Purpose**: Used specifically for AKS control plane components.
- **Worker Node Subnet**
  - **Name**: `worker-node-subnet`
  - **Purpose**: Used for AKS worker nodes where Kubernetes pods will be scheduled.

### Network Security Group (NSG)
- **Name**: `aks-nsg`
- **Purpose**: Contains a list of security rules that allow or deny network traffic to resources connected to AKS VNet subnets.

#### NSG Rules
- **kube-apiserver-rule**: Allows traffic to the kube-apiserver.
- **ssh-rule**: Allows inbound SSH traffic. This is particularly useful for troubleshooting purposes.

## Input Variables

- `resource_group_name`: Name of the Azure Resource Group.
- `location`: Azure region where resources will be deployed.
- `vnet_address_space`: Address space for the VNet in CIDR notation.
- `control_plane_subnet_address`: CIDR block for the control plane subnet.
- `worker_node_subnet_address`: CIDR block for the worker node subnet.

## Output Variables

- `vnet_id`: The ID of the created VNet.
- `control_plane_subnet_id`: The ID of the control plane subnet.
- `worker_node_subnet_id`: The ID of the worker node subnet.
- `networking_resource_group_name`: Name of the Azure Resource Group.
- `aks_nsg_id`: The ID of the created NSG.

## Usage

To use this module in your Terraform configuration, include it as a module in your main Terraform file and specify the source and input variables.

Example:
```hcl
module "networking" {
  source                        = "./modules/networking"
  resource_group_name           = "my-aks-resources"
  location                      = "East US"
  vnet_address_space            = ["10.0.0.0/16"]
  control_plane_subnet_address  = "10.0.1.0/24"
  worker_node_subnet_address    = "10.0.2.0/24"
}
```
## Terraform Configuration File

The Terraform configuration file (`main.tf`) specifies the required providers and sets up the Azure provider. This file is essential for initializing Terraform with the correct provider and settings.

### Required Providers

```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}
```

Run the following command:

```terraform init```

This command will download the required providers and initialize your Terraform workspace.

## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))
- Fabulous Fabs

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.

# Automated Deployment of Node.js App using Terraform, Ansible & Docker

![Terraform](https://img.shields.io/badge/Terraform-623CE4?logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?logo=ansible&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazon-aws&logoColor=white)

---

## Description
This project demonstrates **end-to-end DevOps automation** by deploying a containerized Node.js application on **AWS EC2** using **Terraform**, **Ansible**, and **Docker**.  

- Provision AWS EC2 infrastructure automatically with **Terraform**  
- Configure servers and install Docker using **Ansible**  
- Containerize and deploy Node.js app using **Docker**  
- Fully automated **Infrastructure as Code** workflow  

---

## Technologies Used
- **AWS EC2** – Cloud Infrastructure  
- **Terraform** – Provision infrastructure  
- **Ansible** – Server setup & deployment  
- **Docker** – Containerize Node.js application  
- **Node.js** – Backend application  
- **Git & GitHub** – Version control  

---

## Folder Structure

```text
node_app/
├── ansible/
│   ├── deploy_node.yml          # Ansible playbook
│   └── terraform_inventory.ini  # Inventory file for EC2
├── app/
│   ├── Dockerfile
│   ├── app.js
│   └── package.json
├── keys/
│   └── Docker-key.pem           # SSH private key (ignored in Git)
├── terraform/
│   ├── main.tf
│   ├── terraform.tfstate
│   └── terraform.tfstate.backup
├── screenshots/                 # Folder for screenshots
├── .gitignore
└── README.md


Setup & Execution Steps
1️⃣ Provision Infrastructure with Terraform

cd terraform
terraform init
terraform apply

Creates EC2 instance with public IP.



2️⃣ Configure Server & Deploy App with Ansible

Ensure terraform_inventory.ini has correct key path:

[node_server]
<EC2_PUBLIC_IP> ansible_user=ubuntu ansible_ssh_private_key_file=../keys/Docker-key.pem

Run the playbook:

cd ../ansible
ansible-playbook -i terraform_inventory.ini deploy_node.yml

Installs Docker, pulls Node.js Docker image, and starts the container.



3️⃣ Docker Steps (Reference)

Build and push Docker image:

cd app
docker build -t node-app -f Dockerfile .
docker tag node-app <dockerhub_username>/node-app
docker push <dockerhub_username>/node-app

On EC2, Ansible pulls the image:

docker pull <dockerhub_username>/node-app
docker run -d -p 3000:3000 <dockerhub_username>/node-app



4️⃣ Access the Application

Open browser and visit:

http://<EC2_PUBLIC_IP>:3000

Node.js app should be running.




5️⃣ Docker Container Status

Check running containers on EC2:

docker ps

Expected output:

CONTAINER ID   IMAGE                          STATUS   PORTS
abc123         <dockerhub_username>/node-app Up       0.0.0.0:3000->3000/tcp


## 6️⃣ Screenshots

### Node.js App in Browser
![App Running](https://raw.githubusercontent.com/Prashant2920/NODE_APP_AUTOMATION/main/screenshots/app_running.png)

### Docker Containers Running
![Docker PS](https://raw.githubusercontent.com/Prashant2920/NODE_APP_AUTOMATION/main/screenshots/docker_ps.png)

### Ansible Playbook Output
![Ansible Success](https://raw.githubusercontent.com/Prashant2920/NODE_APP_AUTOMATION/main/screenshots/ansible_success.png)





7️⃣ Notes

.gitignore excludes keys and Terraform state for security.

Replace <dockerhub_username> and <EC2_PUBLIC_IP> with your actual values.

Follow the folder structure to run playbooks without path issues.

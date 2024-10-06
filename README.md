# Inception - System Administration with Docker 🐳

## 📘 Project overview

The Inception project is part of 42's curriculum and focuses on Docker containerization. The goal is to set up an infrastructure with several services, such as an Nginx web server, WordPress, and MariaDB, all running inside Docker containers managed by Docker Compose.

## 🛠️ Features

- Multi-container Docker architecture.
- Nginx server configuration for serving WordPress.
- WordPress installation connected to MariaDB.
- Persistent volumes for data storage.
- Docker Compose orchestration.

## ⚙️ Installation 

clone the project

`git@github.com:Fpalumbo42/inception.git`

build with the Makefile

`make`

Access the WordPress site in your browser at `https://localhost`

## 🖥️ Technologies Used

- Docker: Container platform for packaging services.
- Docker Compose: To manage multi-service applications.
- Nginx: Web server to serve WordPress.
- WordPress: Content Management System (CMS).
- MariaDB: SQL database for WordPress data storage.

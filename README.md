# secure-devsecops-release-platform
simple web application wrapped in a secure software delivery workflow

# Milestone 1: Application Setup
### Goal
Create a simple web application that will be used to demonstrate the DevSecOps pipeline. The application does not need to be complex. The main purpose is to have a small working app that can later be tested, containerised, scanned, deployed, and monitored.

### Success Criteria
**The application runs locally and returns a successful response from / and /health**

Launch the application through Python using the following command:
```sh
python app.py
```
Flask server startup logs:
```sh
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://127.0.0.1:5000
```

Check that the index page is reachable via curl:
```sh
curl http://localhost:5000
```
Output from the curl command:
```sh
response from index page
```
Flask application server logs:
```sh
127.0.0.1 - - [08/Jun/2026 17:44:37] "GET / HTTP/1.1" 200 -
```
Check that the healthcheck endpoint is reachable via curl:
```sh
curl http://localhost:5000/health
```
Output from the curl command:
```sh
{"status":"healthy"}
```
Flask application server logs:
```sh
127.0.0.1 - - [08/Jun/2026 18:52:04] "GET /health HTTP/1.1" 200 -
```
### Outcomes
A working Flask application.\
A health check endpoint.\
A basic project folder structure.\
A requirements.txt file.\
A simple README file.\
The app running locally

# Milestone 2: GitHub Setup, Version Control and Testing
### Goal
Set up GitHub properly, store the project code in a repository, and add basic automated tests. This milestone makes sure the project is organised, trackable, and ready for CI/CD later

### Success Criteria
**Create Branching Strategy**\
main (stable working version)\
dev (active development branch)\
feature/* (individual task branches)

**SetBranch Protection Rules**\
Protect branch name: main\
Require pull request before merging\
Do not allow force pushes\
Do not allow branch deletion

**Create GitHub Issues**\
Create Flask application\
Add health check endpoint\
Add unit tests\
Create README file\
Set up branch protection\
Create initial project structure

**Testing application endpoints using pytest**
```sh
pytest
```
```sh
========================================================================================= test session starts ==========================================================================================
platform linux -- Python 3.12.3, pytest-9.0.3, pluggy-1.6.0
rootdir: /home/yash/code/secure-devsecops-release-platform
collected 2 items                                                                                                                                                                                      

test/test_app.py ..                                                                                                                                                                              [100%]

========================================================================================== 2 passed in 0.06s ===========================================================================================
```
### Outcomes
GitHub repository created.\
Local project pushed to GitHub.\
.gitignore added.\
Branching strategy agreed.\
Basic branch protection configured.\
GitHub Issues created.\
Unit tests added.\
Tests running locally.
README updated

# Milestone 3: Containerisation
### Goal
Package the Flask application into a Docker image so it can run consistently on any machine or deployment environment. This milestone moves the project from a locally running Python application to a portable containerised service. The team should focus on creating a clean Dockerfile, running the app inside Docker, and confirming the health check works from the container.

### Success Criteria
**Running docker build and docker run should produce a working application**\
**The /health endpoint must return a healthy response from inside the container**

Build the Docker image with the 'local' tag using the following command:
```sh
docker build -t secure-devsecops-release-platform:local .
```
Docker image build logs:
```sh
[+] Building 1.0s (11/11) FINISHED                                                             docker:default
 => [internal] load build definition from Dockerfile                                                     0.0s
 => => transferring dockerfile: 315B                                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.12-slim                                      0.8s
 => [internal] load .dockerignore                                                                        0.0s
 => => transferring context: 108B                                                                        0.0s
 => [1/6] FROM docker.io/library/python:3.12-slim@sha256:090ba77e2958f6af52a5341f788b50b032dd4ca28377d2  0.0s
 => => resolve docker.io/library/python:3.12-slim@sha256:090ba77e2958f6af52a5341f788b50b032dd4ca28377d2  0.0s
 => [internal] load build context                                                                        0.0s
 => => transferring context: 277B                                                                        0.0s
 => CACHED [2/6] RUN adduser --disabled-password app                                                     0.0s
 => CACHED [3/6] WORKDIR /app                                                                            0.0s
 => CACHED [4/6] COPY --chown=app:app app/requirements.txt .                                             0.0s
 => CACHED [5/6] RUN pip install --no-cache-dir -r requirements.txt                                      0.0s
 => CACHED [6/6] COPY --chown=app:app app/ .                                                             0.0s
 => exporting to image                                                                                   0.2s
 => => exporting layers                                                                                  0.0s
 => => exporting manifest sha256:fb1d79060a41f0f825fb7786ca76b7ec779dfcac57d12065dbb0a9da32cf33fb        0.0s
 => => exporting config sha256:ec7c8ff011f85000685d66c9afbcf7b0fd6658de359591694d28c3c8bf9218d9          0.0s
 => => exporting attestation manifest sha256:3d1b63fc0b9bd4219c91b437358f80242bcb42cdcb0851fde5e922c4e1  0.0s
 => => exporting manifest list sha256:d8b25f89c56a02fcda5be3b952421ed88fe7be85d18beffc8fc90d53cf162cce   0.0s
 => => naming to docker.io/library/secure-devsecops-release-platform:local                               0.0s
 => => unpacking to docker.io/library/secure-devsecops-release-platform:local                            0.2s
```

**Docker image build completed successfully in 1.0s**

Run the Docker container locally, mapping port 5000 on the host machine to port 5000 in the container:
```sh
docker run --rm -p 5000:5000 secure-devsecops-release-platform:local
```
Output from the Docker run command:
```sh
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.17.0.2:5000
```
**The application runs through the container and returns a successful response from / and /health**

Check that the index page is reachable via curl:
```sh
curl http://localhost:5000
```
Output from the curl command:
```sh
response from index page
```
Docker container output of Flask application server logs:
```sh
172.17.0.1 - - [10/Jun/2026 18:28:25] "GET / HTTP/1.1" 200 -
```
Check that the healthcheck endpoint is reachable via curl:
```sh
curl http://localhost:5000/health
```
Output from the curl command:
```sh
{"status":"healthy"}
```
Docker container output of Flask application server logs:
```sh
172.17.0.1 - - [10/Jun/2026 18:31:39] "GET /health HTTP/1.1" 200 -
```

**Checking running Docker containers/logs for troubleshooting**\
List the running containers:
```sh
docker ps
```
```sh
CONTAINER ID   IMAGE                                     COMMAND                  CREATED         STATUS         PORTS                                         NAMES
15a7bb95d557   secure-devsecops-release-platform:local   "flask run --host=0.…"   6 minutes ago   Up 6 minutes   0.0.0.0:5000->5000/tcp, [::]:5000->5000/tcp   pedantic_ride
```
View the logs from a container:
```sh
docker logs 15a7bb95d557
```
```sh
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.17.0.2:5000
Press CTRL+C to quit
172.17.0.1 - - [10/Jun/2026 18:28:25] "GET / HTTP/1.1" 200 -
172.17.0.1 - - [10/Jun/2026 18:31:39] "GET /health HTTP/1.1" 200 -
```
Stop a running container:
```sh
docker stop 15a7bb95d557
```
```sh
15a7bb95d557
```

### Success Criteria
Running docker build and docker run should produce a working application. The /health endpoint must return a
healthy response from inside the container.

### Outcomes
Docker is installed and running.\
Dockerfile exists in the project root.\
.dockerignore file is added.\
Docker image builds successfully.\
Container runs locally on port 5000.\
Home endpoint and /health endpoint work from the container.\
Basic Docker commands are documented in the README.

# Milestone 4: CI/CD Pipeline
### Goal
Automate testing and Docker image building using GitHub Actions so every code change is checkedconsistently.
This milestone introduces the first version of the CI/CD pipeline. The pipeline does not need to deploy yet. The
purpose is to make sure the project is automatically tested and can successfully build a Docker image whenever code is pushed or a pull request is opened

### Success Criteria
**A pull request should automatically trigger GitHub Actions. The test job and Docker build job must both pass before the change is considered ready to merge.**

**Update branch protection rules**
Require pull request before merging.\
Require at least one approval.\
Require status checks to pass before merging.\
Select the CI Pipeline checks once they appear in GitHub.\
Block force pushes and branch deletion.

### Outcomes
.github/workflows/ci.yml exists.\
Pipeline runs on push and pull request.\
Python dependencies are installed in the pipeline.\
Pytest runs successfully in GitHub Actions.\
Docker image builds successfully in GitHub Actions.\
Docker build depends on the test job passing.\
Pull requests show pipeline status checks.\
README explains how the CI pipeline works.
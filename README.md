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

**Running application tests**\
Set up job
```sh
Current runner version: '2.335.1'
Runner Image Provisioner
Operating System
Runner Image
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download action repository 'actions/checkout@v4' (SHA:34e114876b0b11c390a56381ad16ebd13914f8d5)
Download action repository 'actions/setup-python@v5' (SHA:a26af69be951a213d495a4c3e4e4022e16d87065)
Complete job name: Run application tests
```
Checkout code
```sh
Run actions/checkout@v4
Syncing repository: yashjagani17/secure-devsecops-release-platform
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/b3313db2-a370-4f2c-bcd1-0000e39cc3f1' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/secure-devsecops-release-platform/secure-devsecops-release-platform
Deleting the contents of '/home/runner/work/secure-devsecops-release-platform/secure-devsecops-release-platform'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
/usr/bin/git log -1 --format=%H
fc26565bcaf3be96687f9f29350a8c2081430450
```
Set up Python
```sh
Run actions/setup-python@v5
Installed versions
```
Install dependencies
```sh
Run pip install -r app/requirements.txt
Collecting blinker==1.9.0 (from -r app/requirements.txt (line 1))
  Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
Collecting click==8.4.1 (from -r app/requirements.txt (line 2))
  Downloading click-8.4.1-py3-none-any.whl.metadata (2.6 kB)
Collecting Flask==3.1.3 (from -r app/requirements.txt (line 3))
  Downloading flask-3.1.3-py3-none-any.whl.metadata (3.2 kB)
Collecting iniconfig==2.3.0 (from -r app/requirements.txt (line 4))
  Downloading iniconfig-2.3.0-py3-none-any.whl.metadata (2.5 kB)
Collecting itsdangerous==2.2.0 (from -r app/requirements.txt (line 5))
  Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
Collecting Jinja2==3.1.6 (from -r app/requirements.txt (line 6))
  Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
Collecting MarkupSafe==3.0.3 (from -r app/requirements.txt (line 7))
  Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.7 kB)
Collecting packaging==26.2 (from -r app/requirements.txt (line 8))
  Downloading packaging-26.2-py3-none-any.whl.metadata (3.5 kB)
Collecting pluggy==1.6.0 (from -r app/requirements.txt (line 9))
  Downloading pluggy-1.6.0-py3-none-any.whl.metadata (4.8 kB)
Collecting Pygments==2.20.0 (from -r app/requirements.txt (line 10))
  Downloading pygments-2.20.0-py3-none-any.whl.metadata (2.5 kB)
Collecting pytest==9.0.3 (from -r app/requirements.txt (line 11))
  Downloading pytest-9.0.3-py3-none-any.whl.metadata (7.6 kB)
Collecting six==1.17.0 (from -r app/requirements.txt (line 12))
  Downloading six-1.17.0-py2.py3-none-any.whl.metadata (1.7 kB)
Collecting Werkzeug==3.1.8 (from -r app/requirements.txt (line 13))
  Downloading werkzeug-3.1.8-py3-none-any.whl.metadata (4.0 kB)
Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
Downloading click-8.4.1-py3-none-any.whl (116 kB)
Downloading flask-3.1.3-py3-none-any.whl (103 kB)
Downloading iniconfig-2.3.0-py3-none-any.whl (7.5 kB)
Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (22 kB)
Downloading packaging-26.2-py3-none-any.whl (100 kB)
Downloading pluggy-1.6.0-py3-none-any.whl (20 kB)
Downloading pygments-2.20.0-py3-none-any.whl (1.2 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 117.0 MB/s  0:00:00
Downloading pytest-9.0.3-py3-none-any.whl (375 kB)
Downloading six-1.17.0-py2.py3-none-any.whl (11 kB)
Downloading werkzeug-3.1.8-py3-none-any.whl (226 kB)
Installing collected packages: six, Pygments, pluggy, packaging, MarkupSafe, itsdangerous, iniconfig, click, blinker, Werkzeug, pytest, Jinja2, Flask

Successfully installed Flask-3.1.3 Jinja2-3.1.6 MarkupSafe-3.0.3 Pygments-2.20.0 Werkzeug-3.1.8 blinker-1.9.0 click-8.4.1 iniconfig-2.3.0 itsdangerous-2.2.0 packaging-26.2 pluggy-1.6.0 pytest-9.0.3 six-1.17.0
```
Run tests
```sh
Run pytest
============================= test session starts ==============================
platform linux -- Python 3.12.13, pytest-9.0.3, pluggy-1.6.0
rootdir: /home/runner/work/secure-devsecops-release-platform/secure-devsecops-release-platform
collected 2 items

test/test_app.py ..                                                      [100%]

============================== 2 passed in 0.11s ===============================
```
**Building the Docker image**\
Set up job
```sh
Current runner version: '2.334.0'
Runner Image Provisioner
Operating System
Runner Image
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download action repository 'actions/checkout@v4' (SHA:34e114876b0b11c390a56381ad16ebd13914f8d5)
Complete job name: Build Docker image
```
Checkout code
```sh
Run actions/checkout@v4
Syncing repository: yashjagani17/secure-devsecops-release-platform
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/e6338eb2-92f2-4fbb-be80-e34ec7c20790' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/secure-devsecops-release-platform/secure-devsecops-release-platform
Deleting the contents of '/home/runner/work/secure-devsecops-release-platform/secure-devsecops-release-platform'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
/usr/bin/git log -1 --format=%H
fc26565bcaf3be96687f9f29350a8c2081430450
```
Build Docker image
```sh
Run docker build -t secure-devsecops-release-platform:fc26565bcaf3be96687f9f29350a8c2081430450 .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 315B done
#1 DONE 0.0s

#2 [auth] library/python:pull token for registry-1.docker.io
#2 DONE 0.0s

#3 [internal] load metadata for docker.io/library/python:3.12-slim
#3 DONE 0.5s

#4 [internal] load .dockerignore
#4 transferring context: 108B done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 610B done
#5 DONE 0.0s

#6 [1/6] FROM docker.io/library/python:3.12-slim@sha256:090ba77e2958f6af52a5341f788b50b032dd4ca28377d2893dcf1ecbdfdfe203
#6 resolve docker.io/library/python:3.12-slim@sha256:090ba77e2958f6af52a5341f788b50b032dd4ca28377d2893dcf1ecbdfdfe203 done
#6 sha256:e113665b194b20ba7e9093ef6a1a38edbaebbfb983c00e379a45a142a95a86ef 2.10MB / 12.11MB 0.1s
#6 sha256:07342fe545e640a2c4960e97ffe33a301cd8e61e0c4d4307d7ac66b6b8a9eb2d 0B / 250B 0.1s
#6 sha256:090ba77e2958f6af52a5341f788b50b032dd4ca28377d2893dcf1ecbdfdfe203 10.37kB / 10.37kB done
#6 sha256:866411c135b507754efdf2fda51484be4d3d7d5173ed53cd083106132e710904 1.75kB / 1.75kB done
#6 sha256:e1054bc5a9f2ddbdd6d0247997c45f2201a4e9b4c6f824b247064a558e877070 5.65kB / 5.65kB done
#6 sha256:5b4d6ff92fc4e14e911b7753c954fac965d48c40fe1075758d284148ccace970 22.02MB / 29.78MB 0.1s
#6 sha256:4a9dde5cdde190bfa0a3ab17863a083e66ea9636b157638c315357dfa476ba76 1.29MB / 1.29MB 0.1s done
#6 sha256:e113665b194b20ba7e9093ef6a1a38edbaebbfb983c00e379a45a142a95a86ef 12.11MB / 12.11MB 0.1s done
#6 sha256:07342fe545e640a2c4960e97ffe33a301cd8e61e0c4d4307d7ac66b6b8a9eb2d 250B / 250B 0.1s done
#6 sha256:5b4d6ff92fc4e14e911b7753c954fac965d48c40fe1075758d284148ccace970 29.78MB / 29.78MB 0.1s done
#6 extracting sha256:5b4d6ff92fc4e14e911b7753c954fac965d48c40fe1075758d284148ccace970 0.1s
#6 extracting sha256:5b4d6ff92fc4e14e911b7753c954fac965d48c40fe1075758d284148ccace970 1.0s done
#6 extracting sha256:4a9dde5cdde190bfa0a3ab17863a083e66ea9636b157638c315357dfa476ba76
#6 extracting sha256:4a9dde5cdde190bfa0a3ab17863a083e66ea9636b157638c315357dfa476ba76 0.1s done
#6 extracting sha256:e113665b194b20ba7e9093ef6a1a38edbaebbfb983c00e379a45a142a95a86ef
#6 extracting sha256:e113665b194b20ba7e9093ef6a1a38edbaebbfb983c00e379a45a142a95a86ef 0.6s done
#6 extracting sha256:07342fe545e640a2c4960e97ffe33a301cd8e61e0c4d4307d7ac66b6b8a9eb2d
#6 extracting sha256:07342fe545e640a2c4960e97ffe33a301cd8e61e0c4d4307d7ac66b6b8a9eb2d done
#6 DONE 2.0s

#7 [2/6] RUN adduser --disabled-password app
#7 0.224 Changing the user information for app
#7 0.224 Enter the new value, or press ENTER for the default
#7 0.224 	Full Name []: 	Room Number []: 	Work Phone []: 	Home Phone []: 	Other []: Use of uninitialized value $answer in chop at /usr/sbin/adduser line 992.
#7 0.228 Is the information correct? [Y/n] Use of uninitialized value $answer in pattern match (m//) at /usr/sbin/adduser line 993.
#7 0.228 Use of uninitialized value $answer in pattern match (m//) at /usr/sbin/adduser line 994.
#7 DONE 0.3s

#8 [3/6] WORKDIR /app
#8 DONE 0.0s

#9 [4/6] COPY --chown=app:app app/requirements.txt .
#9 DONE 0.0s

#10 [5/6] RUN pip install --no-cache-dir -r requirements.txt
#10 1.555 Collecting blinker==1.9.0 (from -r requirements.txt (line 1))
#10 1.577   Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
#10 1.592 Collecting click==8.4.1 (from -r requirements.txt (line 2))
#10 1.596   Downloading click-8.4.1-py3-none-any.whl.metadata (2.6 kB)
#10 1.609 Collecting Flask==3.1.3 (from -r requirements.txt (line 3))
#10 1.612   Downloading flask-3.1.3-py3-none-any.whl.metadata (3.2 kB)
#10 1.620 Collecting iniconfig==2.3.0 (from -r requirements.txt (line 4))
#10 1.624   Downloading iniconfig-2.3.0-py3-none-any.whl.metadata (2.5 kB)
#10 1.632 Collecting itsdangerous==2.2.0 (from -r requirements.txt (line 5))
#10 1.635   Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
#10 1.648 Collecting Jinja2==3.1.6 (from -r requirements.txt (line 6))
#10 1.652   Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
#10 1.694 Collecting MarkupSafe==3.0.3 (from -r requirements.txt (line 7))
#10 1.699   Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.7 kB)
#10 1.711 Collecting packaging==26.2 (from -r requirements.txt (line 8))
#10 1.715   Downloading packaging-26.2-py3-none-any.whl.metadata (3.5 kB)
#10 1.725 Collecting pluggy==1.6.0 (from -r requirements.txt (line 9))
#10 1.729   Downloading pluggy-1.6.0-py3-none-any.whl.metadata (4.8 kB)
#10 1.746 Collecting Pygments==2.20.0 (from -r requirements.txt (line 10))
#10 1.750   Downloading pygments-2.20.0-py3-none-any.whl.metadata (2.5 kB)
#10 1.779 Collecting pytest==9.0.3 (from -r requirements.txt (line 11))
#10 1.783   Downloading pytest-9.0.3-py3-none-any.whl.metadata (7.6 kB)
#10 1.795 Collecting six==1.17.0 (from -r requirements.txt (line 12))
#10 1.799   Downloading six-1.17.0-py2.py3-none-any.whl.metadata (1.7 kB)
#10 1.818 Collecting Werkzeug==3.1.8 (from -r requirements.txt (line 13))
#10 1.822   Downloading werkzeug-3.1.8-py3-none-any.whl.metadata (4.0 kB)
#10 1.860 Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
#10 1.864 Downloading click-8.4.1-py3-none-any.whl (116 kB)
#10 1.870 Downloading flask-3.1.3-py3-none-any.whl (103 kB)
#10 1.874 Downloading iniconfig-2.3.0-py3-none-any.whl (7.5 kB)
#10 1.878 Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
#10 1.882 Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
#10 1.885 Downloading markupsafe-3.0.3-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (22 kB)
#10 1.889 Downloading packaging-26.2-py3-none-any.whl (100 kB)
#10 1.893 Downloading pluggy-1.6.0-py3-none-any.whl (20 kB)
#10 1.897 Downloading pygments-2.20.0-py3-none-any.whl (1.2 MB)
#10 1.907    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.2/1.2 MB 189.2 MB/s eta 0:00:00
#10 1.911 Downloading pytest-9.0.3-py3-none-any.whl (375 kB)
#10 1.915 Downloading six-1.17.0-py2.py3-none-any.whl (11 kB)
#10 1.919 Downloading werkzeug-3.1.8-py3-none-any.whl (226 kB)
#10 1.954 Installing collected packages: six, Pygments, pluggy, packaging, MarkupSafe, itsdangerous, iniconfig, click, blinker, Werkzeug, pytest, Jinja2, Flask
#10 3.334 Successfully installed Flask-3.1.3 Jinja2-3.1.6 MarkupSafe-3.0.3 Pygments-2.20.0 Werkzeug-3.1.8 blinker-1.9.0 click-8.4.1 iniconfig-2.3.0 itsdangerous-2.2.0 packaging-26.2 pluggy-1.6.0 pytest-9.0.3 six-1.17.0
#10 3.334 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
#10 3.413 
#10 3.413 [notice] A new release of pip is available: 25.0.1 -> 26.1.2
#10 3.413 [notice] To update, run: pip install --upgrade pip
#10 DONE 3.5s

#11 [6/6] COPY --chown=app:app app/ .
#11 DONE 0.0s

#12 exporting to image
#12 exporting layers
#12 exporting layers 0.7s done
#12 writing image sha256:31ec70639222addd3c2708577736de9c7386068cdc314189deed002872f6a4b4 done
#12 naming to docker.io/library/secure-devsecops-release-platform:fc26565bcaf3be96687f9f29350a8c2081430450 done
#12 DONE 0.7s
```


### Outcomes
.github/workflows/ci.yml exists.\
Pipeline runs on push and pull request.\
Python dependencies are installed in the pipeline.\
Pytest runs successfully in GitHub Actions.\
Docker image builds successfully in GitHub Actions.\
Docker build depends on the test job passing.\
Pull requests show pipeline status checks.\
README explains how the CI pipeline works.


# Milestone 5: Security Scanning
### Goal
Add DevSecOps security checks into the CI/CD pipeline so the team can detect risky code, vulnerable
dependencies, and vulnerable container images before deployment.

### Success Criteria
**Python Code Scan using Bandit**\
Find common insecure Python coding patterns

**Dependency Scan using pip-audit**\
Check Python packages for known vulnerabilities

**Container Image Scan using Trivy**\
Scan the Docker image for OS and library vulnerabilities

**Secrets Check using GitHub Secret Scanning**\
Helps to prevent passwords, tokens, and keys being committed

**Installing the dependencies for the security tools**
```sh
pip install bandit pip-audit
```
**Run the code security vulnerability scan locally**
```sh
bandit -r app/
[main]  INFO    profile include tests: None
[main]  INFO    profile exclude tests: None
[main]  INFO    cli include tests: None
[main]  INFO    cli exclude tests: None
[main]  INFO    running on Python 3.12.3
Run started:2026-06-19 12:05:12.370610+00:00

Test results:
        No issues identified.

Code scanned:
        Total lines of code: 10
        Total lines skipped (#nosec): 0

Run metrics:
        Total issues (by severity):
                Undefined: 0
                Low: 0
                Medium: 0
                High: 0
        Total issues (by confidence):
                Undefined: 0
                Low: 0
                Medium: 0
                High: 0
Files skipped (0):
```
**Run the dependency security vulneerability scan locally**
```sh
pip audit -r app/requirements.txt
No known vulnerabilities found
```
**Run the Trivy image scan on a Docker image**
```sh
docker build -t secure-devsecops-app:latest .
trivy image secure-devsecops-app:latest
2026-06-19T13:08:10+01:00       INFO    [vulndb] Need to update DB
2026-06-19T13:08:10+01:00       INFO    [vulndb] Downloading vulnerability DB...
2026-06-19T13:08:10+01:00       INFO    [vulndb] Downloading artifact...        repo="mirror.gcr.io/aquasec/trivy-db:2"
96.90 MiB / 96.90 MiB [---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 7.44 MiB p/s 13s
2026-06-19T13:08:24+01:00       INFO    [vulndb] Artifact successfully downloaded       repo="mirror.gcr.io/aquasec/trivy-db:2"
2026-06-19T13:08:24+01:00       INFO    [vuln] Vulnerability scanning is enabled
2026-06-19T13:08:24+01:00       INFO    [secret] Secret scanning is enabled
2026-06-19T13:08:24+01:00       INFO    [secret] If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2026-06-19T13:08:24+01:00       INFO    [secret] Please see https://trivy.dev/docs/v0.71/guide/scanner/secret#recommendation for faster secret detection
2026-06-19T13:08:25+01:00       INFO    [python] Licenses acquired from one or more METADATA files may be subject to additional terms. Use `--debug` flag to see all affected packages.
2026-06-19T13:08:25+01:00       INFO    Detected OS     family="debian" version="13.5"
2026-06-19T13:08:25+01:00       INFO    [debian] Detecting vulnerabilities...   os_version="13" pkg_num=87
2026-06-19T13:08:25+01:00       INFO    Number of language-specific files       num=1
2026-06-19T13:08:25+01:00       INFO    [python-pkg] Detecting vulnerabilities...
2026-06-19T13:08:25+01:00       WARN    Using severities from other vendors for some vulnerabilities. Read https://trivy.dev/docs/v0.71/guide/scanner/vulnerability#severity-selection for details.
2026-06-19T13:08:25+01:00       INFO    Table result includes only package filenames. Use '--format json' option to get the full path to the package file.

Report Summary

┌──────────────────────────────────────────────────────────────────────────────┬────────────┬─────────────────┬─────────┐
│                                    Target                                    │    Type    │ Vulnerabilities │ Secrets │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ secure-devsecops-app:latest (debian 13.5)                                    │   debian   │       149       │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/blinker-1.9.0.dist-info/METADATA      │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/click-8.4.1.dist-info/METADATA        │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/flask-3.1.3.dist-info/METADATA        │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/iniconfig-2.3.0.dist-info/METADATA    │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/itsdangerous-2.2.0.dist-info/METADATA │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/jinja2-3.1.6.dist-info/METADATA       │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/markupsafe-3.0.3.dist-info/METADATA   │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/packaging-26.2.dist-info/METADATA     │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/pip-25.0.1.dist-info/METADATA         │ python-pkg │        4        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/pluggy-1.6.0.dist-info/METADATA       │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/pygments-2.20.0.dist-info/METADATA    │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/pytest-9.0.3.dist-info/METADATA       │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/six-1.17.0.dist-info/METADATA         │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/werkzeug-3.1.8.dist-info/METADATA     │ python-pkg │        0        │    -    │
└──────────────────────────────────────────────────────────────────────────────┴────────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)
```

### Outcomes
Bandit security scan added.\
pip-audit dependency scan added.\
Trivy container image scan added.\
Security checks can run locally and in GitHub Actions.\
The team has agreed when the pipeline should fail or warn
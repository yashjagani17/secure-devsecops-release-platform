# secure-devsecops-release-platform
simple web application wrapped in a secure software delivery workflow

# Milestone 1
### Goal
Create a simple web application that will be used to demonstrate the DevSecOps pipeline. The application
does not need to be complex. The main purpose is to have a small working app that can later be tested,
containerised, scanned, deployed, and monitored.

### Success Criteria
**The application runs locally**

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

**The endpoints are reachable**

Check that the index page is reachable via curl:
```sh
curl http://localhost:5000
```
Output from the curl command:
```sh
response from index page
```
Flask application server logs of the curl request:
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
Flask application server logs of the curl request:
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

# Milestone 2
### Goal
Set up GitHub properly, store the project code in a repository, and add basic automated tests. This
milestone makes sure the project is organised, trackable, and ready for CI/CD later

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
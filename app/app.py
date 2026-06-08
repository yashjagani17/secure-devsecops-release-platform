from flask import Flask
from healthcheck import HealthCheck

app = Flask(__name__)

health = HealthCheck()


@app.route("/")
def index():
    return "response from index page"


app.add_url_rule("/health", "healthcheck", view_func=lambda: health.run())

if __name__ == "__main__":
    app.run()

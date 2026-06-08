from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return "response from index page"


@app.route("/health")
def healthcheck():
    return jsonify({"status": "healthy"}), 200


if __name__ == "__main__":
    app.run()

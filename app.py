from flask import Flask, request, render_template_string

app = Flask(__name__)

HTML_PAGE = """
<!doctype html>
<title>Terminal Flask App</title>
<h1>Run a Command</h1>
<form method="post">
  <input type="text" name="command" placeholder="Enter a command">
  <input type="submit" value="Run">
</form>
<pre>{{ output }}</pre>
"""

@app.route("/", methods=["GET", "POST"])
def index():
    output = ""
    if request.method == "POST":
        cmd = request.form.get("command")
        try:
            # Run the command and capture output
            import subprocess
            output = subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT, text=True)
        except subprocess.CalledProcessError as e:
            output = e.output
    return render_template_string(HTML_PAGE, output=output)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)

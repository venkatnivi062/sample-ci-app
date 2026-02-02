#from flask import Flask

#app = Flask(__name__)
 
#@app.route('/')

#def hello():

    #return "Hello, CI/CD World!"
 
#if __name__ == '__main__':

    #app.run(host='0.0.0.0', port=5000)

#======================================================================

from flask import Flask, render_template, request, redirect, url_for

def create_app():
    app = Flask(__name__)

    tasks = []

    @app.route("/", methods=["GET", "POST"])
    def index():
        if request.method == "POST":
            task = request.form.get("task")

            if task:
                tasks.append({
                    "title": task,
                    "completed": False
                })

            return redirect(url_for("index"))

        return render_template("index.html", tasks=tasks)

    @app.route("/complete/<int:task_id>")
    def complete(task_id):
        if 0 <= task_id < len(tasks):
            tasks[task_id]["completed"] = True
        return redirect(url_for("index"))

    @app.route("/delete/<int:task_id>")
    def delete(task_id):
        if 0 <= task_id < len(tasks):
            tasks.pop(task_id)
        return redirect(url_for("index"))

    return app


app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

 

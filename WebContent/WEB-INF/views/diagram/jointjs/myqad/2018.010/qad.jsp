<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>

    <title>QAD</title>
    <link rel="stylesheet" type="text/css" href="/dashboard/js/jointjs/demos/rappid/build/rappid.css">
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/header.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/toolbar.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/statusbar.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/paper.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/preview.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/tooltip.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/snippet.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/dialog.css" rel="stylesheet"/>
    <link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/index.css" rel="stylesheet"/>

    <script>
      SVGElement.prototype.getTransformToElement = SVGElement.prototype.getTransformToElement || function (toElement) {
          return toElement.getScreenCTM().inverse().multiply(this.getScreenCTM());
      };
    </script>

  </head>
  <body>

    <header id="header">
      <h1>QAD</h1>
      <p>Dialog Generator (click a shape and then <q>Preview Dialog</q>)</p>
    </header>

    <section id="app">

      <div id="toolbar">
        <button class="btn add-question">Add Question</button>
        <button class="btn add-answer">Add Answer</button>
        <button class="btn preview-dialog">Preview Dialog</button>
        <button class="btn code-snippet">Code Snippet</button>
        <button class="btn clear">Clear Canvas</button>
        <button class="btn load-example">Load Example</button>
      </div>

      <div id="paper"></div>

      <div id="statusbar">
        <span class="message">Welcome to the QAD Tool!</span>
      </div>

      <div id="preview" class="preview">
      </div>

    </section>

    <!-- Rappid/JointJS dependencies: -->
    <script src="/dashboard/js/jointjs/demos/rappid/node_modules/jquery/dist/jquery.js"></script>
    <script src="/dashboard/js/jointjs/demos/rappid/node_modules/lodash/index.js"></script>
    <script src="/dashboard/js/jointjs/demos/rappid/node_modules/backbone/backbone.js"></script>

    <script src="/dashboard/js/jointjs/demos/rappid/build/rappid.src.18.01.js"></script>


    <script src="/dashboard/js/jointjs/myqad/2018.010/joint.shapes.qad.js"></script>
    <script src="/dashboard/js/jointjs/myqad/2018.010/selection.js"></script>
    <script src="/dashboard/js/jointjs/myqad/2018.010/factory.js"></script>
    <script src="/dashboard/js/jointjs/myqad/2018.010/snippet.js"></script>
    <script src="/dashboard/js/jointjs/myqad/2018.010/app.js"></script>
    <script src="/dashboard/js/jointjs/myqad/2018.010/index.js"></script>
    <script>joint.setTheme('modern');</script>
  </body>
</html>
<%--
window.appView.paper

window.appView.paper.model.attributes.cells.models.filter(function(model){
	return model.attributes.type == "link";
})

window.appView.paper.getModelById("d849d917-8a43-4d51-9e99-291799c144db")


--%>

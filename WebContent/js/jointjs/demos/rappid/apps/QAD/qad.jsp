<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>

    <title>QAD</title>
    <link rel="stylesheet" type="text/css" href="../../build/rappid.css">
    <link href="css/header.css" rel="stylesheet"/>
    <link href="css/toolbar.css" rel="stylesheet"/>
    <link href="css/statusbar.css" rel="stylesheet"/>
    <link href="css/paper.css" rel="stylesheet"/>
    <link href="css/preview.css" rel="stylesheet"/>
    <link href="css/tooltip.css" rel="stylesheet"/>
    <link href="css/snippet.css" rel="stylesheet"/>
    <link href="css/dialog.css" rel="stylesheet"/>
    <link href="css/index.css" rel="stylesheet"/>

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
    <script src="../../node_modules/jquery/dist/jquery.js"></script>
    <script src="../../node_modules/lodash/index.js"></script>
    <script src="../../node_modules/backbone/backbone.js"></script>

    <script src="../../build/rappid.js"></script>

    <script src="src/joint.shapes.qad.js"></script>
    <script src="src/selection.js"></script>
    <script src="src/factory.js"></script>
    <script src="src/snippet.js"></script>
    <script src="src/app.js"></script>
    <script src="src/index.js"></script>
    <script>joint.setTheme('modern');</script>
  </body>
</html>

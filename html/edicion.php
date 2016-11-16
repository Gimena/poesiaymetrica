<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Edición</title>
        <meta charset="utf-8" lang="es" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="css/dialogo.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <header>
            <h1>Diálogo <br />medieval</h1>
            <menu>
                <ul>
                    <li><a>Inicio</a></li>
                    <li><a>Proyecto</a></li>
                    <li><a href="corpus.php">Corpus</a></li>
                    <li><a>Vocabulario</a></li>
                    <li><a>Recursos</a></li>
                </ul>
            </menu>
        </header>
        <main>
            <h1>Edición</h1>
            <?php
    $textos = $_GET["texto"];
    $valoresTextos = implode(",", $textos);
    require_once('config.php');
    $query = REST_PATH . "/db/VTLGP/gimena/edicion.xquery?texto=" . $valoresTextos;
    echo file_get_contents($query);
    
    ?>
    </main></body>
</html>
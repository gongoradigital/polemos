<?php
ini_set('display_errors', '1');
error_reporting(-1);
include (dirname(__FILE__).'/../teipot/Teipot.php');
$teipot = Web::basehref() . '../teipot/';
$theme =  Web::basehref() . '../theme/';
?><!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <?php 
echo '
<title>Gongora, OBVIL</title>
';
    ?>
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900,700italic,600italic' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="<?php echo $teipot; ?>html.css" />
    <link rel="stylesheet" type="text/css" href="<?php echo $teipot; ?>teipot.css" />
    <link rel="stylesheet" type="text/css" href="<?php echo $theme; ?>obvil.css" />
  </head>
  <body>
    <div id="center">
      <header id="header">
        <h1>
          <a href="<?php echo Web::basehref(); ?>">OBVIL, polémique gongorine</a>
        </h1>
        <a class="logo" href="http://obvil.paris-sorbonne.fr/"><img class="logo" src="<?php echo $theme; ?>img/logo-obvil.png" alt="OBVIL"></a>
      </header>
      <div id="contenu">
        <div id="main">
          <nav id="toolbar">
            <?php
            ?>
          </nav>
          <div id="article">
            <p>Bientôt ici, l’œuvre de Gongora.</p>
          </div>
        </div>
        <aside id="aside">
          <?php
          ?>
        </aside>

      </div>
      <?php 
// footer
      ?>
    </div>
    <script type="text/javascript" src="<?php echo $teipot; ?>Tree.js">//</script>
    <script type="text/javascript" src="<?php echo $teipot; ?>Form.js">//</script>
    <script type="text/javascript" src="<?php echo $teipot; ?>Sortable.js">//</script>
    <script type="text/javascript" src="<?php echo $teipot; ?>Teipot.js">//</script>
  </body>
</html>

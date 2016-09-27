<?php
ini_set('display_errors', '1');
error_reporting(-1);
include (dirname(__FILE__).'/../teipot/Teipot.php');
$teipot = Web::basehref() . '../teipot/';
$teinte = Web::basehref() . '../Teinte/';
$theme =  Web::basehref() . '../theme/';

$pot=new Teipot(dirname(__FILE__).'/gongora.sqlite', 'fr');
$pot->file($pot->path);
$doc=$pot->doc($pot->path);
if (!isset($doc['body'])) $pot->search();


?><!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <?php
if(isset($doc['head'])) echo $doc['head'];
else echo '
<title>Gongora, OBVIL</title>
';
    ?>
    <link rel="stylesheet" type="text/css" href="<?php echo $teinte ?>tei2html.css" />
    <link rel="stylesheet" type="text/css" href="<?php echo $theme; ?>obvil.css" />
    <link rel="stylesheet" type="text/css" href="<?php echo Web::basehref() ?>gongora.css" />
  </head>
  <body>
    <div id="center">
      <header id="header">
        <h1>
          <a href="<?php echo Web::basehref(); ?>">OBVIL, polémique gongorine</a>
        </h1>
        <a class="logo" href="http://obvil.paris-sorbonne.fr/corpus/"><img class="logo" src="<?php echo $theme; ?>img/logo-obvil.png" alt="OBVIL"></a>
      </header>
      <div id="contenu">
        <div id="main">
          <nav id="toolbar">
            <?php
if (isset($doc['prevnext'])) echo $doc['prevnext'];
            ?>
          </nav>
          <div id="article">
          <?php
if (isset($doc['bookrowid'])) { // bookfound
  if(isset($doc['body'])) echo $doc['body'];
  else; // ???
  if ($pot->q && (!isset($doc['artname']) || $doc['artname']=='index')) echo $pot->concBook($doc['bookrowid']);
}

else if($pot->qsa() != '') { // searching
  echo $pot->report();
  echo $pot->biblio(array('date', 'title', 'occs'));
  echo $pot->concByBook();
}
else {
  echo file_get_contents(dirname(__FILE__).'/accueil.html');
}
          ?>
          </div>
        </div>
        <aside id="aside">
          <?php
if (isset($doc['bookname'])) {
  if(isset($doc['download'])) echo "\n".'<nav id="download">' . $doc['download'] . '</nav>';
  // auteur, titre, date
  echo "\n".'<header>';
  if ($doc['end']) echo "\n".'<div class="date">'.$doc['end'] .'</div>';
  if ($doc['byline']) echo "\n".'<div class="byline">'.$doc['byline'] .'</div>';
  echo "\n".'<a class="title" href="' . $pot->basehref() . $doc['bookname'] . '/">'.$doc['title'].'</a>';
  echo "\n".'</header>';
  // rechercher dans ce livre
  echo '
  <form action=".#conc" name="searchbook" id="searchbook">
    <input name="q" id="q" onclick="this.select()" class="search" size="20" placeholder="Dans ce volume" title="Dans ce volume" value="'. str_replace('"', '&quot;', $pot->q) .'"/>
    <input style="vertical-align: middle" type="image" id="go" alt="&gt;" value="&gt;" name="go" src="'. $theme . 'img/loupe.png"/>
  </form>
  ';
  // table des matières
  echo '
          <div id="toolpan" class="toc">
            <div class="toc">
              '.$doc['toc'].'
            </div>
          </div>
  ';
}
// accueil ? formulaire de recherche général
else {
  echo'
    <form action="">
      <input name="q" class="text" placeholder="Rechercher" value="'.str_replace('"', '&quot;', $pot->q).'"/>
      <button type="reset" onclick="return Form.reset(this.form)">Effacer</button>
      <button type="submit">Rechercher</button>
    </form>
  ';
}

          ?>
        </aside>

      </div>
      <?php
// footer
      ?>
    </div>
    <script type="text/javascript" src="<?php echo $teinte; ?>Tree.js">//</script>
    <script type="text/javascript" src="<?php echo $teinte; ?>Form.js">//</script>
    <script type="text/javascript" src="<?php echo $teinte; ?>Sortable.js">//</script>
  </body>
</html>

<!--
# Please do not take this too seriously.. But we're all been here...
#
-->
<?php include("config.inc"); ?>
<HTML>
<HEAD><TITLE>RAFFLER</TITLE>
</HEAD>
<BODY>

<?php
$time = explode(" ", microtime());
srand($time[1]);
if (isset($argv[1])) {
$sFile = '';
$fp = fopen($argv[1], 'r');
while ($line = fgets($fp, 4096)) {
    $sFile .= $line;
}
}
if (isset($file)) {
$sFile = '';
$fp = fopen($file, 'r');
while ($line = fgets($fp, 4096)) {
    $sFile .= $line;
}
}

// Use single quotes here for performance reasons
$aNames = split("\n", $sFile);
$iRandomNumber = rand() % count($aNames);
?>

<MARQUEE>The winner is:<BLINK> <?php echo $aNames[$iRandomNumber]; ?></MARQUEE></BLINK>

</BODY>
</HTML>

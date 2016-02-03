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
if (php_sapi_name() == "cli") {
$sFile = file_get_contents($argv[1]);
}
if (php_sapi_name() == "apache") {
$sFile = file_get_contents($_GET['filename']);
}

// Use single quotes here for performance reasons
$aNames = split("\n", $sFile);
$iRandomNumber = rand(0, count($aNames)-1);

?>

<MARQUEE>The winner is:<BLINK> <?php echo $aNames[$iRandomNumber]; ?></MARQUEE></BLINK>

</BODY>
</HTML>

<?php 
$Username = "root";
$Password = "";
$Server = "localhost";
$Database = "db_recipie";

$Con = mysqli_connect($Server,$Username,$Password,$Database);
if(!$Con)
{
 echo "Not Connected";
}

?>
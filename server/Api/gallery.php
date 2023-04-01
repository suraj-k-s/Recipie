<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $recipie_id = $_POST["id"];
    $gallery_file = $_FILES["file"]["name"];
    $temp = $_FILES["file"]["tmp_name"];
    move_uploaded_file($temp, "../Assets/Files/gallery/" . $gallery_file);


    $insQry = "insert into tbl_gallery(recipie_id,gallery_file) 
    values('" . $recipie_id . "','" . $gallery_file . "')";
    if ($Con->query($insQry)) {
        echo "inserted";
    } else {
        echo "not inserted";
    }
}



?>
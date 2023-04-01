<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $recipie_id = $_POST["id"];
    $ingredient_photo = $_FILES["file"]["name"];
    $temp = $_FILES["file"]["tmp_name"];
    move_uploaded_file($temp, "../Assets/Files/ingredients/" . $ingredient_photo);


    $insQry = "insert into tbl_ingredient(recipie_id,ingredient_photo) 
    values('" . $recipie_id . "','" . $ingredient_photo . "')";
    if ($Con->query($insQry)) {
        echo "inserted";
    } else {
        echo "not inserted";
    }
}

?>
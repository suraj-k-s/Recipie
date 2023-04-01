<?php
include("../Connection/connection.php");


if ($_SERVER["REQUEST_METHOD"] == "POST") {


   
    
  $request = file_get_contents("php://input");
  $data = json_decode($request);

  $id = $_POST["id"];

  $name = $_POST["name"];
  $place = $_POST["place"];
  $email = $_POST["email"];
  $number = $_POST["number"];


  $photo = $_FILES["photo"]["name"];
  $temp = $_FILES["photo"]["tmp_name"];
  move_uploaded_file($temp, '../Assets/Files/User/' . $photo);


    $sql1 = "update tbl_user set user_name='$name',user_contact='$number', user_place='$place', user_email='$email',`image`='$photo' where user_id='$id'";
    $Con->query($sql1);
}
?>
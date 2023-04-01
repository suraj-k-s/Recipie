<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $request = file_get_contents("php://input");
    $data = json_decode($request);

    $user_name = $_POST["user_name"];
    $user_contact = $_POST["user_contact"];
    $user_place = $_POST["user_place"];
    $user_email = $_POST["user_email"];
    $user_password = $_POST["user_password"];

    $image = $_FILES["image"]["name"];
    $temp = $_FILES["image"]["tmp_name"];
    move_uploaded_file($temp,"../Assets/Files/User/".$image);


 $insQry = "insert into tbl_user(image,user_name,user_contact,user_place,user_email,user_password) 
    values('" . $image . "','" . $user_name . "','" . $user_contact . "','" . $user_place . "','" . $user_email . "','" . $user_password . "')";
    if ($Con->query($insQry)) {
        echo "Inserted";
    } else {
        echo "Not Inserted";
    }
}


if ($_SERVER["REQUEST_METHOD"] == "GET") {

    $userID = $_GET["id"];

    $selQry = "select * from tbl_user where user_id=$userID";
    $row = $Con->query($selQry);
    $user = array();
    while($data=$row->fetch_assoc())
    {
        $user[] = $data;
    }

    echo json_encode($user);
}





?>
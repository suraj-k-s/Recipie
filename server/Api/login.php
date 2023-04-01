<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {

  $request = file_get_contents("php://input");
  $data = json_decode($request);
  $email = $data->user_email;
  $password = $data->user_password;


  $selQry = "select * from tbl_user where user_email='" . $email . "' and user_password='" . $password . "'";

  $row = $Con->query($selQry);


  if ($data = $row->fetch_assoc()) {
    $userData = array(
      'user_id' => $data["user_id"],
      'user_name' => $data["user_name"],
      'user_email' => $data["user_email"],
      'user_contact' => $data["user_contact"],
      'image' => $data["image"],
      'user_place' => $data["user_place"],
      'user_password' => $data["user_password"],
      'user_status' => $data["user_status"],
    );
    echo json_encode($userData);
  } else {
    echo "Error";
  }
}
?>
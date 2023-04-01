<?php
include("../Connection/connection.php");


if ($_SERVER["REQUEST_METHOD"] == "POST") {


   
    
  $request = file_get_contents("php://input");
  $data = json_decode($request);

  $user_id = $_POST["id"];

  $recipie_title = $_POST["title"];
  $recipie_details = $_POST["description"];
  $recipie_video = $_FILES["video"]["name"];
  $temp = $_FILES["video"]["tmp_name"];
  move_uploaded_file($temp, '../Assets/Files/videos/' . $recipie_video);

  $sql1 = "INSERT INTO tbl_recipie (recipie_title, recipie_details, recipie_video,user_id) VALUES ('$recipie_title', '$recipie_details', '$recipie_video','$user_id')";
  if ($Con->query($sql1)) {

    $sel = "select max(recipie_id) as id from tbl_recipie";
    $row = $Con->query($sel);
    $data = $row->fetch_assoc();
    echo $recipie_id = $data["id"];
  }
}

if ($_SERVER["REQUEST_METHOD"] == "GET") {

  $selQry = "select * from tbl_recipie r inner join tbl_user u on u.user_id=r.user_id where recipie_status=1 ORDER BY recipie_id DESC";
  $row = $Con->query($selQry);

  $recipie = array();
  $i = 0;
  while ($data = $row->fetch_assoc()) {

    $selQry1 = "select * from tbl_gallery where recipie_id='" . $data["recipie_id"] . "'";
    $row1 = $Con->query($selQry1);

    $selQry3 = "select ingredient_photo from  tbl_ingredient where recipie_id='" . $data["recipie_id"] . "'";
    $row3 = $Con->query($selQry3);

    $in = array();

    while ($datza = $row3->fetch_assoc()) {
      $in[] = $datza;
    }


    if ($data1 = $row1->fetch_assoc()) {

      $data["inc"] = $in;
      $data["gallery_file"] = $data1["gallery_file"];
      $recipie[] = $data;

    }
    $i++;
  }
  echo json_encode($recipie);
}
?>
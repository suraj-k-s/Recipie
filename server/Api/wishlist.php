<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {


    $request = file_get_contents("php://input");
    $data = json_decode($request);
    $user_id = $data->user_id;
    $recipie_id = $data->recipie_id;


    $query = "select * from wishlist where recipie_id='".$recipie_id."' and user_id='".$user_id."'";
    $row = $Con->query($query);
    $result = array();
    if($data = $row->fetch_assoc())
    {
        $delQry = "delete from wishlist where recipie_id='" . $recipie_id . "' and user_id='" . $user_id . "'";
        if ($Con->query($delQry)) {
            echo "Deleted";
        } else {
            echo "not Deleted";
        }
    }
    else{
        $insQry = "insert into wishlist(recipie_id,user_id) 
        values('" . $recipie_id . "','" . $user_id . "')";
        if ($Con->query($insQry)) {
            echo "inserted";
        } else {
            echo "failed";
        }
    }

}
if ($_SERVER["REQUEST_METHOD"] == "GET") {
   
    $selQry = "select * from wishlist w inner join tbl_recipie r on r.recipie_id=w.recipie_id inner join tbl_user u on u.user_id=r.user_id where w.user_id='".$_GET["uid"]."' and recipie_status=1 ORDER BY r.recipie_id DESC";
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

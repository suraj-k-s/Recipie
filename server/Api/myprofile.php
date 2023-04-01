<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "GET") {
      $query = "select * from tbl_user where user_id='" . $_GET["user_id"] . "'";
      $row = $Con->query($query);
      $result = array();
      while ($data = $row->fetch_assoc()) {
            $result = $data;
      }

      echo json_encode($result);

}
?>
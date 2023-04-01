<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user_id = $_POST["user_id"];
    $content = $_POST["content"];
    $recipie_id = $_POST["recipie_id"];


    $insQry = "insert into tbl_comment(user_id,content,recipie_id) 
    values('" . $user_id . "','" . $content . "','" . $recipie_id . "')";
    if ($Con->query($insQry)) {
        echo "inserted";
    } else {
        echo "not inserted";
    }
}
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $query = "select * from tbl_comment";
    $row = $Con->query($query);
    $result = array();
    while ($data = $row->fetch_assoc()) {
        $result = $data;
    }

    echo json_encode($result);

}
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    $delqry = "delete from tbl_comment where user_id='" . $_GET["user_id"] . "'";
    if ($Con->query($delqry)) {
        echo "deleted";

    } else {
        echo "failed";
    }
}




?>
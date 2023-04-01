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
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    $delqry = "delete from tbl_user where user_id='" . $_GET["user_id"] . "'";
    if ($Con->query($delqry)) {
        echo "deleted";

    } else {
        echo "failed";
    }
}
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $upqry = "update tbl_user set user_name='" . $_POST["user_name"] . "', user_contact='" . $_POST["user_contact"] . "',user_place = '" . $_POST["user_place"] . "',user_email='" . $_POST["user_email"] . "' where user_id='" . $_GET["user_id"] . "'";
    if ($Con->query($upqry)) {
        echo "updated";

    } else {
        echo "failed";
    }
}




?>
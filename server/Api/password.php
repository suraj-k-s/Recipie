<?php
include("../Connection/connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user_id = $_GET["user_id"];
    $user_password = $_POST["user_password"];
    $new_password = $_POST["new_password"];
    $confirm_password = $_POST["confirm_password"];
    $dbPassword = "";


    $selQry = "SELECT user_password FROM tbl_user WHERE user_id='$user_id'";
    $row = $Con->query($selQry);
    if ($data = $row->fetch_assoc()) {
        $dbPassword = $data["user_password"];
    }





    if ($user_password != $dbPassword) {
        echo "You entered an incorrect current password";
    } else {
        if ($user_password == $new_password) {
            echo "it's your old password";
        } else if ($new_password == $confirm_password) {
            $upqry = "update tbl_user set user_password='$new_password' where user_id='" . $_GET["user_id"] . "'";
            if ($Con->query($upqry)) {
                echo "updated";

            } else {
                echo "failed";
            }
        } else {
            echo "Password Missmatched";
        }
    }
}
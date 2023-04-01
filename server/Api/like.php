<?php
include("../Connection/connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {


    $request = file_get_contents("php://input");
    $data = json_decode($request);
    $user_id = $data->user_id;
    $recipie_id = $data->recipie_id;


    $query = "select * from tbl_like where recipie_id='".$recipie_id."' and user_id='".$user_id."'";
    $row = $Con->query($query);
    $result = array();
    if($data = $row->fetch_assoc())
    {
        $delQry = "delete from tbl_like where recipie_id='" . $recipie_id . "' and user_id='" . $user_id . "'";
        if ($Con->query($delQry)) {
            echo "Deleted";
        } else {
            echo "not Deleted";
        }
    }
    else{
        $insQry = "insert into tbl_like(recipie_id,user_id) 
        values('" . $recipie_id . "','" . $user_id . "')";
        if ($Con->query($insQry)) {
            echo "inserted";
        } else {
            echo "not inserted";
        }
    }

}
if ($_SERVER["REQUEST_METHOD"] == "GET") {
   
    if(isset($_GET["id"])&&isset($_GET["uid"]))
    {
       
        $query = "select * from tbl_like where recipie_id='".$_GET['id']."' and user_id='".$_GET['uid']."'";
        $row = $Con->query($query);
        $result = array();
        if($data = $row->fetch_assoc())
        {
            echo "true";
            
        }
        else{
            echo "false";
        }
    }
    else{
        $query = "select count(*) as count from tbl_like where recipie_id='".$_GET['id']."'";
        $row = $Con->query($query);
        $result = array();
        $data = $row->fetch_assoc();
    
        echo $data["count"];
    }

}
if ($_SERVER["REQUEST_METHOD"] == "DELETE") {
    $delqry = "delete from tbl_like where user_id='" . $_GET["user_id"] . "'";
    if ($Con->query($delqry)) {
        echo "deleted";

    } else {
        echo "failed";
    }
}
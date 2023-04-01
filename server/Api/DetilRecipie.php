<?php
include("../Connection/connection.php");

if ($_SERVER["REQUEST_METHOD"] == "GET") {

    $request = file_get_contents("php://input");
    $data = json_decode($request);

    $user_id = $_GET["id"];



    // Fetch recipe data
    $recipe_query = "SELECT * FROM tbl_recipie WHERE recipie_id = {$user_id}";

    // Execute query and fetch data
    $recipe_result = $conn->query($recipe_query);
    $recipe_data = $recipe_result->fetch_assoc();

    // Fetch ingredient data
    $ingredient_query = "SELECT * FROM tbl_ingredient WHERE recipie_id = {$recipe_data['recipie_id']}";

    // Execute query and fetch data
    $ingredient_result = $conn->query($ingredient_query);
    $ingredient_data = $ingredient_result->fetch_assoc();

    // Fetch gallery data
    $gallery_query = "SELECT * FROM tbl_gallery WHERE recipie_id = {$recipe_data['recipie_id']}";

    // Execute query and fetch data
    $gallery_result = $conn->query($gallery_query);
    $gallery_data = $gallery_result->fetch_assoc();

    // Format data into nested JSON structure
    $data = array(
        "recipe" => array(
            "id" => $recipe_data["recipie_id"],
            "title" => $recipe_data["recipie_title"],
            "details" => $recipe_data["recipie_details"],
            "video" => $recipe_data["recipie_video"],
            "ingredients" => $ingredient_data,
            "gallery" => $gallery_data
        )
    );

    // Encode data into JSON format
    $json_data = json_encode($data);

    // Output JSON data
    echo $json_data;



}
?>
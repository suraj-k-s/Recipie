<?php
session_start();
				include('Connection/connection.php');
			 if(isset($_POST["btn_login"]))
			 {
				$selQry = "select * from tbl_admin where admin_email='".$_POST["txt_email"]."' and admin_password='".$_POST["txt_password"]."'";
			 
				  $rs = $Con->query($selQry);
                   if($data = $rs->fetch_assoc()) 
				   {
					 $_SESSION["aid"] = $data["admin_id"];
					 $_SESSION["aname"] = $data["admin_name"];
					 header("Location:Admin/HomePage.php");
				   }
				   else{
					?>
					<script>
						alert('Invalid Credentials');
						window.location="index.php";
						</script>

					<?php
				   }
			 }
					   
					 ?>

<html>
<head>
	<link rel="stylesheet"type="text/css"
	href="style.css">
	<style>
	input[type="email"]
		{
			border: 0;
			background: none;
			display: block;
			margin: 20px auto;
		text-align: center;
		border: 2px solid rgba(113, 214, 100, 0.699);
		padding: 14px 10px;
		width: 200px;
		outline: none;
		color: white;
		border-radius: 24px;
		transition: 0.25s;
		
		}
		</style>

	 
<title>login page</title>
</head>

<body>
	

	<form class="box"  method='post'>
		<h1>LOGIN</h1>
	  
	  <input type="email"  placeholder="email id" name="txt_email" required autofocus>
	  <input type="password"  placeholder='password' name="txt_password" required>
	   <button style='color: rgb(235, 228, 235);width: 110px;height: 38px;background-color: rgb(212, 41, 55);' type="submit" name="btn_login" value="login">
		
			
		LOGIN
	</button>

	   
	</form>






</body>
</html>
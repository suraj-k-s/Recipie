<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>event</title>
</head>
<?php
ob_start();
include('../Connection/Connection.php');
include('Head.php');

if(isset($_POST["btn_save"]))
{
    $date = $_POST["txt_date"];
    $details = $_POST["txt_details"];
    $title = $_POST["txt_title"];
    $poster = $_FILES["file_poster"]["name"];
    $temp = $_FILES["file_poster"]["tmp_name"];
    move_uploaded_file($temp,"../Assets/Files/poster/".$poster);

    $insQry = "insert into tbl_event(event_date,event_details,event_title,event_poster) 
                values('".$date."','".$details."','".$title."','".$poster."')";

                if($Con->query($insQry))
                {
                    ?>
                        <script>
                            alert("Inserted");
                        </script>
                    <?php
                }
                else{
                    ?>
                    <script>
                        alert("Failed");
                    </script>
                <?php
                }


}
if(isset($_GET["id"]))
{
    $delQry = "delete from tbl_event where event_id='".$_GET["id"]."'";

    if($Con->query($delQry))
    {
        ?>
            <script>
                alert("deleted");
                window.location="Event.php";
            </script>
        <?php
    }
    else{
        ?>
        <script>
            alert("Failed");
        </script>
    <?php
    }
}
?>

<body>
        <section class="main_content dashboard_part">
            <div class="main_content_iner ">
                <div class="container-fluid p-0">
                    <div class="row justify-content-center">
                        <div class="col-12">
                            <div class="QA_section">
                                <!--Form-->
                                <div class="white_box_tittle list_header">
                                    <div class="col-lg-12">
                                        <div class="white_box mb_30">
                                            <div class="box_header ">
                                                <div class="main-title">
                                                    <h3 class="mb-0" > EVENTS</h3>
                                                </div>
                                            </div>
                                            <form method="post" enctype="multipart/form-data">
                                            <div class="form-group">
                                                    <label for="txt_title">Title</label>
                                                    <input required="" type="text" class="form-control" id="txt_title" name="txt_title" autocomplete="off" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txt_date">Date</label>
                                                    <input required="" type="date" class="form-control" id="txt_date" name="txt_date" min="<?php echo date('Y-m-d') ?>" autocomplete="off" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txt_details">Details</label>
                                                    <textarea required=""class="form-control" id="txt_details" name="txt_details" autocomplete="off" required></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label for="file_poster">Poster</label>
                                                    <input required="" type="file" class="form-control" id="file_poster" name="file_poster" autocomplete="off" required>
                                                </div>
                                                <div class="form-group" align="center">
<input type="submit" class="btn-dark" style="width:100px; border-radius: 10px 5px " name="btn_save" value="Save">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="QA_table mb_30">
                                    <!-- table-responsive -->
                                    <table class="table lms_table_active">
                                        <thead>
                                            <tr style="background-color: #74CBF9">
                                                <td align="center" scope="col">Sl.No</td>
                                                <td align="center" scope="col"> Date</td>
                                                <td align="center" scope="col">Title</td>
                                                <td align="center" scope="col">Details</td>
                                                <td align="center" scope="col">Poster</td>
                                                <td align="center" scope="col">Action</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                    $i=0;
                    $selQry = "select * from tbl_event";
                    $row = $Con->query($selQry);
                    while($data=$row->fetch_assoc())
                    {
                        $i++;
                        ?>
                            <tr>
                                <td align="center"><?php echo $i; ?></td>
                                <td align="center"><?php echo $data["event_date"]; ?></td>
                                <td align="center"><?php echo $data["event_title"]; ?></td>
                                <td align="center"><?php echo $data["event_details"]; ?></td>
                                <td align="center"><img src="../Assets/Files/Poster/<?php echo $data["event_poster"]; ?>"  width="150" height="150"/></td>
                                <td align="center">
                                    <a href="Event.php?id=<?php echo $data["event_id"]; ?>">Delete</a>
                                </td>
                            </tr>
                        <?php
                    }
                ?>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <?php
		include('Foot.php');
		 ob_end_flush();
		?>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link rel="stylesheet" href="Admin/css/bootstrap.min.css" />
        <!-- themefy CSS -->
        <link rel="stylesheet" href="Admin/vendors/themefy_icon/themify-icons.css" />
        <!-- swiper slider CSS -->
        <link rel="stylesheet" href="Admin/vendors/swiper_slider/css/swiper.min.css" />
        <!-- select2 CSS -->
        <link rel="stylesheet" href="Admin/vendors/select2/css/select2.min.css" />
        <!-- select2 CSS -->
        <link rel="stylesheet" href="Admin/vendors/niceselect/css/nice-select.css" />
        <!-- owl carousel CSS -->
        <link rel="stylesheet" href="Admin/vendors/owl_carousel/css/owl.carousel.css" />
        <!-- gijgo css -->
        <link rel="stylesheet" href="Admin/vendors/gijgo/gijgo.min.css" />
        <!-- font awesome CSS -->
        <link rel="stylesheet" href="Admin/vendors/font_awesome/css/all.min.css" />
        <link rel="stylesheet" href="Admin/vendors/tagsinput/tagsinput.css" />
        <!-- datatable CSS -->
        <link rel="stylesheet" href="Admin/vendors/datatable/css/jquery.dataTables.min.css" />
        <link rel="stylesheet" href="Admin/vendors/datatable/css/responsive.dataTables.min.css" />
        <link rel="stylesheet" href="Admin/vendors/datatable/css/buttons.dataTables.min.css" />
        <!-- text editor css -->
        <link rel="stylesheet" href="Admin/vendors/text_editor/summernote-bs4.css" />
        <!-- morris css -->
        <link rel="stylesheet" href="Admin/vendors/morris/morris.css">
        <!-- metarial icon css -->
        <link rel="stylesheet" href="Admin/vendors/material_icon/material-icons.css" />

        <!-- menu css  -->
        <link rel="stylesheet" href="Admin/css/metisMenu.css">
        <!-- style CSS -->
        <link rel="stylesheet" href="Admin/css/style.css" />
        <link rel="stylesheet" href="Admin/css/colors/default.css" id="colorSkinCSS">
</head>
<?php
ob_start();
include('../Connection/Connection.php');

$selQ="select * from tbl_recipie where recipie_id='".$_GET["id"]."'";
$row1 = $Con->query($selQ);
$data1=$row1->fetch_assoc();

?>

<body>
        <section class="main_content dashboard_part" style="padding-left: 0%;">
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
                                                    <h3 class="mb-0" >Recipie</h3>
                                                </div>
                                            </div>
                                            <form method="post" enctype="multipart/form-data">
                                            <div class="form-group">
                                                    <label for="txt_title">Title</label>
                                                    <input value="<?php echo $data1["recipie_title"] ?>" type="text" class="form-control" id="txt_date" name="txt_date" autocomplete="off" required readonly>

                                                </div>
                                                <div class="form-group" >
                                                    <label for="txt_details">Details</label>
                                                    <textarea style="height: 157px;" class="form-control" id="txt_details" name="txt_details" autocomplete="off" required readonly><?php echo $data1["recipie_details"] ?></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txt_details">Video</label>
                                                    <video width="320" height="240" controls class="form-control" style="height: 250px;">
                                                            <source src="../Assets/Files/videos/<?php echo $data1["recipie_video"]; ?>" type="video/mp4">
                                                            <source src="../Assets/Files/videos/<?php echo $data["recipie_video"]; ?>" type="video/ogg">
                                                            Your browser does not support the video tag.
                                                    </video>
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
                                                <!-- <td align="center" scope="col"> Caption</td> -->
                                                <td align="center" scope="col">Photo</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php
                    $i=0;
                    $selQry = "select * from tbl_ingredient where recipie_id='".$_GET["id"]."'";
                    $row = $Con->query($selQry);
                    while($data=$row->fetch_assoc())
                    {
                        $i++;
                        ?>
                            <tr>
                                <td align="center"><?php echo $i; ?></td>
                                <!-- <td align="center"><//?php echo $data["ingredient_caption"]; ?></td> -->
                                <td align="center"><img src="../Assets/Files/ingredients/<?php echo $data["ingredient_photo"]; ?>" style="border-radius: 0;
    width: 140px;
    height: 104px;"/></td>
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

            <section class="main_content dashboard_part" style="padding-left: 0%;">
            <div class="main_content_iner ">
                <div class="container-fluid p-0">
                    <div class="row justify-content-center">
                        <div class="col-xl-12">
                            <div class="white_box card_height_100">
                                <div class="box_header border_bottom_1px  ">
                                    <div class="main-title">
                                        <h3 class="mb_25">Gallery</h3>
                                    </div>
                                </div>
                                <div class="staf_list_wrapper sraf_active owl-carousel">
                                    <?php
                                        $selQry = "select * from tbl_gallery where recipie_id='".$_GET["id"]."'";
                                        $result1 = $Con->query($selQry);
										while($data1 = $result1->fetch_assoc())
                                        {
                                    ?>
                                    <div class="single_staf">
                                        <div class="staf_thumb">
                                            <img src="../Assets/Files/gallery/<?php echo $data1["gallery_file"]; ?>" alt="">
                                        </div>
                                        
                                    </div>
                                    <?php
                                        }
                                    ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </section>
        </section>
        <?php
		include('Foot.php');
		 ob_end_flush();
		?>
</body>
</html>
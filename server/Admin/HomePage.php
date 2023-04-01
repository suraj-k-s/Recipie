<?php include("Head.php"); ?>
        <section class="main_content dashboard_part">
            <div class="main_content_iner ">
                <div class="container-fluid p-0">
                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="single_element">
                                <div class="quick_activity">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="quick_activity_wrap">
                                                <div class="single_quick_activity d-flex">
                                                    <div class="icon">
                                                        <img src="Admin/img/icon/user.png" alt="">
                                                    </div>
                                                    <div class="count_content">
                                                        <h3><span class="counter">
                                                        <?php
														$sel = "select count(user_id) as id from tbl_user";
														$result = $Con->query($sel);
														$data = $result->fetch_assoc();
														echo $data["id"];
                                                        ?>
                                                        </span> </h3>
                                                        <p>User</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-12">
                            <div class="white_box card_height_100">
                                <div class="box_header border_bottom_1px  ">
                                    <div class="main-title">
                                        <h3 class="mb_25">User</h3>
                                    </div>
                                </div>
                                <div class="staf_list_wrapper sraf_active owl-carousel">
                                    <?php
                                        $selQry = "select * from tbl_user";
                                        $result1 = $Con->query($selQry);
										while($data1 = $result1->fetch_assoc())
                                        {
                                    ?>
                                    <div class="single_staf">
                                        <div class="staf_thumb">
                                            <img src="../Assets/Files/User/<?php echo $data1["image"] ?>" alt="">
                                        </div>
                                        <h4><?php echo $data1["user_name"] ?></h4>
                                        <p><?php echo $data1["user_contact"] ?></p>
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
        <!-- main content part end -->

        <!-- footer  -->
        <!-- jquery slim -->
        <script src="Admin/js/jquery-3.4.1.min.js"></script>
        <!-- popper js -->
        <script src="Admin/js/popper.min.js"></script>
        <!-- bootstarp js -->
        <script src="Admin/js/bootstrap.min.js"></script>
        <!-- sidebar menu  -->
        <script src="Admin/js/metisMenu.js"></script>
        <!-- waypoints js -->
        <script src="Admin/vendors/count_up/jquery.waypoints.min.js"></script>
        <!-- waypoints js -->
        <script src="Admin/vendors/chartlist/Chart.min.js"></script>
        <!-- counterup js -->
        <script src="Admin/vendors/count_up/jquery.counterup.min.js"></script>
        <!-- swiper slider js -->
        <script src="Admin/vendors/swiper_slider/js/swiper.min.js"></script>
        <!-- nice select -->
        <script src="Admin/vendors/niceselect/js/jquery.nice-select.min.js"></script>
        <!-- owl carousel -->
        <script src="Admin/vendors/owl_carousel/js/owl.carousel.min.js"></script>
        <!-- gijgo css -->
        <script src="Admin/vendors/gijgo/gijgo.min.js"></script>
        <!-- responsive table -->
        <script src="Admin/vendors/datatable/js/jquery.dataTables.min.js"></script>
        <script src="Admin/vendors/datatable/js/dataTables.responsive.min.js"></script>
        <script src="Admin/vendors/datatable/js/dataTables.buttons.min.js"></script>
        <script src="Admin/vendors/datatable/js/buttons.flash.min.js"></script>
        <script src="Admin/vendors/datatable/js/jszip.min.js"></script>
        <script src="Admin/vendors/datatable/js/pdfmake.min.js"></script>
        <script src="Admin/vendors/datatable/js/vfs_fonts.js"></script>
        <script src="Admin/vendors/datatable/js/buttons.html5.min.js"></script>
        <script src="Admin/vendors/datatable/js/buttons.print.min.js"></script>

        <script src="Admin/js/chart.min.js"></script>
        <!-- progressbar js -->
        <script src="Admin/vendors/progressbar/jquery.barfiller.js"></script>
        <!-- tag input -->
        <script src="Admin/vendors/tagsinput/tagsinput.js"></script>
        <!-- text editor js -->
        <script src="Admin/vendors/text_editor/summernote-bs4.js"></script>

        <script src="Admin/vendors/apex_chart/apexcharts.js"></script>

        <!-- custom js -->
        <script src="Admin/js/custom.js"></script>

        <script src="Admin/vendors/apex_chart/bar_active_1.js"></script>
        <script src="Admin/vendors/apex_chart/apex_chart_list.js"></script>
    </body>
</html>
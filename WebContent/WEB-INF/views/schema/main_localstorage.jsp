<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

  <head>

    <!-- Required meta tags -->

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">





    <!-- Twitter -->

    <meta name="twitter:site" content="@themepixels">

    <meta name="twitter:creator" content="@themepixels">

    <meta name="twitter:card" content="summary_large_image">

    <meta name="twitter:title" content="Bracket">

    <meta name="twitter:description" content="Premium Quality and Responsive UI for Dashboard.">

    <meta name="twitter:image" content="http://themepixels.me/bracket/img/bracket-social.png">



    <!-- Facebook -->

    <meta property="og:url" content="http://themepixels.me/bracket">

    <meta property="og:title" content="Bracket">

    <meta property="og:description" content="Premium Quality and Responsive UI for Dashboard.">



    <meta property="og:image" content="http://themepixels.me/bracket/img/bracket-social.png">

    <meta property="og:image:secure_url" content="http://themepixels.me/bracket/img/bracket-social.png">

    <meta property="og:image:type" content="image/png">

    <meta property="og:image:width" content="1200">

    <meta property="og:image:height" content="600">



    <!-- Meta -->

    <meta name="description" content="Premium Quality and Responsive UI for Dashboard.">

    <meta name="author" content="ThemePixels">



    <title>Bracket Responsive Bootstrap 4 Admin Template</title>



    <!-- vendor css -->

    <link href="./templates/bracket/lib/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="./templates/bracket/lib/Ionicons/css/ionicons.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/octicons/4.4.0/font/octicons.css" rel="stylesheet" >

    <link href="./templates/bracket/lib/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet">

    <link href="./templates/bracket/lib/jquery-switchbutton/jquery.switchButton.css" rel="stylesheet">

    <link href="./templates/bracket/lib/rickshaw/rickshaw.min.css" rel="stylesheet">

    <link href="./js/jquery-ui-1.11.3.custom/jquery-ui.css" rel="stylesheet"/>



    <!-- Bracket CSS -->

    <link rel="stylesheet" href="./templates/bracket/css/bracket.css">

    <!-- jqgrid CSS -->

    <link rel="stylesheet" type="text/css" media="screen" href="./js/bootstrap/ui.jqgrid-bootstrap4.css" />

  </head>



  <body>



    <!--  START: LEFT PANEL -->

    <div class="br-logo"><a href=""><span>[</span>bracket<span>]</span></a></div>

    <div class="br-sideleft overflow-y-auto">

      <label class="sidebar-label pd-x-15 mg-t-20">Navigation</label>

      <div class="br-sideleft-menu">

        

        

        

        <a href="#" class="br-menu-link">

          <div class="br-menu-item">

            <i class="menu-item-icon ion-ios-book-outline tx-24"></i>

            <span class="menu-item-label">Menu</span>

            <i class="menu-item-arrow fa fa-angle-down"></i>

          </div><!-- menu-item -->

        </a><!-- br-menu-link -->

        <ul class="br-menu-sub nav flex-column">

                                <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('board');" class="nav-link">board</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('board_reply');" class="nav-link">boardReply</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('rm_cmm_cd');" class="nav-link">rmCmmCd</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('rm_cmm_use');" class="nav-link">rmCmmUse</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('rm_el_baseinfo_mng');" class="nav-link">rmElBaseinfoMng</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('rm_el_etc_mng_info');" class="nav-link">rmElEtcMngInfo</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('rm_el_etc_test');" class="nav-link">rmElEtcTest</a></li>

                      <li class="nav-item"><a href="javascript:;" onclick="fn_makeInstance('rm_tab_cols');" class="nav-link">rmTabCols</a></li>

                    

        </ul>

      </div><!-- br-sideleft-menu -->



      <br>

    </div><!-- br-sideleft -->

    <!--  END: LEFT PANEL  -->



    <!--  START: HEAD PANEL  -->

    <div class="br-header">

      <div class="br-header-left">

        <div class="navicon-left hidden-md-down"><a id="btnLeftMenu" href=""><i class="icon ion-navicon-round"></i></a></div>

        <div class="navicon-left hidden-lg-up"><a id="btnLeftMenuMobile" href=""><i class="icon ion-navicon-round"></i></a></div>

        <div class="input-group hidden-xs-down wd-170 transition">

          <input id="searchbox" type="text" class="form-control" placeholder="Search">

          <span class="input-group-btn">

            <button class="btn btn-secondary" type="button"><i class="fa fa-search"></i></button>

          </span>

        </div><!-- input-group -->

      </div><!-- br-header-left -->

    </div><!-- br-header --> 

    <!--  END: HEAD PANEL  -->



    <!--  START: RIGHT PANEL  -->

    <div class="br-sideright">

      <ul class="nav nav-tabs sidebar-tabs" role="tablist">

        <li class="nav-item">

          <a class="nav-link active" data-toggle="tab" role="tab" href="#contacts"><i class="icon ion-ios-contact-outline tx-24"></i></a>

        </li>

        <li class="nav-item">

          <a class="nav-link" data-toggle="tab" role="tab" href="#attachments"><i class="icon ion-ios-folder-outline tx-22"></i></a>

        </li>

        <li class="nav-item">

          <a class="nav-link" data-toggle="tab" role="tab" href="#calendar"><i class="icon ion-ios-calendar-outline tx-24"></i></a>

        </li>

        <li class="nav-item">

          <a class="nav-link" data-toggle="tab" role="tab" href="#settings"><i class="icon ion-ios-gear-outline tx-24"></i></a>

        </li>

      </ul><!-- sidebar-tabs -->



      <!-- Tab panes -->

      <div class="tab-content">

        <div class="tab-pane pos-absolute a-0 mg-t-60 overflow-y-auto active" id="contacts" role="tabpanel">

          <label class="sidebar-label pd-x-25 mg-t-25">Online Contacts</label>

          <div class="contact-list pd-x-10">

            <a href="" class="contact-list-link new">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img2.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Marilyn Tarter</p>

                  <span class="tx-12 op-5 d-inline-block">Clemson, CA</span>

                </div>

                <span class="tx-info tx-12"><span class="square-8 bg-info rounded-circle"></span> 1 new</span>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img3.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0 ">Belinda Connor</p>

                  <span class="tx-12 op-5 d-inline-block">Fort Kent, ME</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link new">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img4.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Britanny Cevallos</p>

                  <span class="tx-12 op-5 d-inline-block">Shiboygan Falls, WI</span>

                </div>

                <span class="tx-info tx-12"><span class="square-8 bg-info rounded-circle"></span> 3 new</span>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link new">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img5.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Brandon Lawrence</p>

                  <span class="tx-12 op-5 d-inline-block">Snohomish, WA</span>

                </div>

                <span class="tx-info tx-12"><span class="square-8 bg-info rounded-circle"></span> 1 new</span>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img6.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Andrew Wiggins</p>

                  <span class="tx-12 op-5 d-inline-block">Springfield, MA</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img7.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Theodore Gristen</p>

                  <span class="tx-12 op-5 d-inline-block">Nashville, TN</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img8.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-success"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Deborah Miner</p>

                  <span class="tx-12 op-5 d-inline-block">North Shore, CA</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

          </div><!-- contact-list -->





          <label class="sidebar-label pd-x-25 mg-t-25">Offline Contacts</label>

          <div class="contact-list pd-x-10">

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img2.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Marilyn Tarter</p>

                  <span class="tx-12 op-5 d-inline-block">Clemson, CA</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img3.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="mg-l-10">

                  <p class="mg-b-0">Belinda Connor</p>

                  <span class="tx-12 op-5 d-inline-block">Fort Kent, ME</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img4.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Britanny Cevallos</p>

                  <span class="tx-12 op-5 d-inline-block">Shiboygan Falls, WI</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img5.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Brandon Lawrence</p>

                  <span class="tx-12 op-5 d-inline-block">Snohomish, WA</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img6.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Andrew Wiggins</p>

                  <span class="tx-12 op-5 d-inline-block">Springfield, MA</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img7.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Theodore Gristen</p>

                  <span class="tx-12 op-5 d-inline-block">Nashville, TN</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

            <a href="" class="contact-list-link">

              <div class="d-flex">

                <div class="pos-relative">

                  <img src="templates/bracket/img/img8.jpg" class="wd-40 rounded-circle" alt="">

                  <div class="contact-status-indicator bg-gray-500"></div>

                </div>

                <div class="contact-person">

                  <p class="mg-b-0">Deborah Miner</p>

                  <span class="tx-12 op-5 d-inline-block">North Shore, CA</span>

                </div>

              </div><!-- d-flex -->

            </a><!-- contact-list-link -->

          </div><!-- contact-list -->



        </div><!-- #contacts -->





        <div class="tab-pane pos-absolute a-0 mg-t-60 overflow-y-auto" id="attachments" role="tabpanel">

          <label class="sidebar-label pd-x-25 mg-t-25">Recent Attachments</label>

          <div class="media-file-list">

            <div class="media">

              <div class="pd-10 bg-primary wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-image-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">IMG_43445</p>

                <p class="mg-b-0 tx-12 op-5">JPG Image</p>

                <p class="mg-b-0 tx-12 op-5">1.2mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-purple wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-video-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">VID_6543</p>

                <p class="mg-b-0 tx-12 op-5">MP4 Video</p>

                <p class="mg-b-0 tx-12 op-5">24.8mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-success wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-word-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">Tax_Form</p>

                <p class="mg-b-0 tx-12 op-5">Word Document</p>

                <p class="mg-b-0 tx-12 op-5">5.5mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-warning wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-pdf-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">Getting_Started</p>

                <p class="mg-b-0 tx-12 op-5">PDF Document</p>

                <p class="mg-b-0 tx-12 op-5">12.7mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-warning wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-pdf-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">Introduction</p>

                <p class="mg-b-0 tx-12 op-5">PDF Document</p>

                <p class="mg-b-0 tx-12 op-5">7.7mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-primary wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-image-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">IMG_43420</p>

                <p class="mg-b-0 tx-12 op-5">JPG Image</p>

                <p class="mg-b-0 tx-12 op-5">2.2mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-primary wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-image-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">IMG_43447</p>

                <p class="mg-b-0 tx-12 op-5">JPG Image</p>

                <p class="mg-b-0 tx-12 op-5">3.2mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-purple wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-video-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">VID_6545</p>

                <p class="mg-b-0 tx-12 op-5">AVI Video</p>

                <p class="mg-b-0 tx-12 op-5">14.8mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

            <div class="media mg-t-20">

              <div class="pd-10 bg-success wd-50 ht-60 tx-center d-flex align-items-center justify-content-center">

                <i class="fa fa-file-word-o tx-28 tx-white"></i>

              </div>

              <div class="media-body">

                <p class="mg-b-0 tx-13">Secret_Document</p>

                <p class="mg-b-0 tx-12 op-5">Word Document</p>

                <p class="mg-b-0 tx-12 op-5">4.5mb</p>

              </div><!-- media-body -->

              <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

            </div><!-- media -->

          </div><!-- media-list -->

        </div><!-- #history -->

        <div class="tab-pane pos-absolute a-0 mg-t-60 overflow-y-auto" id="calendar" role="tabpanel">

          <label class="sidebar-label pd-x-25 mg-t-25">Time &amp; Date</label>

          <div class="pd-x-25">

            <h2 id="brTime" class="tx-white tx-lato mg-b-5"></h2>

            <h6 id="brDate" class="tx-white tx-light op-3"></h6>

          </div>



          <label class="sidebar-label pd-x-25 mg-t-25">Events Calendar</label>

          <div class="datepicker sidebar-datepicker"></div>





          <label class="sidebar-label pd-x-25 mg-t-25">Event Today</label>

          <div class="pd-x-25">

            <div class="list-group sidebar-event-list mg-b-20">

              <div class="list-group-item">

                <div>

                  <h6 class="tx-white tx-13 mg-b-5 tx-normal">Roven's 32th Birthday</h6>

                  <p class="mg-b-0 tx-white tx-12 op-2">2:30PM</p>

                </div>

                <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

              </div><!-- list-group-item -->

              <div class="list-group-item">

                <div>

                  <h6 class="tx-white tx-13 mg-b-5 tx-normal">Regular Workout Schedule</h6>

                  <p class="mg-b-0 tx-white tx-12 op-2">7:30PM</p>

                </div>

                <a href="" class="more"><i class="icon ion-android-more-vertical tx-18"></i></a>

              </div><!-- list-group-item -->

            </div><!-- list-group -->



            <a href="" class="btn btn-block btn-outline-secondary tx-uppercase tx-11 tx-spacing-2">+ Add Event</a>

            <br>

          </div>



        </div>

        <div class="tab-pane pos-absolute a-0 mg-t-60 overflow-y-auto" id="settings" role="tabpanel">

          <label class="sidebar-label pd-x-25 mg-t-25">Quick Settings</label>



          <div class="pd-y-20 pd-x-25 tx-white">

            <h6 class="tx-13 tx-normal">Sound Notification</h6>

            <p class="op-5 tx-13">Play an alert sound everytime there is a new notification.</p>

            <div class="pos-relative">

              <input type="checkbox" name="checkbox" class="switch-button" checked>

            </div>

          </div>



          <div class="pd-y-20 pd-x-25 tx-white">

            <h6 class="tx-13 tx-normal">2 Steps Verification</h6>

            <p class="op-5 tx-13">Sign in using a two step verification by sending a verification code to your phone.</p>

            <div class="pos-relative">

              <input type="checkbox" name="checkbox2" class="switch-button">

            </div>

          </div>



          <div class="pd-y-20 pd-x-25 tx-white">

            <h6 class="tx-13 tx-normal">Location Services</h6>

            <p class="op-5 tx-13">Allowing us to access your location</p>

            <div class="pos-relative">

              <input type="checkbox" name="checkbox3" class="switch-button">

            </div>

          </div>



          <div class="pd-y-20 pd-x-25 tx-white">

            <h6 class="tx-13 tx-normal">Newsletter Subscription</h6>

            <p class="op-5 tx-13">Enables you to send us news and updates send straight to your email.</p>

            <div class="pos-relative">

              <input type="checkbox" name="checkbox4" class="switch-button" checked>

            </div>

          </div>



          <div class="pd-y-20 pd-x-25 tx-white">

            <h6 class="tx-13 tx-normal">Your email</h6>

            <div class="pos-relative">

              <input type="email" name="email" class="form-control form-control-inverse transition pd-y-10" value="janedoe@domain.com">

            </div>

          </div>



          <div class="pd-y-20 pd-x-25">

            <h6 class="tx-13 tx-normal tx-white mg-b-20">More Settings</h6>

            <a href="" class="btn btn-block btn-outline-secondary tx-uppercase tx-11 tx-spacing-2">Account Settings</a>

            <a href="" class="btn btn-block btn-outline-secondary tx-uppercase tx-11 tx-spacing-2">Privacy Settings</a>

          </div>



        </div>

      </div><!-- tab-content -->

    </div><!-- br-sideright -->

    <!--  END: RIGHT PANEL  --->



    <!--  START: MAIN PANEL  -->

    <div class="br-mainpanel">



      <div id="pagebody" class="br-pagebody mg-t-5 pd-x-30">

        <div class="br-section-wrapper"></div>

      </div><!-- br-pagebody -->

    </div><!-- br-mainpanel -->

    <!--  END: MAIN PANEL  -->



    <div id="dialog-confirm"></div>

    <!-- Stacked  Modal -->

    <div name="infiniteLogModal"  class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">

      <div class="modal-dialog modal-xl" >

        <div class="modal-content">

          <div class="modal-header">

            <h6 class="tx-14 mg-b-0 tx-inverse tx-bold"><span></span></h6>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

          </div>

          <div class="modal-body" >

          </div>

        </div>

      </div>

    </div>

    



    <div name="modal-edit"  class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">

      <div class="modal-dialog modal-lg" >

        <div class="modal-content">

          <div class="modal-header" style="width: 800px;">

            <h6 class="tx-14 mg-b-0 tx-inverse tx-bold"><span></span></h6>

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

          </div>

          <div class="modal-body" >

          </div>

        </div>

      </div>

    </div>



    <div id="modal-alert" class="modal fade">

      <div class="modal-dialog" role="document">

        <div class="modal-content tx-size-sm">

          <div class="modal-body tx-center pd-y-20 pd-x-20">

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

            <i class="icon icon ion-ios-close-outline tx-100 tx-danger lh-1 mg-t-20 d-inline-block"></i>

            <h4 class="tx-danger  tx-semibold mg-b-20">Error: Cannot process your entry!</h4>

            <p class="mg-b-20 mg-x-20">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.</p>

            <button type="button" class="btn btn-danger tx-11 tx-uppercase pd-y-12 pd-x-25 tx-mont tx-medium mg-b-20" data-dismiss="modal" aria-label="Close">

              Continue</button>

            </div><!-- modal-body -->

          </div><!-- modal-content -->

        </div><!-- modal-dialog -->

    </div><!-- modal -->

    <div id="modal-success" class="modal fade">

      <div class="modal-dialog" role="document">

        <div class="modal-content tx-size-sm">

          <div class="modal-body tx-center pd-y-20 pd-x-20">

            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

              <span aria-hidden="true">&times;</span>

            </button>

            <i class="icon ion-ios-checkmark-outline tx-100 tx-success lh-1 mg-t-20 d-inline-block"></i>

            <h4 class="tx-success tx-semibold mg-b-20">Congratulations!</h4>

            <p class="mg-b-20 mg-x-20">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.</p>

            <button type="button" class="btn btn-success tx-11 tx-uppercase pd-y-12 pd-x-25 tx-mont tx-medium mg-b-20" data-dismiss="modal" aria-label="Close">

              Continue</button>

            </div><!-- modal-body -->

          </div><!-- modal-content -->

        </div><!-- modal-dialog -->

    </div><!-- modal -->





    <script src="./templates/bracket/lib/jquery/jquery.js"></script>

    <script src="./templates/bracket/lib/popper.js/popper.js"></script>

    <script src="./templates/bracket/lib/bootstrap/bootstrap.js"></script>

    <script src="./templates/bracket/lib/perfect-scrollbar/js/perfect-scrollbar.jquery.js"></script>

    <script src="./templates/bracket/lib/moment/moment.js"></script>

    <script src="./templates/bracket/lib/jquery-ui/jquery-ui.js"></script>

    <script src="./templates/bracket/lib/jquery-switchbutton/jquery.switchButton.js"></script>

    <script src="./templates/bracket/lib/peity/jquery.peity.js"></script>

    <script src="./templates/bracket/lib/jquery.sparkline.bower/jquery.sparkline.min.js"></script>

    <script src="./templates/bracket/lib/d3/d3.js"></script>

    <script src="./templates/bracket/lib/rickshaw/rickshaw.min.js"></script>

    <script src="http://themetrace.com/templates/bracket/lib/jquery.maskedinput/jquery.maskedinput.js"></script>

    <script src="http://themetrace.com/templates/bracket/lib/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>



    <script src="./templates/bracket/js/bracket.js"></script>

    <script src="./templates/bracket/js/ResizeSensor.js"></script>



    <!-- jqgrid -->

    <script src="./js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>

    <script src="./js/jqGrid_JS_5.3.1/src/jquery.jqGrid.js"></script>

    



    <!-- multiselect -->

    <script src="./js/jquery-multiselect/jquery.multiselect.js"></script>

		<script src="./js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>

		<link rel="stylesheet" type="text/css" href="./js/jquery-multiselect/jquery.multiselect.css" />

    <link rel="stylesheet" type="text/css" href="./js/jquery-multiselect/jquery.multiselect.filter.css" />



    <!-- JS Tree -->

		<script type="text/javascript" src="./js/jstree/3.3.8/dist/jstree.min.js"></script>

    <link rel="stylesheet" type="text/css" href="./js/jstree/3.3.8/dist/themes/default/style.min.css" />

    

    <!-- contextMenu -->

    <link rel="stylesheet" media="screen" href="./js/jQuery-contextMenu-master/dist/jquery.contextMenu.min.css" type="text/css" />

		<script src="./js/jQuery-contextMenu-master/dist/jquery.contextMenu.min.js"></script>

    <script src="./js/jQuery-contextMenu-master/dist/jquery.ui.position.js"></script>

    

    <!-- alasql -->

    <script type="text/javascript" src="./js/alasql-develop/dist/alasql.js"></script>

    <!-- lodash -->

    <script src="./js/jointjs/lodash.4.17.10.js"></script>

    <!-- utils -->

    <script src="./js/dashboard.toolbox.js?version=0"></script>

    



    <!-- react  -->

    <script  src="./js/react-0.14.3/build/react.js"></script>

		<script  src="./js/react-0.14.3/build/react-dom.js"></script>

		<script  src="./js/react-0.14.3/build/react-with-addons.js"></script>

    <script  src="./js/react-0.14.3/browser.js" ></script>



    <!-- ì¤í¤ë§ë¥¼ ë°íì¼ë¡ ìì¤ë¥¼ ìì±íê¸°  -->

    <script src="./js/bpmn/java_jsp/allFromJpa.bracket.js"></script>

    <script src="./js/bpmn/instance/localstorage/gen_instance_list.js"></script>

    <script src="./js/bpmn/instance/localstorage/gen_instance.js"></script>

    <script src="./js/bpmn/instance/localstorage/gen_instance_add.js"></script>

    <script src="./js/bpmn/instance/localstorage/gen_instance_edit.js"></script>

    <script src="./js/bpmn/instance/localstorage/gen_instance_copy.js"></script>

    <script src="./js/bpmn/instance/localstorage/gen_instance_view.js"></script>

    <script src="./js/bpmn/instance/localstorage/makeHtmlBySchema.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/jpaFiles.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/board.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/boardReply.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/rmCmmCd.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/rmCmmUse.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/rmElBaseinfoMng.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/rmElEtcMngInfo.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/rmElEtcTest.js"></script>

        <script src="./js/bpmn/gen/thenet.localstorage/rmTabCols.js"></script>

        <!-- <script src="./js/gen/testEntityJpaFiles.2020.04.07.03.11.38.js"></script> -->

    <script>

		$.jgrid.defaults.responsive = true;

		$.jgrid.defaults.styleUI = 'Bootstrap4';

		$.jgrid.defaults.iconSet = "fontAwesome";



		var instances = {};



		$(function(){

		'use strict'



		// FOR DEMO ONLY

		// menu collapsed by default during first page load or refresh with screen

		// having a size between 992px and 1299px. This is intended on this page only

		// for better viewing of widgets demo.

		$(window).resize(function(){

			minimizeMenu();

		});



		minimizeMenu();



		function minimizeMenu() {

			if(window.matchMedia('(min-width: 992px)').matches && window.matchMedia('(max-width: 1299px)').matches) {

			// show only the icons and hide left menu label by default

			$('.menu-item-label,.menu-item-arrow').addClass('op-lg-0-force d-lg-none');

			$('body').addClass('collapsed-menu');

			$('.show-sub + .br-menu-sub').slideUp();

			} else if(window.matchMedia('(min-width: 1300px)').matches && !$('body').hasClass('collapsed-menu')) {

			$('.menu-item-label,.menu-item-arrow').removeClass('op-lg-0-force d-lg-none');

			$('body').removeClass('collapsed-menu');

			$('.show-sub + .br-menu-sub').slideDown();

			}

		}



		// $('.fc-datepicker').datepicker({

		//   dateFormat: "yy-mm-dd",

		//   showOtherMonths: true,

		//   selectOtherMonths: true

		// });
		fn_indexedDB();


		});



		function fn_makeInstance(_entityId){

		delete instances;

		instances = new gen_instance_list($("#pagebody .br-section-wrapper") , jpaFiles );

		var instanceOption = {

			isPopSelect : false

		};

		instances.add_instance(_entityId ,'general', instanceOption );

		}

		var db = null;
		function fn_indexedDB(){

			var req = indexedDB.open( "thenet" , 2);
			req.onsuccess = function (evt) {
				// Better use "this" than "req" to get the result to avoid problems with
				// garbage collection.
				// db = req.result;
				db = this.result;
				console.log("openDb DONE");
			};
			req.onerror = function (evt) {
				console.error("openDb:", evt.target.errorCode);
			};
			req.onupgradeneeded = function (evt) {
				console.log("openDb.onupgradeneeded");
				db = this.result;
				$.each(jpaFiles , function(i, _file){
					var keyCols = _.filter( _file.gridProperties , { isKey : true } );
					var keys = $.map(keyCols,function(col,i){
						return col._name.toUpperCase();
					});

					var storeIndex = _.indexOf( db.objectStoreNames , _file.entityId);
					if( storeIndex < 0 ){
						var store = db.createObjectStore(
							_file.entityId , { keyPath: keys }
						);  
					}				

				});
				
				
				// store.createIndex('title', 'title', { unique: false });
			};

			
		}

		// Stacked Modal

			// $(document).on('show.bs.modal', '.modal', function (event) {

				

			// var zIndex = 1500 + (10 * $('.modal:visible').length);

			// $(this).css('z-index', zIndex);

			// setTimeout(function() {

			//     $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');

			// }, 0);

		// });



		$(document).on('shown.bs.modal', '.modal', function (event) {

		var grid = $(event.target).find(".ui-jqgrid-btable");

			if(grid.length > 0 ){

			var gridParam = grid.getGridParam();

			// height

			var gridBody = $("#gbox_" + gridParam.id + " .ui-jqgrid-bdiv");

			gridBody.height( "100%" );

			grid.setGridWidth($(event.target).find(".modal-body").width());

			gridBody.height( gridBody.height() + 10  );

			// action submit prevent

			$(grid.getGridParam("pager")).find("td button.dropdownmenu").attr("type","button");

			}

			var backdrops = $('.modal-backdrop.fade.show');

			$.each(backdrops, function(i, backdrop){

			if(i>0)

				$(backdrop).css("opacity",0);

			});

		});



		// modal Close

			$(document).on('hidden.bs.modal', function (event) {

				

				$('.modal:visible').length && $(document.body).addClass('modal-open');

		// $("#modal_2019-5-31-11-38-56").remove();

		var _this = $(this);

		var target = $(event.target);        

		if(target.attr("isCloned") != null)

			target.remove();



		// success , alert ë±ì instance ê° ìì¼ë¯ë¡ ë³ëë¡ ì§ì í´ ì¤ë¤.

		var targetId = target.attr("id");

		if(target.attr("target-id") != null)

			targetId = target.attr("target-id");

		var target_instance = findAllByElName(instances.list   , {containerId : targetId });

		if ( target_instance == null)

			return;



		var list_instance = target_instance.list_instance;

		var rm_instance = null;



		if( _.includes(['modal-success'] , target.attr("id") )){

			// var last_instance = list_instance.list[ instances.list.length -1 ];

			if(target_instance instanceof genInstanceEdit){

			

			}else if ( target_instance instanceof genInstanceAdd){

			target_instance.modalClone.modal("toggle");

			}else if ( target_instance instanceof genInstanceCopy){

			target_instance.modalClone.modal("toggle");

			}



		}else if ( _.includes(['modal-alert'] , target.attr("id") )){



		}else{

			rm_instance = list_instance.list.pop();

		}

		// console.log(instances);

		

			});


		


    </script>

  </body>

  <jsp:include page="/WEB-INF/views/include/includeReactComponent.jsp"></jsp:include>

   <style>

    .ui-dialog { z-index: 1000 !important ;}

    .contextMenu{

			color: #337ab7;			

			font-weight: bold;

		}



    /* *********** Bootstrap Custom Start************/

		/***  jqgrid Header   ***/

		.ui-jqgrid-hdiv th {

			text-align: center;

		}

		

		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {

    	    color: #000;

			background-color: #f5f5f5;

    	    background-image: none

    	}

    	

    	.ui-jqgrid .ui-jqgrid-htable th div {

			height:auto;

			overflow:hidden;

			padding-right:4px;

			padding-top:2px;

			position:relative;

			vertical-align:text-top;

			white-space:normal !important;

		}

		.ui-jqgrid .ui-jqgrid-bdiv .table>tbody>tr>td.active {

			background-color: unset;

		}



		.ui-jqgrid {

			/* border-top: 2px solid #fc5d57; */

		} 



		.ui-jqgrid-view  .ui-jqgrid-bdiv td.glyphicon {

			top : 0px;

			display: table-cell ;

		}



		/* *********** Bootstrap Custom End************/

		/* .modal-content.ui-resizable {

			overflow: scroll;

		} */



		.required:after {

			content:"*";color:red;

		}



		div[type=HorizontalLayout] {

			min-height:  22px;

		}



    /* border 0 ==> border 1px  */

    .ui-jqgrid .table-bordered td,

    .ui-jqgrid .table-bordered th.ui-th-ltr

    {

      border-left: 1px solid #dee2e6 !important;

    }



    .ui-jqgrid .table-bordered td:first-child,

    .ui-jqgrid .table-bordered th.ui-th-ltr:first-child

    {

      border-left: 0 !important;

    }



    .table-bordered > thead> tr > th:first-child ,

    .table-bordered > tbody > tr > td:first-child {

      border-left-width: 0 !important;

    }





    .ui-jqgrid .ui-jqgrid-htable thead th {

        border-bottom: 1px solid #dee2e6;

    }





    .table-bordered > tbody > tr:last-child > th, .table-bordered > tbody > tr:last-child > td {

        border-bottom-width:  1px;

    }



    .table-bordered > thead> tr > th:last-child ,

    .table-bordered > tbody > tr > td:last-child {

      border-right: 1px solid #e9ecef;

      border-right-width: 1;

    }



    @media (min-width: 1200px) {

      .modal-xl {

        max-width: 1140px;

      }

    }

  </style>

</html>


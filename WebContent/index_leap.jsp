<!doctype html>
<html lang="en">

  <head> 

    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-52115242-16"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
    
      gtag('config', 'UA-52115242-16');
    </script>
    <!-- Google Tag Manager -->
    <script>
      (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
      new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
      j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
      'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
      })(window,document,'script','dataLayer','GTM-KG38NH9');
    </script>
    <!-- End Google Tag Manager -->
    <meta charset="utf-8">
    <title>Leap Bootstrap Theme and HTML Template</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A corporate Bootstrap theme by Medium Rare">
    <style>
      @keyframes hideLoader{0%{ width: 100%; height: 100%; }100%{ width: 0; height: 0; }  }  body > div.loader{ position: fixed; background: white; width: 100%; height: 100%; z-index: 1071; opacity: 0; transition: opacity .5s ease; overflow: hidden; pointer-events: none; display: flex; align-items: center; justify-content: center;}body:not(.loaded) > div.loader{ opacity: 1;}body:not(.loaded){ overflow: hidden;}  body.loaded > div.loader{animation: hideLoader .5s linear .5s forwards;  } /* Typing Animation */.loading-animation {width: 6px;height: 6px;border-radius: 50%;animation: typing 1s linear infinite alternate;position: relative;left: -12px;}@keyframes typing {0% {background-color: rgba(100,100,100, 1);box-shadow: 12px 0px 0px 0px rgba(100,100,100, 0.2),24px 0px 0px 0px rgba(100,100,100, 0.2);}25% {background-color: rgba(100,100,100, 0.4);box-shadow: 12px 0px 0px 0px rgba(100,100,100, 2),24px 0px 0px 0px rgba(100,100,100, 0.2);}75% {background-color: rgba(100,100,100, 0.4);box-shadow: 12px 0px 0px 0px rgba(100,100,100, 0.2),24px 0px 0px 0px rgba(100,100,100, 1);}}
    </style>
    <script type="text/javascript">
      window.addEventListener("load", function () {    document.querySelector('body').classList.add('loaded');  });
    </script>
    <link href="templates/leap/assets/css/theme.min.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="preload" as="font" href="templates/leap/assets/fonts/Inter-UI-upright.var.woff2" type="font/woff2" crossorigin="anonymous">
    <link rel="preload" as="font" href="templates/leap/assets/fonts/Inter-UI.var.woff2" type="font/woff2" crossorigin="anonymous">
  </head>

  <body data-smooth-scroll-offset="73">
    <div class="loader">
      <div class="loading-animation"></div>
    </div>
    <div class="navbar-container ">
      <nav class="navbar navbar-expand-lg navbar-dark" data-overlay data-sticky="top">
        <div class="container">
          <a class="navbar-brand fade-page" href="index.html">
            <img src="templates/leap/assets/img/logo-white.svg" alt="Leap">
          </a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false" aria-label="Toggle navigation">
            <img class="icon navbar-toggler-open" src="templates/leap/assets/img/icons/interface/menu.svg" alt="menu interface icon" data-inject-svg />
            <img class="icon navbar-toggler-close" src="templates/leap/assets/img/icons/interface/cross.svg" alt="cross interface icon" data-inject-svg />
          </button>
          <div class="collapse navbar-collapse justify-content-end">
            <div class="py-2 py-lg-0">
              <ul class="navbar-nav">
                <li class="nav-item dropdown">
                  <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">Demos</a>
                  <div class="dropdown-menu row">
                    <div class="col-auto" data-dropdown-content>
                      <div class="dropdown-grid-menu"><a href="home-course.html" class="dropdown-item fade-page">Course</a><a href="home-coworking.html" class="dropdown-item fade-page">Coworking<span class="badge badge-primary ml-2">New</span></a><a href="home-cryptocurrency.html" class="dropdown-item fade-page">Cryptocurrency</a>
                        <a
                        href="home-desktop-app.html" class="dropdown-item fade-page">Desktop App</a><a href="home-event.html" class="dropdown-item fade-page">Event</a><a href="home-mobile-app.html" class="dropdown-item fade-page">Mobile App</a><a href="home-portfolio.html" class="dropdown-item fade-page">Portfolio</a>
                          <a
                          href="home-saas.html" class="dropdown-item fade-page">SaaS</a><a href="home-saas-trend.html" class="dropdown-item fade-page">SaaS - Trend</a><a href="home-software-library.html" class="dropdown-item fade-page">Software Library</a>
                      </div>
                    </div>
                  </div>
                </li>
                <li class="nav-item dropdown">
                  <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">Pages</a>
                  <div class="dropdown-menu row">
                    <div class="col-auto" data-dropdown-content>
                      <div class="dropdown-grid-menu"><a href="about-company.html" class="dropdown-item fade-page">About Company</a>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Careers</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="careers.html" class="dropdown-item fade-page">Careers</a><a href="career-single.html" class="dropdown-item fade-page">Career Single</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Contact</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="contact.html" class="dropdown-item fade-page">Contact</a><a href="contact-multiple-locations.html" class="dropdown-item fade-page">Contact - Multiple Locations</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Customers</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="customer-stories.html" class="dropdown-item fade-page">Customer Stories</a><a href="customer-story.html" class="dropdown-item fade-page">Customer Story</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Knowledgebase</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="knowledgebase.html" class="dropdown-item fade-page">Knowledgebase</a><a href="knowledgebase-category.html" class="dropdown-item fade-page">Knowledgebase Category</a><a href="knowledgebase-article.html" class="dropdown-item fade-page">Knowledgebase Article</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Pricing</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="pricing-plans.html" class="dropdown-item fade-page">Pricing Plans</a><a href="pricing-plans-table.html" class="dropdown-item fade-page">Pricing Plans Table</a><a href="pricing-slider.html" class="dropdown-item fade-page">Pricing Slider</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Utility</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="404.html" class="dropdown-item fade-page">404</a><a href="utility-coming-soon-subscribe.html" class="dropdown-item fade-page">Coming Soon - Subscribe</a><a href="utility-coming-soon.html" class="dropdown-item fade-page">Coming Soon</a>
                                <a
                                href="utility-confirmation-download.html" class="dropdown-item fade-page">Confirmation - Download</a><a href="utility-confirmation-subscription.html" class="dropdown-item fade-page">Confirmation - Subscription</a><a href="utility-legal.html" class="dropdown-item fade-page">Legal</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Account</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="account-onboarding.html" class="dropdown-item fade-page">Onboarding</a><a href="account-sign-in.html" class="dropdown-item fade-page">Sign In</a><a href="account-sign-up.html" class="dropdown-item fade-page">Sign Up</a>
                                <a
                                href="account-sign-up-image.html" class="dropdown-item fade-page">Sign Up Image</a><a href="account-forgot-password.html" class="dropdown-item fade-page">Forgot Password</a>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li class="nav-item dropdown">
                  <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">Blog</a>
                  <div class="dropdown-menu row">
                    <div class="col-auto" data-dropdown-content>
                      <div class="dropdown-grid-menu">
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Blog Layouts</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="blog-cards.html" class="dropdown-item fade-page">Blog Cards</a><a href="blog-masonry.html" class="dropdown-item fade-page">Blog Masonry</a><a href="blog-sidebar.html" class="dropdown-item fade-page">Blog Sidebar</a>
                                <a
                                href="blog-magazine.html" class="dropdown-item fade-page">Blog Magazine</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Article Layouts</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="blog-article.html" class="dropdown-item fade-page">Article Basic</a><a href="blog-article-video.html" class="dropdown-item fade-page">Article Video</a><a href="blog-article-image-header.html" class="dropdown-item fade-page">Article Image Header</a>
                                <a
                                href="blog-article-image-header-parallax.html" class="dropdown-item fade-page">Article Image Parallax</a>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li class="nav-item dropdown">
                  <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">Portfolio</a>
                  <div class="dropdown-menu row">
                    <div class="col-auto" data-dropdown-content>
                      <div class="dropdown-grid-menu">
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Grid Layouts</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="portfolio-2-columns.html" class="dropdown-item fade-page">2 Columns</a><a href="portfolio-3-columns.html" class="dropdown-item fade-page">3 Columns</a><a href="portfolio-4-columns.html" class="dropdown-item fade-page">4 Columns</a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="dropdown">
                          <a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">
                            <span>Project Layouts</span>
                            <img class="icon bg-dark opacity-20" src="templates/leap/assets/img/icons/interface/arrow-caret.svg" alt="arrow-caret interface icon" data-inject-svg />
                          </a>
                          <div class="dropdown-menu row">
                            <div class="col-auto" data-dropdown-content>
                              <div class="dropdown-grid-menu"><a href="portfolio-case-study.html" class="dropdown-item fade-page">Case Study</a><a href="portfolio-single-sidebar.html" class="dropdown-item fade-page">Sidebar</a><a href="portfolio-single-slider.html" class="dropdown-item fade-page">Slider</a>
                                <a
                                href="portfolio-single-parallax.html" class="dropdown-item fade-page">Parallax</a>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li class="nav-item dropdown">
                  <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">Elements</a>
                  <div class="dropdown-menu bg-primary-3 text-light border-bottom">
                    <div class="container py-4" data-dropdown-content>
                      <div class="row">
                        <div class="col-lg col-md-4 mb-3 mb-lg-0">
                          <h5>Base</h5>
                          <div><a class="dropdown-item fade-page" href="elements-grid.html">Grid</a><a class="dropdown-item fade-page" href="elements-forms.html">Forms</a><a class="dropdown-item fade-page" href="elements-tables.html">Tables</a><a class="dropdown-item fade-page"
                            href="elements-typography.html">Typography</a>
                          </div>
                        </div>
                        <div class="col-lg col-md-4 mb-3 mb-lg-0">
                          <h5>General</h5>
                          <div><a class="dropdown-item fade-page" href="elements-alerts.html">Alerts</a><a class="dropdown-item fade-page" href="elements-avatars.html">Avatars</a><a class="dropdown-item fade-page" href="elements-badges.html">Badges</a><a class="dropdown-item fade-page"
                            href="elements-breadcrumbs.html">Breadcrumbs</a><a class="dropdown-item fade-page" href="elements-buttons.html">Buttons</a><a class="dropdown-item fade-page" href="elements-cards.html">Cards</a><a class="dropdown-item fade-page"
                            href="elements-dropdowns-bootstrap.html">Dropdowns Bootstrap</a><a class="dropdown-item fade-page" href="elements-dropdowns-grid.html">Dropdowns Grid</a><a class="dropdown-item fade-page" href="elements-footers.html">Footers</a>
                            <a
                            class="dropdown-item fade-page" href="elements-navbars.html">Navigation</a><a class="dropdown-item fade-page" href="elements-tooltips.html">Tooltips</a><a class="dropdown-item fade-page" href="elements-toasts.html">Toasts</a><a class="dropdown-item fade-page" href="elements-widgets.html">Widgets</a>
                          </div>
                        </div>
                        <div class="col-lg col-md-4 mb-3 mb-lg-0">
                          <h5>Graphic</h5>
                          <div><a class="dropdown-item fade-page" href="elements-decorations.html">Decorations</a><a class="dropdown-item fade-page" href="elements-dividers.html">Dividers</a><a class="dropdown-item fade-page" href="elements-icons.html">Icons</a>
                            <a
                            class="dropdown-item fade-page" href="elements-icons-reference.html">Icons Reference</a><a class="dropdown-item fade-page" href="elements-processes.html">Processes</a><a class="dropdown-item fade-page" href="elements-progress.html">Progress</a><a class="dropdown-item fade-page" href="elements-pricing.html">Pricing</a>
                          </div>
                        </div>
                        <div class="col-lg col-md-4 mb-3 mb-lg-0">
                          <h5>Media</h5>
                          <div><a class="dropdown-item fade-page" href="elements-fancybox.html">Fancybox</a><a class="dropdown-item fade-page" href="elements-isotope.html">Isotope</a><a class="dropdown-item fade-page" href="elements-maps.html">Maps</a><a class="dropdown-item fade-page"
                            href="elements-flickity.html">Slider Flickity</a><a class="dropdown-item fade-page" href="elements-twitter.html">Twitter Feeds</a><a class="dropdown-item fade-page" href="elements-video-players.html">Video Players</a><a class="dropdown-item fade-page"
                            href="elements-video-backgrounds.html">Video Backgrounds</a>
                          </div>
                        </div>
                        <div class="col-lg col-md-4 mb-3 mb-lg-0">
                          <h5>Interactive</h5>
                          <div><a class="dropdown-item fade-page" href="elements-animations.html">Animations</a><a class="dropdown-item fade-page" href="elements-accordions.html">Accordion</a><a class="dropdown-item fade-page" href="elements-counters.html">Counters</a>
                            <a
                            class="dropdown-item fade-page" href="elements-countdown.html">Countdown</a><a class="dropdown-item fade-page" href="elements-date-picker.html">Date Picker</a><a class="dropdown-item fade-page" href="elements-modals.html">Modals</a><a class="dropdown-item fade-page" href="elements-navs.html">Tabs (Nav)</a>
                              <a
                              class="dropdown-item fade-page" href="elements-typed-text.html">Typed Text</a><a class="dropdown-item fade-page" href="elements-parallax.html">Parallax</a><a class="dropdown-item fade-page" href="elements-popovers.html">Popovers</a><a class="dropdown-item fade-page" href="elements-wizards.html">Wizards</a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
                <li class="nav-item dropdown">
                  <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown-grid" aria-expanded="false" aria-haspopup="true">Support</a>
                  <div class="dropdown-menu row">
                    <div class="col-auto px-0" data-dropdown-content>
                      <div class="bg-white rounded border shadow-lg o-hidden">
                        <div class="p-3">
                          <h6 class="mb-0">Product Support</h6>
                        </div>
                        <div class="list-group list-group-flush">
                          <a href="documentation/index.html" target="_blank" class="list-group-item list-group-item-action d-flex align-items-center p-3">
                            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/files/selected-file.svg" alt="selected-file icon" data-inject-svg />
                            <div class="text-body ml-3">
                              <span>Documentation</span>
                              <div class="text-small text-muted">Get all the information you need</div>
                            </div>
                          </a>
                          <a href="https://themes.zendesk.com/hc/en-us/articles/360000006291-How-do-I-get-help-with-the-theme-I-purchased-" target="_blank" class="list-group-item list-group-item-action d-flex align-items-center p-3">
                            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/communication/chat-4.svg" alt="chat-4 icon" data-inject-svg />
                            <div class="text-body ml-3">
                              <span>Looking for answers?</span>
                              <div class="text-small text-muted">Get support</div>
                            </div>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
            </div><a href="https://themes.getbootstrap.com/product/leap-multipurpose-bootstrap-theme/" class="btn btn-white ml-lg-3">Purchase Now</a>

          </div>
        </div>
      </nav>
    </div>

    <div data-overlay class="bg-primary text-light o-hidden position-relative">
      <div class="position-absolute w-100 h-100 o-hidden top-0">
        <div class="decoration right bottom scale-2">
          <img class="bg-primary-2" src="templates/leap/assets/img/decorations/deco-blob-2.svg" alt="deco-blob-2 decoration" data-inject-svg />
        </div>
        <div class="decoration right bottom scale-3">
          <img class="bg-white" src="templates/leap/assets/img/decorations/deco-dots-6.svg" alt="deco-dots-6 decoration" data-inject-svg />
        </div>
        <div class="decoration top left scale-2  d-none d-md-block">
          <img class="bg-primary-3" src="templates/leap/assets/img/decorations/deco-blob-1.svg" alt="deco-blob-1 decoration" data-inject-svg />
        </div>
      </div>
      <section class="min-vh-70 o-hidden d-flex flex-column justify-content-center">
        <div class="container">
          <div class="row justify-content-center text-center align-items-center">
            <div class="col-xl-8 col-lg-9 col-md-10 layer-3" data-aos="fade-up" data-aos-delay="500">
              <h1 class="display-3">
            Launch on time,<br>look on-trend.
          </h1>
              <div class="mb-4">
                <p class="lead px-xl-5">
                  Save countless hours of design and development and ship performant sites with killer looks.
                </p>
              </div>
              <a href="#demos" class="btn btn-lg btn-white mx-1" data-smooth-scroll>View Demos</a>
              <a href="https://themes.getbootstrap.com/product/leap-multipurpose-bootstrap-theme/" class="btn btn-lg btn-primary-3 mx-1">Purchase</a>
            </div>
          </div>
        </div>
      </section>
      <div class="divider flip-x">
        <img src="templates/leap/assets/img/dividers/divider-2.svg" alt="graphical divider" data-inject-svg />
      </div>
    </div>
    <section class="text-center" id="demos">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-xl-9">
            <h2 class="h1">Get started with a production-ready landing page or build your own.</h2>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-coworking.html">
              <img src="templates/leap/assets/img/demos/home-coworking.png" alt="Coworking" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-coworking.html" class="fade-up">
                  <h3 class="h2">Coworking<span class="badge badge-primary ml-2">New</span></h3>
                </a>
                <p class="lead">
                  A landing for shared workspaces with date picker functionality.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/home/clock.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Date picker</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/rss.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Blog listing cards</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/media/movie-lane-2.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Fullscreen video lightbox</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-mobile-app.html">
              <img src="templates/leap/assets/img/demos/home-mobile-application.png" alt="Mobile Application" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-mobile-app.html" class="fade-up">
                  <h3 class="h2">Mobile Application</h3>
                </a>
                <p class="lead">
                  Make an impression showcasing the features of your mobile app.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/devices/iphone-x.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Screenshot slider</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/media/movie-lane-2.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Fullscreen video lightbox</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/layout/layout-arrange.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Masonry testimonials</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-course.html">
              <img src="templates/leap/assets/img/demos/home-course.png" alt="Online Course" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-course.html" class="fade-up">
                  <h3 class="h2">Online Course</h3>
                </a>
                <p class="lead">
                  An engaging layout to promote e-learning and paid course material.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/add-user.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Signup form</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/chat-6.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Testimonial slider</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/home/book-open.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Chapter overview cards</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-saas.html">
              <img src="templates/leap/assets/img/demos/home-saas.png" alt="SaaS Application" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-saas.html" class="fade-up">
                  <h3 class="h2">SaaS Application</h3>
                </a>
                <p class="lead">
                  Educate potential customers and grow your user base.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/add-user.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Signup form</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/cooking/dish.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Image with hotspot</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/dial-numbers.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Feature comparison table</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-saas-trend.html">
              <img src="templates/leap/assets/img/demos/home-saas-trend.png" alt="SaaS Application (Trend)" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-saas-trend.html" class="fade-up">
                  <h3 class="h2">SaaS Application (Trend)</h3>
                </a>
                <p class="lead">
                  An alternative layout with trend inspired sketch graphics
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/add-user.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Signup form</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/text/menu.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Collapsable accordion</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/rss.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Blog listing cards</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-event.html">
              <img src="templates/leap/assets/img/demos/home-event.png" alt="Event &amp; Meetup" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-event.html" class="fade-up">
                  <h3 class="h2">Event &amp; Meetup</h3>
                </a>
                <p class="lead">
                  Conference and event layout with even-specific functionality.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/communication/clipboard-list.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Tabbed schedule</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/home/picture.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Fullscreen lightbox gallery</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/shopping/ticket.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Unique pricing option</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-cryptocurrency.html">
              <img src="templates/leap/assets/img/demos/home-cryptocurrency.png" alt="Cryptocurrency" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-cryptocurrency.html" class="fade-up">
                  <h3 class="h2">Cryptocurrency</h3>
                </a>
                <p class="lead">
                  A home for your ICO or other emerging blockchain enterprises.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/code/time-schedule.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Date countdown</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/code/commit.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Roadmap timeline</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/media/movie-lane-2.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Fullscreen video lightbox</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-desktop-app.html">
              <img src="templates/leap/assets/img/demos/home-desktop-app.png" alt="Desktop Application" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-desktop-app.html" class="fade-up">
                  <h3 class="h2">Desktop Application</h3>
                </a>
                <p class="lead">
                  Attract and immerse users in your stand-alone desktop or web application.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/cooking/dish.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Image with hotspot</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/shopping/box-3.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Dual license pricing</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/media/movie-lane-2.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Fullscreen video lightbox</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-software-library.html">
              <img src="templates/leap/assets/img/demos/home-software-library.png" alt="Software Library" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-software-library.html" class="fade-up">
                  <h3 class="h2">Software Library</h3>
                </a>
                <p class="lead">
                  Get traction on your project with a dedicated landing page.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/text/text-width.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Typed text effect</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/media/movie-lane-2.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Fullscreen video lightbox</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/shopping/calculator.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Stat counter</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row" data-aos="fade-up">
          <div class="col-md-6">
            <a class="fade-page" href="home-portfolio.html">
              <img src="templates/leap/assets/img/demos/home-portfolio.png" alt="Portfolio" class="rounded shadow-3d hover-shadow-3d border mb-3 mb-md-0">
            </a>
          </div>
          <div class="col">
            <div class="row justify-content-center">
              <div class="col-xl-9 col-lg-10">
                <a href="home-portfolio.html" class="fade-up">
                  <h3 class="h2">Portfolio</h3>
                </a>
                <p class="lead">
                  Sell yourself with this bold layout for digital creatives.
                </p>
                <ul class="list-unstyled my-3">
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/layout/layout-arrange.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Masonry portfolio gallery</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/text/edit-text.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Jumbo personal intro</span>
                  </li>
                  <li class="d-flex align-items-center my-2">
                    <img class="icon icon-lg" src="templates/leap/assets/img/icons/theme/text/itallic.svg" alt="icon" data-inject-svg />
                    <span class="h6 mb-0 ml-2">Distraction-free layout</span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="bg-primary-alt">
      <div class="container">
        <div class="row justify-content-center text-center mb-6">
          <div class="col-xl-8 col-lg-9">
            <h2 class="display-4 mx-xl-6">Your site needs more than a landing page</h2>
            <p class="lead">
              Tired of incomplete templates? Leap includes a full suite of detailed inner pages to establish a complete online presence.
            </p>
          </div>
        </div>
      </div>
      <div class="arrows-inside highlight-selected mb-6" data-flickity='{ "autoPlay": true, "imagesLoaded": true, "wrapAround": true }'>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="about-company.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/about-company.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="blog-article.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/blog-article.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="blog-magazine.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/blog-magazine.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="careers.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/careers.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="portfolio-case-study.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/case-study.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="customer-story.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/customer-story.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="knowledgebase.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/knowledgebase.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="pricing-slider.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/pricing-slider.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
        <div class="carousel-cell col-lg-4 col-md-5 col-9 px-2 py-3">
          <a href="account-sign-up-image.html" target="_blank">
            <img src="templates/leap/assets/img/demos/inner-pages/sign-up-image.png" alt="" class="rounded shadow-3d hover-shadow-3d border">
          </a>
        </div>
      </div>
    </section>
    <section class="pt-0 bg-primary-alt o-hidden">
      <div class="container">
        <div class="row justify-content-around align-items-center">
          <div class="col-lg-auto col-md-6 mb-4 mb-md-0">
            <div class="decoration position-relative">
              <img class="bg-primary" src="templates/leap/assets/img/decorations/deco-blob-1.svg" alt="deco-blob-1 decoration" data-inject-svg />
            </div>
            <div class="decoration top middle-x layer-1" data-jarallax-element="20 20">
              <img class="bg-primary-2" src="templates/leap/assets/img/decorations/deco-lines-3.svg" alt="deco-lines-3 decoration" data-inject-svg />
            </div>
            <div class="decoration bottom left layer-2" data-jarallax-element="-20 -20">
              <img class="bg-primary-3" src="templates/leap/assets/img/decorations/deco-dots-1.svg" alt="deco-dots-1 decoration" data-inject-svg />
            </div>
            <div class="decoration bottom right layer-2" data-jarallax-element="-20 0">
              <img class="bg-white" src="templates/leap/assets/img/decorations/deco-lines-2.svg" alt="deco-lines-2 decoration" data-inject-svg />
            </div>
          </div>
          <div class="col-xl-5 col-md-6">
            <h3 class="h1">Stand out with unique visual appeal</h3>
            <p class="lead">
              Leap includes a stylish library of SVG decorations. Easily arrange your own unique collages and position them with intuitive CSS classes.
            </p>
            <a href="elements-decorations.html" class="lead hover-arrow fade-page">Explore SVG Deocrations</a>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0 bg-primary-alt has-divider">
      <div class="container">
        <div class="row justify-content-around align-items-center">
          <div class="col-xl-5 col-md-6 mb-4 mb-md-0">
            <h3 class="h1">Colour schemes made easy</h3>
            <p class="lead">
              Rock one of Leap's carefully curated colour schemes or roll your own using the clearly defined Sass variables.
            </p>
            <div class="rounded bg-white border p-3 text-monospace shadow-sm layer-2 mt-3">
              <div>
                <span>$primary-1:</span>
                <span class="text-primary">#375ABB;</span>
              </div>
              <div>
                <span>$primary-2:</span>
                <span class="text-primary-2">#FB8F8A;</span>
              </div>
              <div>
                <span>$primary-3:</span>
                <span data-typed-text data-type-speed="80" data-strings='["#1B1F3B;"]' data-loop="true" data-back-delay="2000" class="text-primary-3"></span>
              </div>
            </div>
          </div>
          <div class="col-md-6 mb-4 mb-md-0">
            <div class="row no-gutters rounded o-hidden border mb-3 shadow-sm">
              <div class="col p-4 bg-primary"></div>
              <div class="col p-4 bg-primary-alt"></div>
              <div class="col-auto px-4 py-3 bg-white">
                <div class="h6 mb-0">Primary 1</div>
                <span class="font-weight-bold text-muted">#375ABB</span>
              </div>
            </div>
            <div class="row no-gutters rounded o-hidden border mb-3 shadow-sm">
              <div class="col p-4 bg-primary-2"></div>
              <div class="col p-4 bg-primary-2-alt"></div>
              <div class="col-auto px-4 py-3 bg-white">
                <div class="h6 mb-0">Primary 2</div>
                <span class="font-weight-bold text-muted">#FB8F8A</span>
              </div>
            </div>
            <div class="row no-gutters rounded o-hidden border shadow-sm">
              <div class="col p-4 bg-primary-3"></div>
              <div class="col p-4 bg-primary-3-alt"></div>
              <div class="col-auto px-4 py-3 bg-white">
                <div class="h6 mb-0">Primary 3</div>
                <span class="font-weight-bold text-muted">#1B1F3B</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="divider">
        <img src="templates/leap/assets/img/dividers/divider-2.svg" alt="graphical divider" data-inject-svg />
      </div>
    </section>
    <section class="has-divider">
      <div class="container">
        <div class="row justify-content-center text-center mb-6">
          <div class="col-xl-8 col-lg-9">
            <h2 class="display-4 mx-xl-6">Less work, more flow.</h2>
            <p class="lead">
              Boost productivity with BrowserSync. SCSS changes are reflected instantly and pages scroll and refresh on devices as you work.
            </p>
          </div>
        </div>
        <div class="row justify-content-center mb-6">
          <div class="col-xl-5 col-md-8">
            <div class="position-relative">
              <div class="rounded bg-primary-3 p-4 text-light text-monospace mb-2 layer-2">
                <div class="mb-3">
                  <div>&gt; $ npm install</div>
                  <div class="text-primary-2">Everything’s installed!</div>
                </div>
                <div class="mb-3">
                  <div>&gt; $ gulp</div>
                  <div class="text-primary-2">SCSS watching</div>
                  <div class="text-primary-2">LiveReload started</div>
                  <div class="text-primary-2">Opening localhost:3000</div>
                </div>
                <div>
                  <div>&gt; $ that's it?</div>
                  <div class="text-primary-2">Yep, that's it.</div>
                </div>
              </div>
            </div>
            <div class="alert alert-primary position-relative layer-3">&#x1F631; Look unfamiliar? Don’t worry! Our <a href="documentation/index.html">comprehensive
            documentation</a> has got you covered.</div>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <ul class="d-flex flex-wrap justify-content-center list-unstyled">
              <li class="mx-2 mx-lg-4 mb-5 mb-md-0" data-aos="fade-up" data-aos-delay="100">
                <img class="icon bg-primary-3 icon-lg opacity-20" src="templates/leap/assets/img/logos/developer/bootstrap.svg" alt="bootstrap brand logo large icon" data-inject-svg />
              </li>
              <li class="mx-2 mx-lg-4 mb-5 mb-md-0" data-aos="fade-up" data-aos-delay="200">
                <img class="icon bg-primary-3 icon-lg opacity-20" src="templates/leap/assets/img/logos/developer/sass.svg" alt="sass brand logo large icon" data-inject-svg />
              </li>
              <li class="mx-2 mx-lg-4 mb-5 mb-md-0" data-aos="fade-up" data-aos-delay="300">
                <img class="icon bg-primary-3 icon-lg opacity-20" src="templates/leap/assets/img/logos/developer/gulp.svg" alt="gulp brand logo large icon" data-inject-svg />
              </li>
              <li class="mx-2 mx-lg-4 mb-5 mb-md-0" data-aos="fade-up" data-aos-delay="400">
                <img class="icon bg-primary-3 icon-lg opacity-20" src="templates/leap/assets/img/logos/developer/browsersync.svg" alt="browsersync brand logo large icon" data-inject-svg />
              </li>
              <li class="mx-2 mx-lg-4 mb-5 mb-md-0" data-aos="fade-up" data-aos-delay="500">
                <img class="icon bg-primary-3 icon-lg opacity-20" src="templates/leap/assets/img/logos/developer/npm.svg" alt="npm brand logo large icon" data-inject-svg />
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="divider">
        <img class="bg-primary" src="templates/leap/assets/img/dividers/divider-2.svg" alt="divider graphic" data-inject-svg />
      </div>
    </section>
    <section class="bg-primary">
      <div class="container">
        <div class="row text-light mb-4">
          <div class="col">
            <h3 class="h1">Premium Plugins</h3>
          </div>
        </div>
        <div class="row">

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="100">
            <a href="elements-flickity.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/layout/layout-3d.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Flickity</h5>
                <span>Responsive Content Slider</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
            <a href="elements-fancybox.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/general/expand-arrows.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Fancybox</h5>
                <span>Responsive, Fullscreen Gallery</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
            <a href="elements-isotope.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/layout/layout-arrange.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Isotope</h5>
                <span>Fitted masonry layouts</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="400">
            <a href="elements-video-backgrounds.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/media/movie-lane-2.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Video Backgrounds</h5>
                <span>Youtube, Vimeo and Local</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="500">
            <a href="elements-parallax.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/general/duplicate.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Parallax</h5>
                <span>Backgrounds or any element</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="600">
            <a href="elements-animations.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/general/thunder-move.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Scroll Animations</h5>
                <span>Create dynamic pages</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="700">
            <a href="elements-typed-text.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/text/text-width.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Typed Text</h5>
                <span>Simulated typing effect</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="800">
            <a href="elements-countdown.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/theme/code/time-schedule.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Countdowns</h5>
                <span>Count to a specified date</span>
              </div>
            </a>
          </div>

          <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="900">
            <a href="elements-twitter.html" class="card card-sm card-body flex-row align-items-center fade-page hover-shadow-3d">
              <img class="icon icon-lg
        bg-primary-2" src="templates/leap/assets/img/icons/social/twitter.svg" alt="icon" data-inject-svg />
              <div class="ml-3">
                <h5 class="mb-0">Twitter Feeds</h5>
                <span>Dynamic news feeds</span>
              </div>
            </a>
          </div>

        </div>
      </div>
    </section>
    <section class="pt-0 bg-primary text-light">
      <div class="container">
        <div class="row text-light mb-4">
          <div class="col">
            <h3 class="h1">Notable Features</h3>
          </div>
        </div>
        <div class="row">

          <div class="col-sm-6 col-lg-4 d-flex mb-4" data-aos="fade-up" data-aos-delay="100">
            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/devices/iphone-x.svg" alt="icon" data-inject-svg />
            <div class="ml-3">
              <h5>Fully Responsive Design</h5>
              <div>
                Based on the mobile-first Bootstrap framework, Leap scales to fit each device responsively.
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-4 d-flex mb-4" data-aos="fade-up" data-aos-delay="200">
            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/general/fire.svg" alt="icon" data-inject-svg />
            <div class="ml-3">
              <h5>600+ Premium Icons</h5>
              <div>
                Choose from a well organised library of lightweight SVG icons that seamlessly adapt to your sites color scheme.
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-4 d-flex mb-4" data-aos="fade-up" data-aos-delay="300">
            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/communication/readed-mail.svg" alt="icon" data-inject-svg />
            <div class="ml-3">
              <h5>Working Mail Forms</h5>
              <div>
                Contact and subscribe forms work out of the box. Validation, AJAX, reCAPTCHA v2 and Email Handling are all taken care of.
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-4 d-flex mb-4" data-aos="fade-up" data-aos-delay="400">
            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/files/pictures-1.svg" alt="icon" data-inject-svg />
            <div class="ml-3">
              <h5>All Images Included</h5>
              <div>
                Photography and Illustration SVGs are included in the download package and are free to use.
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-4 d-flex mb-4" data-aos="fade-up" data-aos-delay="500">
            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/map/marker-1.svg" alt="icon" data-inject-svg />
            <div class="ml-3">
              <h5>Google Maps API</h5>
              <div>
                Set custom style, multiple markers and rich tooltip content easily through simple HTML and data attributes.
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-4 d-flex mb-4" data-aos="fade-up" data-aos-delay="600">
            <img class="icon icon-md" src="templates/leap/assets/img/icons/theme/communication/group-chat.svg" alt="icon" data-inject-svg />
            <div class="ml-3">
              <h5>6 Months Support</h5>
              <div>
                Buy with confidence. Our team offers timely and personal support via a dedicated support channel.
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>
    <section>
      <div class="container">
        <div class="row mb-5 justify-content-center">
          <div class="col-xl-8 col-lg-9 text-center">
            <h2 class="display-4 mx-xl-6">Customers love Medium Rare</h2>
            <p class="lead">
              Here's what some of our 40,000 satisfied customers have to say about working with Medium Rare themes.
            </p>
          </div>
        </div>
        <div class="row" data-isotope-collection data-ignore-hash="true">
          <div class="col-sm-6 col-lg-4" data-isotope-item>
            <div class="card card-body">
              <div class="flex-grow-1 mb-3">
                <p class="lead">
                  &ldquo;This is a superb product with very
                  <span class="highlight">nice designs and clean code.</span>
                  Using it is a breeze. 5-star product. Also, there's updates.&rdquo;
                </p>
              </div>
              <div class="avatar-author align-items-center">
                <img src="templates/leap/assets/img/avatars/envato.svg" alt="Avatar" class="avatar">
                <div class="ml-2">
                  <h6>agneesh</h6>
                  <span>Themeforest Customer</span>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4" data-isotope-item>
            <div class="card card-body">
              <div class="flex-grow-1 mb-3">
                <p class="lead">
                  &ldquo;It’s well designed, easy to use and
                  <span class="highlight">very flexible without being bloated.</span>
                  Great value for money.&rdquo;
                </p>
              </div>
              <div class="avatar-author align-items-center">
                <img src="templates/leap/assets/img/avatars/bootstrap.svg" alt="Avatar" class="avatar">
                <div class="ml-2">
                  <h6>Paul</h6>
                  <span>Bootstrap Customer</span>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4" data-isotope-item>
            <div class="card card-body">
              <div class="flex-grow-1 mb-3">
                <p class="lead">
                  Very versatile. Seems like
                  <span class="highlight">you can build most of the stuff out of the box.</span>Very thoughtful; team must be very experienced in customer stories and their pain points.
                </p>
              </div>
              <div class="avatar-author align-items-center">
                <img src="templates/leap/assets/img/avatars/bootstrap.svg" alt="Avatar" class="avatar">
                <div class="ml-2">
                  <h6>rajasekhar reddy</h6>
                  <span>Bootstrap Customer</span>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4" data-isotope-item>
            <div class="card card-body">
              <div class="flex-grow-1 mb-3">
                <p class="lead">
                  &ldquo;The
                  <span class='highlight'>code is very well organized.</span>And as a front-end developer, for me it's essential&rdquo;
                </p>
              </div>
              <div class="avatar-author align-items-center">
                <img src="templates/leap/assets/img/avatars/envato.svg" alt="Avatar" class="avatar">
                <div class="ml-2">
                  <h6>theus</h6>
                  <span>Themeforest Customer</span>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4" data-isotope-item>
            <div class="card card-body">
              <div class="flex-grow-1 mb-3">
                <p class="lead">
                  &ldquo;I like the plethora of interchangeable blocks and individual elements. This is a great and flexible bundle. And for the price, totally worth it. Also a
                  <span class="highlight">big shoutout to Craig and James for their quick and helpful support.</span>&rdquo;
                </p>
              </div>
              <div class="avatar-author align-items-center">
                <img src="templates/leap/assets/img/avatars/envato.svg" alt="Avatar" class="avatar">
                <div class="ml-2">
                  <h6>garyhorsman</h6>
                  <span>Themeforest Customer</span>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4" data-isotope-item>
            <div class="card card-body">
              <div class="flex-grow-1 mb-3">
                <p class="lead">
                  &ldquo;It's
                  <span class="highlight">the best theme I've ever purchased.</span>Excellent and easy code, excellent design.&rdquo;
                </p>
              </div>
              <div class="avatar-author align-items-center">
                <img src="templates/leap/assets/img/avatars/envato.svg" alt="Avatar" class="avatar">
                <div class="ml-2">
                  <h6>felipelobo328</h6>
                  <span>Themeforest Customer</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="pt-0">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-xl-8 col-lg-9">
            <h3 class="h2">Frequently Asked Questions</h3>
            <div class="my-4">
              <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="NaN">
                <div data-target="#panel-1" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-1">
                  <span class="h6 mb-0">Can I just use the static HTML files?</span>
                  <img class="icon" src="templates/leap/assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
                </div>
                <div class="collapse" id="panel-1">
                  <div class="pt-3">
                    <p>Yes. The gulp workflow can be bypassed all together if you prefer to simply edit the static HTML and CSS files.</p>

                  </div>
                </div>
              </div>
              <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="NaN">
                <div data-target="#panel-2" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-2">
                  <span class="h6 mb-0">Are the images included in the download package?</span>
                  <img class="icon" src="templates/leap/assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
                </div>
                <div class="collapse" id="panel-2">
                  <div class="pt-3">
                    <p>Yes. All images you see in the demo files are included for your use in the download package.</p>

                  </div>
                </div>
              </div>
              <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="NaN">
                <div data-target="#panel-3" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-3">
                  <span class="h6 mb-0">Can Leap be used as a 'one page' template?</span>
                  <img class="icon" src="templates/leap/assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
                </div>
                <div class="collapse" id="panel-3">
                  <div class="pt-3">
                    <p>Yes. Leap includes the smooth scroll plugin which is perfect for single page websites.</p>

                  </div>
                </div>
              </div>
              <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="NaN">
                <div data-target="#panel-4" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-4">
                  <span class="h6 mb-0">How can I request support?</span>
                  <img class="icon" src="templates/leap/assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
                </div>
                <div class="collapse" id="panel-4">
                  <div class="pt-3">
                    <p>You can request personal support via our dedicated support system on <a href="http://mediumrare.ticksy.com">Ticksy</a>
                    </p>

                  </div>
                </div>
              </div>
              <div class="card mb-2 card-sm card-body hover-shadow-sm" data-aos="fade-up" data-aos-delay="NaN">
                <div data-target="#panel-5" class="accordion-panel-title" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="panel-5">
                  <span class="h6 mb-0">Is this a WordPress theme?</span>
                  <img class="icon" src="templates/leap/assets/img/icons/interface/plus.svg" alt="plus interface icon" data-inject-svg />
                </div>
                <div class="collapse" id="panel-5">
                  <div class="pt-3">
                    <p>No. This is a HTML template. A WordPress version is coming soon, <a href="">Subscribe Here</a> to recieve a notification when it is available.</p>

                  </div>
                </div>
              </div>
            </div>
            <span>Still have questions? <a href="#" class="hover-arrow" data-toggle="modal" data-target="#ask-modal">Get in
            touch</a>
            </span>
            <div class="modal fade" id="ask-modal" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                  <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <img class="icon bg-dark" src="templates/leap/assets/img/icons/interface/cross.svg" alt="cross interface icon" data-inject-svg />
                    </button>
                    <div class="m-3">
                      <ul class="avatars justify-content-center">
                        <li>
                          <img src="templates/leap/assets/img/avatars/team-1.jpg" alt="Avatar" class="avatar avatar-lg">
                        </li>
                        <li>
                          <img src="templates/leap/assets/img/avatars/team-2.jpg" alt="Avatar" class="avatar avatar-lg">
                        </li>
                        <li>
                          <img src="templates/leap/assets/img/avatars/team-3.jpg" alt="Avatar" class="avatar avatar-lg">
                        </li>
                      </ul>
                      <div class="text-center my-3">
                        <h4 class="h3 mb-1">Pre-sales Questions</h4>
                        <p>
                          Please get in touch for any questions you may have. We typically reply within 24 hours.
                        </p>
                      </div>
                      <form action="https://mailform.mediumra.re/leap/smtp.php" data-form-email novalidate>
                        <div class="form-group">
                          <input type="text" class="form-control" name="contact-name" placeholder="Your Name" required>
                        </div>
                        <div class="form-group">
                          <input type="email" class="form-control" name="contact-email" placeholder="Email Address" required>
                        </div>
                        <div class="form-group">
                          <textarea name="contact-box-message" rows="5" class="form-control" placeholder="Type your message here" required></textarea>
                        </div>
                        <div data-recaptcha data-sitekey="6Lfmz4gUAAAAAEau9IKfGA7leOKYAiRhv-3WA3gq"></div>
                        <div class="d-none alert alert-danger" role="alert" data-error-message>
                          Please fill all fields correctly.
                        </div>
                        <div class="d-none alert alert-success" role="alert" data-success-message>
                          Thanks, a member of our team will be in touch shortly.
                        </div>
                        <button type="submit" class="btn btn-block btn-primary btn-loading" data-loading-text="Sending">
                          <img class="icon" src="templates/leap/assets/img/icons/theme/code/loading.svg" alt="loading icon" data-inject-svg />
                          <span>Send</span>
                        </button>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <footer class="pb-4 bg-primary-3 text-light" id="footer">
      <div class="container">
        <div class="row mb-5">
          <div class="col">
            <div class="card card-body border-0 o-hidden mb-0 bg-primary text-light">
              <div class="position-relative d-flex flex-column flex-md-row justify-content-between align-items-center">
                <div class="h3 text-center mb-md-0">Start building beautiful websites</div>
                <a href="https://themes.getbootstrap.com/product/leap-multipurpose-bootstrap-theme/" class="btn btn-lg btn-white">
      Purchase Now
    </a>
              </div>
              <div class="decoration layer-0">
                <img class="bg-primary-2" src="templates/leap/assets/img/decorations/deco-blob-1.svg" alt="deco-blob-1 decoration" data-inject-svg />
              </div>
            </div>

          </div>
        </div>
        <div class="row mb-5">
          <div class="col-6 col-lg-3 col-xl-2">
            <h5>Navigate</h5>
            <ul class="nav flex-column">
              <li class="nav-item">
                <a href="#" class="nav-link">Demos</a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">Pages</a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">Blog</a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">Portfolio</a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">Elements</a>
              </li>
            </ul>
          </div>
          <div class="col-6 col-lg">
            <h5>Contact</h5>
            <ul class="list-unstyled">
              <li class="mb-3 d-flex">
                <img class="icon" src="templates/leap/assets/img/icons/theme/map/marker-1.svg" alt="marker-1 icon" data-inject-svg />
                <div class="ml-3">
                  <span>348 Greenpoint Avenue
                    <br />Brooklyn, NY</span>
                </div>
              </li>
              <li class="mb-3 d-flex">
                <img class="icon" src="templates/leap/assets/img/icons/theme/communication/call-1.svg" alt="call-1 icon" data-inject-svg />
                <div class="ml-3">
                  <span>+61 3928 3324</span>
                  <span class="d-block text-muted text-small">Mon - Fri 9am - 5pm</span>
                </div>
              </li>
              <li class="mb-3 d-flex">
                <img class="icon" src="templates/leap/assets/img/icons/theme/communication/mail.svg" alt="mail icon" data-inject-svg />
                <div class="ml-3">
                  <a href="#">hello@company.io</a>
                </div>
              </li>
            </ul>
          </div>
          <div class="col-lg-5 col-xl-4 mt-3 mt-lg-0">
            <h5>Subscribe</h5>
            <p>The latest Leap news, articles, and resources, sent straight to your inbox every month.</p>
            <form action="https://mailform.mediumra.re/leap/mailchimp.php" data-form-email novalidate>
              <div class="form-row">
                <div class="col-12">
                  <input type="email" class="form-control mb-2" placeholder="Email Address" name="email" required>
                </div>
                <div class="col-12">
                  <div class="d-none alert alert-success" role="alert" data-success-message>
                    Thanks, a member of our team will be in touch shortly.
                  </div>
                  <div class="d-none alert alert-danger" role="alert" data-error-message>
                    Please fill all fields correctly.
                  </div>
                  <div data-recaptcha data-sitekey="6Lemz4gUAAAAAElq4ZHFBzI7j8QUiYMn9I0mzQWG" data-size="invisible" data-badge="bottomleft">
                  </div>
                  <button type="submit" class="btn btn-primary btn-loading btn-block" data-loading-text="Sending">
                    <img class="icon" src="templates/leap/assets/img/icons/theme/code/loading.svg" alt="loading icon" data-inject-svg />
                    <span>Subscribe</span>
                  </button>
                </div>
              </div>
            </form>
            <small class="text-muted form-text">We’ll never share your details. See our <a href="#">Privacy Policy</a>
            </small>

          </div>
        </div>
        <div class="row justify-content-center mb-2">
          <div class="col-auto">
            <ul class="nav">
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <img class="icon undefined" src="templates/leap/assets/img/icons/social/instagram.svg" alt="instagram social icon" data-inject-svg />
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <img class="icon undefined" src="templates/leap/assets/img/icons/social/twitter.svg" alt="twitter social icon" data-inject-svg />
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <img class="icon undefined" src="templates/leap/assets/img/icons/social/youtube.svg" alt="youtube social icon" data-inject-svg />
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <img class="icon undefined" src="templates/leap/assets/img/icons/social/medium.svg" alt="medium social icon" data-inject-svg />
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <img class="icon undefined" src="templates/leap/assets/img/icons/social/facebook.svg" alt="facebook social icon" data-inject-svg />
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div class="row justify-content-center">
          <div class="col col-md-auto text-center">
            <small class="text-muted">&copy;2019 This page is protected by reCAPTCHA and is subject to the Google <a href="https://www.google.com/policies/privacy/">Privacy Policy</a> and <a href="https://policies.google.com/terms">Terms of Service.</a>
            </small>
          </div>
        </div>
      </div>
    </footer>
    <a href="#" class="btn back-to-top btn-primary btn-round" data-smooth-scroll data-aos="fade-up" data-aos-offset="2000" data-aos-mirror="true" data-aos-once="false">
      <img class="icon" src="templates/leap/assets/img/icons/theme/navigation/arrow-up.svg" alt="arrow-up icon" data-inject-svg />
    </a>
    <!-- Required vendor scripts (Do not remove) -->
    <script type="text/javascript" src="templates/leap/assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="templates/leap/assets/js/popper.min.js"></script>
    <script type="text/javascript" src="templates/leap/assets/js/bootstrap.js"></script>

    <!-- 
             This appears in the demo only.  This script ensures our demo countdowns are always showing a date in the future 
             by altering the date before the countdown is initialized 
        -->
    <script type="text/javascript">
      (function($){
            var now             = new Date;
            var day             = 864e5;
            var weeksToAdd      = 2;
            var tenWeeksFromNow = new Date(+now + day * 7 * weeksToAdd).toISOString().slice(0,10).replace(/\-/g, '/');
            $('[data-countdown-date].add-countdown-time').attr('data-countdown-date', tenWeeksFromNow);
          })(jQuery);
    </script>

    <!-- Optional Vendor Scripts (Remove the plugin script here and comment initializer script out of index.js if site does not use that feature) -->

    <!-- AOS (Animate On Scroll - animates elements into view while scrolling down) -->
    <script type="text/javascript" src="templates/leap/assets/js/aos.js"></script>
    <!-- Clipboard (copies content from browser into OS clipboard) -->
    <script type="text/javascript" src="templates/leap/assets/js/clipboard.js"></script>
    <!-- Fancybox (handles image and video lightbox and galleries) -->
    <script type="text/javascript" src="templates/leap/assets/js/jquery.fancybox.min.js"></script>
    <!-- Flatpickr (calendar/date/time picker UI) -->
    <script type="text/javascript" src="templates/leap/assets/js/flatpickr.min.js"></script>
    <!-- Flickity (handles touch enabled carousels and sliders) -->
    <script type="text/javascript" src="templates/leap/assets/js/flickity.pkgd.min.js"></script>
    <!-- Ion rangeSlider (flexible and pretty range slider elements) -->
    <script type="text/javascript" src="templates/leap/assets/js/ion.rangeSlider.min.js"></script>
    <!-- Isotope (masonry layouts and filtering) -->
    <script type="text/javascript" src="templates/leap/assets/js/isotope.pkgd.min.js"></script>
    <!-- jarallax (parallax effect and video backgrounds) -->
    <script type="text/javascript" src="templates/leap/assets/js/jarallax.min.js"></script>
    <script type="text/javascript" src="templates/leap/assets/js/jarallax-video.min.js"></script>
    <script type="text/javascript" src="templates/leap/assets/js/jarallax-element.min.js"></script>
    <!-- jQuery Countdown (displays countdown text to a specified date) -->
    <script type="text/javascript" src="templates/leap/assets/js/jquery.countdown.min.js"></script>
    <!-- jQuery smartWizard facilitates steppable wizard content -->
    <script type="text/javascript" src="templates/leap/assets/js/jquery.smartWizard.min.js"></script>
    <!-- Plyr (unified player for Video, Audio, Vimeo and Youtube) -->
    <script type="text/javascript" src="templates/leap/assets/js/plyr.polyfilled.min.js"></script>
    <!-- Prism (displays formatted code boxes) -->
    <script type="text/javascript" src="templates/leap/assets/js/prism.js"></script>
    <!-- ScrollMonitor (manages events for elements scrolling in and out of view) -->
    <script type="text/javascript" src="templates/leap/assets/js/scrollMonitor.js"></script>
    <!-- Smooth scroll (animation to links in-page)-->
    <script type="text/javascript" src="templates/leap/assets/js/smooth-scroll.polyfills.min.js"></script>
    <!-- SVGInjector (replaces img tags with SVG code to allow easy inclusion of SVGs with the benefit of inheriting colors and styles)-->
    <script type="text/javascript" src="templates/leap/assets/js/svg-injector.umd.production.js"></script>
    <!-- TwitterFetcher (displays a feed of tweets from a specified account)-->
    <script type="text/javascript" src="templates/leap/assets/js/twitterFetcher_min.js"></script>
    <!-- Typed text (animated typing effect)-->
    <script type="text/javascript" src="templates/leap/assets/js/typed.min.js"></script>
    <!-- Required theme scripts (Do not remove) -->
    <script type="text/javascript" src="templates/leap/assets/js/theme.js"></script>

    <script type="text/javascript">
      // This script appears only in the demo - it disables forms with no action attribute to prevent 
      // navigating away from the page.
      jQuery("form:not([action])").on('submit', function(){return false;});
    </script>

  </body>

</html>

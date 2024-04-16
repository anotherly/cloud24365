<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-/\/W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>BizLand Bootstrap Template - Index</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Roboto:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

	<script src="<%=request.getContextPath()%>/js/jquery3.5.1.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/common.js"></script>
  <!-- =======================================================
  * Template Name: BizLand
  * Updated: Jan 29 2024 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/bizland-bootstrap-business-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
<style>
	.carousel-item{
		background-size:cover;
		height:100%;
	}
	
	.carousel-content{
	    padding: 100px;
	    color: #fff;
	    font-weight: bold;
	}
	.benefit-span{
		color: #37517e;
	    transition: ease-in-out 0.3s;	
	}
}
</style>
<script>
	$(document).ready(function() {
		var div1 = document.getElementById('hero1');
		var div2 = document.getElementById('hero2');
		
		$(".carousel-item").css("height","100%");
		
		setInterval(function(){
			    if (div1.style.display === 'none') {
			        div1.style.display = 'block';
			        div2.style.display = 'none';
			    } else {
			        div2.style.display = 'block';
			        div1.style.display = 'none';
			    }
		},5000);
		
		console.log("협력사사진 관리자 페이지");
		$("#partnerList").empty();
		var ajaxData = ajaxMethod("/client/edit/partnerList.ajax").data;
		var divContents="";
		for (var i = 0; i < 5; i++) {
			var fileDir = "/share/resources"+ajaxData[i].file_DIR+ajaxData[i].file_NAME;
			//var fileDir = "assets/img/clients/nhn_logo.png";
			divContents+=
				'<div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">'
					+'<img src="'+fileDir+'" class="img-fluid" alt="">'
				+'</div>'
		}
		$("#partnerList").append(divContents);
		//부모창 주소까지 변경
		$(".derbogi").on("click",function(){
			console.log("더보기 클릭 1");
			window.parent.location.href = $(this).attr('id');
		});
	});
</script>
</head>


<body>

  <!-- ======= Header ======= -->

  <!-- ======= Hero Section ======= -->
  <div id="hero1" style="/* display:none; */">
	  <section id="hero" class="d-flex align-items-center">
	    <div class="container">
	      <div class="row">
	      	<div class="col-lg-6 d-flex flex-column justify-content-center pt-4 pt-lg-0 order-2 order-lg-1" data-aos="fade-up" data-aos-delay="200">
		          <h1>CLOUD 사업</h1>
		          	<p>국내 주요 CSP(Cloud Service Provider) 파트너로서</p>
					<p>IaaS 및 MSP(Managed Service Provider)</p>
					<p>사업에 대한 설계/구축/이관 관련 컨설팅 사업 수행</p>
	      	</div>
	        
	        <div class="col-lg-6 order-1 order-lg-2 hero-img" data-aos="zoom-in" data-aos-delay="200">
	          	<img src="assets/img/hero-img.png" class="img-fluid animated" alt="">
	        </div>
	      </div>
	    </div>
	  </section>  
  </div>

  <div id="hero2" class="masthead-div" style="display:none;">
  		<div class="masthead-bg"></div>
		<div class="masthead" >
            <div class="masthead-content text-white">
                <div class="container-fluid px-4 px-lg-0">
                    <h1 class="fst-italic lh-1 mb-4">CLOUD 사업</h1>
                    <p>국내 주요 CSP(Cloud Service Provider) 파트너로서</p>
					<p>IaaS 및 MSP(Managed Service Provider)</p>
					<p>사업에 대한 설계/구축/이관 관련 컨설팅 사업 수행</p>
                </div>
            </div>
        </div>
  </div>
  <!-- End Hero -->
  
  <!-- ======= Clients Section ======= -->
    <section id="cliens" class="cliens1 section-bg">
      <div class="container">
       <!-- <div class="section-title" style="padding: 0px;" >
          <h2>Partnership</h2>
        </div> -->
        <div class="row" data-aos="zoom-in" style="display: flex;align-items: center;justify-content: space-around;">
          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/amazon_logo.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/Kt_logo.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/naver_logo.png" class="img-fluid" alt="">
          </div>

          <div class="col-lg-2 col-md-4 col-6 d-flex align-items-center justify-content-center">
            <img src="assets/img/clients/nhn_logo.png" class="img-fluid" alt="">
          </div>
        </div>
      </div>
    </section>
    <!-- End Cliens Section -->
  
    <!-- ======= About Us Section ======= -->
    <section id="about" class="about section-bg" style="padding: 20px;">
      <div class="" data-aos="fade-up">
       <!--  <div class="section-title" style="padding: 0px;" >
          <h2>About Us</h2>
        </div>  -->
          <div id="heroCarousel" data-bs-interval="5000" class="carousel slide carousel-fade" data-bs-ride="carousel">
        <ol class="carousel-indicators" id="hero-carousel-indicators"><li data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active" aria-current="true"></li><li data-bs-target="#heroCarousel" data-bs-slide-to="1" class=""></li><li data-bs-target="#heroCarousel" data-bs-slide-to="2" class=""></li></ol>
        <div class="carousel-inner" role="listbox" style="height:60vh;">

          <!-- Slide 1 -->
          <div class="carousel-item active" style="background-image: url(assets/img/slide/msp.png);">
            <div class="carousel-container">
              <div class="carousel-content">
					<h2 class="animate__animated animate__fadeInDown">MSP(Management Service Provider)</h2>
	                <p class="animate__animated animate__fadeInUp">
	                	매니지드 서비스는 기업의 클라우드 인프라와 클라우드 기반의 시스템을 운영 및 관리하는 IT 운영 서비스
	                </p>
	                <p class="animate__animated animate__fadeInUp">
	                	온프레미스 경험만을 보유하였거나 자체 전문 인력이 없는 고객이 겪는 클라우드 운영에 대한 문제를 해결 할 수 있도록, 
	                	<br>클라우드 운영과 관련한 매니지드 서비스를 제공
	                </p>
	                <p class="animate__animated animate__fadeInUp">
	                	컨설팅을 통해 클라우드를 이해하고 시스템 운영을 체계화 할 수 있도록 맞춤형 환경을 제안
	                </p>
	                <p class="animate__animated animate__fadeInUp">
	                	고객에게 최적화된 서비스를 제공하기 위해 기술지원 서비스 제공
	                </p>
	                <p class="animate__animated animate__fadeInUp">
	                	실시간 트래픽/성능 모니터링을 통한 관제 서비스 제공
	                </p>              
                </div>
            </div>
          </div>

          <!-- Slide 2 -->
          <div class="carousel-item" style="background-image: url(assets/img/slide/iaas.png);">
            <div class="carousel-container">
              <div class="carousel-content">
                <h2 class="animate__animated animate__fadeInDown">IaaS(Infrastructure-as-a-service)</h2>
                <p class="animate__animated animate__fadeInUp">
                	인터넷을 통해 최종 사용자에게 IT 인프라를 제공하는 형태의 클라우드 컴퓨팅
                </p>
                <p class="animate__animated animate__fadeInUp">
                	오버헤드 없이 온프레미스 컴퓨팅 리소스의 활용
                </p>
                <p class="animate__animated animate__fadeInUp">
                	IaaS 벤더는 가상화, 스토리지, 네트워크, 서버를 제공
                </p>
                <p class="animate__animated animate__fadeInUp">
                	서버 관리를 설정하는 오버헤드를 없애 개발자 경험을 간소화
                </p>
                <p class="animate__animated animate__fadeInUp">
                	실시간 트래픽/성능 모니터링을 통한 관제 서비스 제공
                </p>
              </div>
            </div>
          </div>

          <!-- Slide 3 -->
          <div class="carousel-item" style="background-image: url(assets/img/slide/dataDR.png);">
            <div class="carousel-container">
              <div class="carousel-content">
                <h2 class="animate__animated animate__fadeInDown">dataDR Service</h2>
                <p class="animate__animated animate__fadeInUp">
                	인터넷을 통해 최종 사용자에게 IT 인프라를 제공하는 형태의 클라우드 컴퓨팅
                </p>
                <p class="animate__animated animate__fadeInUp">
                	오버헤드 없이 온프레미스 컴퓨팅 리소스의 활용
                </p>
                <p class="animate__animated animate__fadeInUp">
                	IaaS 벤더는 가상화, 스토리지, 네트워크, 서버를 제공
                </p>
                <p class="animate__animated animate__fadeInUp">
                	서버 관리를 설정하는 오버헤드를 없애 개발자 경험을 간소화
                </p>
                <p class="animate__animated animate__fadeInUp">
                	실시간 트래픽/성능 모니터링을 통한 관제 서비스 제공
                </p>
              </div>
            </div>
          </div>

        </div>

        <a class="carousel-control-prev" href="#heroCarousel" role="button" data-bs-slide="prev">
          <span class="carousel-control-prev-icon ri-arrow-left-line" aria-hidden="true"></span>
        </a>

        <a class="carousel-control-next" href="#heroCarousel" role="button" data-bs-slide="next">
          <span class="carousel-control-next-icon ri-arrow-right-line" aria-hidden="true"></span>
        </a>
      </div>
      </div>
    </section><!-- End About Us Section -->

  <!-- ======= Clients Section ======= -->
	<section id="cliens" class="cliens1">
		<div class="container" style="max-width: 1800px;">
			<div class="section-title" style="padding: 0px;margin-bottom:30px;" >
				<h2>주요 고객사</h2><a id="/client/svcInfo/company.do" class="derbogi">더보기 > </a>
			</div>
			<div id="partnerList" class="row" data-aos="zoom-in" style="display: flex;align-items: center;justify-content: space-around;">
			</div>
		</div>
	</section>
    <!-- End Cliens Section -->

    <!-- ======= Services Section ======= -->
    <section id="services" class="services section-bg">
      <div class="container" data-aos="fade-up">
        <div class="section-title">
          <h2>Benifits</h2>
          <p>다음과 같은 서비스 이점을 제공합니다</p>
        </div>
        <div class="row" style="display: flex;justify-content: space-around;">
          <div class="col-xl-3 col-md-6 d-flex align-items-stretch" data-aos="zoom-in" data-aos-delay="100">
            <div class="icon-box">
              <div class="icon"><i class="bx bxl-dribbble"></i></div>
              <h4><span class="benefit-span">비용 절감</span></h4>
              <p>인프라 구축 시 기간 단축 및 비용을 획기적으로 절감</p>
            </div>
          </div>

          <div class="col-xl-3 col-md-6 d-flex align-items-stretch mt-4 mt-md-0" data-aos="zoom-in" data-aos-delay="200">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-file"></i></div>
              <h4><span class="benefit-span">안정성</span></h4>
              <p>신속하고 탄력적인 인프라를 기반으로 뛰어난 안정성 제공</p>
            </div>
          </div>

          <div class="col-xl-3 col-md-6 d-flex align-items-stretch mt-4 mt-xl-0" data-aos="zoom-in" data-aos-delay="300">
            <div class="icon-box">
              <div class="icon"><i class="bx bx-tachometer"></i></div>
              <h4><span class="benefit-span">마이그레이션</span></a></h4>
              <p>시나리오 기반으로 한 시스템 이관</p>
              <p>사전모의 테스트 / 성능평가 진행</p>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Services Section -->

    <!-- ======= Team Section ======= -->
    <!-- End Team Section -->

    <!-- ======= Pricing Section ======= -->
    <section id="pricing" class="pricing">
      <div class="container" data-aos="fade-up">

        <div class="section-title">
          <h2>Pricing</h2>
          <p>서비스 이용금액 기준/ VM당 가격 책정</p>
        </div>

        <div class="row">

          <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
            <div class="box">
              <h3>LITE 요금제</h3>
              <h4><sup>\</sup>150,000<span>per month</span></h4>
              <ul>
                <li><i class="bx bx-check"></i> 서비스 1 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 2 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 3 지원 (변경요망)</li>
                <li class="na"><i class="bx bx-x"></i> <span>서비스 4 지원 (변경요망)</span></li>
                <li class="na"><i class="bx bx-x"></i> <span>서비스 5 지원 (변경요망)</span></li>
              </ul>
            </div>
          </div>

          <div class="col-lg-4 mt-4 mt-lg-0" data-aos="fade-up" data-aos-delay="200">
            <div class="box featured">
              <h3>STANDARD 요금제</h3>
              <h4><sup>\</sup>250,000<span>per month</span></h4>
              <ul>
                <li><i class="bx bx-check"></i> 서비스 1 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 2 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 3 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 4 지원 (변경요망)</li>
                <li class="na"><i class="bx bx-x"></i> 서비스 5 지원 (변경요망)</li>
              </ul>
            </div>
          </div>

          <div class="col-lg-4 mt-4 mt-lg-0" data-aos="fade-up" data-aos-delay="300">
            <div class="box">
              <h3>PREMIUM 요금제</h3>
              <h4><sup>\</sup>350,000<span>per month</span></h4>
              <ul>
                <li><i class="bx bx-check"></i> 서비스 1 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 2 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 3 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 4 지원 (변경요망)</li>
                <li><i class="bx bx-check"></i> 서비스 5 지원 (변경요망)</li>
              </ul>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Pricing Section -->

  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/waypoints/noframework.waypoints.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>


</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
     <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DCODLAB</title>
    <link rel="icon" href="homepage_home_house_icon_225739.ico" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Additional CSS for enhanced design */
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        header {
            background-color: #fff;
            padding: 20px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        header .inner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
        }
        #gnb, .util {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        #gnb li, .util li {
            display: inline-block;
            margin-left: 20px;
        }
        #gnb li a, .util li a {
            text-decoration: none;
            color: #333;
            font-weight: 700;
            transition: color 0.3s ease;
        }
        #gnb li a:hover, .util li a:hover {
            color: #007bff;
        }
        figure {
            position: relative;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        figure video {
            width: 100%;
            height: auto;
            object-fit: cover;
        }
        figure .inner {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #fff;
            z-index: 1;
        }
        figure h1 {
            margin: 0 0 10px;
            font-size: 36px;
            font-weight: 700;
        }
        figure p {
            margin: 0;
            font-size: 16px;
            line-height: 1.5;
        }
        section {
            padding: 60px 0;
            background-color: #fff;
        }
        section .inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        section h1 {
            margin: 0 0 40px;
            font-size: 36px;
            font-weight: 700;
            text-align: center;
        }
        .wrap {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        article {
            flex: 0 0 calc(50% - 20px);
            margin-bottom: 40px;
            background-color: #f5f5f5;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        article:hover {
            transform: translateY(-5px);
        }
        .pic img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }
        .pic {
            position: relative;
            overflow: hidden;
            height: 200px;
        }
        .pic:before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.3);
            z-index: 2;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .pic:hover:before {
            opacity: 1;
        }
        .pic h2 {
            position: absolute;
            bottom: 20px;
            left: 20px;
            margin: 0;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
            z-index: 3;
        }
        .pic p {
            position: absolute;
            bottom: 0;
            left: 20px;
            margin: 0;
            padding: 10px 0;
            color: #fff;
            font-size: 14px;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 3;
            transition: background-color 0.3s ease;
        }
        .pic:hover p {
            background-color: rgba(0, 0, 0, 0.7);
        }
        footer {
            padding: 60px 0;
            background-color: #333;
            color: #fff;
        }
        footer .inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        footer h1 {
            margin: 0 0 20px;
            font-size: 24px;
            font-weight: 700;
        }
        footer ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        footer ul li {
            margin-bottom: 10px;
        }
        footer ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
        }
        address {
            margin-bottom: 20px;
            font-style: normal;
        }
        footer p {
            margin: 0;
            font-size: 14px;
            line-height: 1.5;
        }
    </style>
    <script src="js/ie.js"></script>
    <script>
    function toggleLoginButton() {
        var loginButton = document.getElementById('loginButton');
        var joinButton = document.getElementById('joinButton');
        
        <% if (session.getAttribute("MEMBERID") != null && !session.getAttribute("MEMBERID").equals("")) { %>
            // 세션에 사용자 정보가 있는 경우
            // 로그아웃으로 버튼 텍스트 변경 및 링크 수정
            loginButton.innerHTML = '로그아웃';
            loginButton.onclick = logout; // onclick 속성에 logout 함수 할당
            joinButton.style.display = 'none'; // join 버튼 숨기기
        <% } else { %>
            // 세션에 사용자 정보가 없는 경우
            // 로그인으로 버튼 텍스트 변경 및 링크 수정
            loginButton.innerHTML = '로그인';
            loginButton.href = 'sessionLoginForm.jsp'; // 로그인 페이지로 이동
        <% } %>
    }

    // 페이지 로드 시 toggleLoginButton 함수 호출하여 초기 버튼 설정
    window.onload = toggleLoginButton;

    function logout() {
        // 서버에 로그아웃 요청을 보내는 코드
        // 여기서는 세션 정보를 삭제하는 방식으로 구현
        fetch('sessionLogout.jsp') 
            .then(response => {
                if (response.ok) {
                    // 성공적으로 로그아웃되면 페이지를 새로고침
                   window.location.reload();
                } else {
                    console.error('로그아웃 실패');
                }
            })
            .catch(error => console.error('오류 발생:', error));
    }
</script>

</head>

<body>

    <header>
        <div class="inner">
            <h1><a href="index.jsp">DCODLAB</a></h1>

            <ul id="gnb">
                <li><a href="blist.jsp">게시판</a></li>
            </ul>

            <ul class="util">
              
                <li><a id="loginButton" href="javascript:logout();">로그인</a></li>
                <li><a id="joinButton" href="memberForm.jsp">회원가입</a></li>
                <li><a href="list.jsp">회원 정보</a></li>
            </ul>
        </div>
    </header>



    <figure>
        <video src="img/visual.mp4" autoplay muted loop></video>
        <div class="inner">
            <h1>INNOVATION</h1>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. <br>
                Id praesentium molestias similique quaerat magni facere in a? Adipisci, possimus reprehenderit!</p>
            <a href="#">view detail</a>
        </div>
    </figure>

    <section>
        <div class="inner">
            <h1>RECENT NEWS</h1>
            <div class="wrap">
                <article>
                    <div class="pic">
                        <img src="img/news1.jpg" alt="1번째 콘텐츠 이미지">
                    </div>
                    <h2><a href="#">Lorem ipsum dolor sit.</a></h2>
                    <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Vitae minus, eaque corrupti vero ad
                        maiores!</p>
                </article>

                <article>
                    <div class="pic">
                        <img src="img/news2.jpg" alt="2번째 콘텐츠 이미지">
                    </div>
                    <h2><a href="#">Lorem ipsum dolor sit.</a></h2>
                    <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Vitae minus, eaque corrupti vero ad
                        maiores!</p>
                </article>

                <article>
                    <div class="pic">
                        <img src="img/news3.jpg" alt="3번째 콘텐츠 이미지">
                    </div>
                    <h2><a href="#">Lorem ipsum dolor sit.</a></h2>
                    <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Vitae minus, eaque corrupti vero ad
                        maiores!</p>
                </article>

                <article>
                    <div class="pic">
                        <img src="img/news4.jpg" alt="4번째 콘텐츠 이미지">
                    </div>
                    <h2><a href="#">Lorem ipsum dolor sit.</a></h2>
                    <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Vitae minus, eaque corrupti vero ad
                        maiores!</p>
                </article>
            </div>
        </div>
    </section>

    <footer>
        <div class="inner">
            <div class="upper">
                <h1>DCODELAB</h1>
                <ul>
                    <li><a href="#">Policy</a></li>
                    <li><a href="#">Terms</a></li>
                    <li><a href="#">Family Site</a></li>
                    <li><a href="#">Sitemap</a></li>
                </ul>
            </div>

            <div class="lower">
                <address>
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas, facere.<br>
                    TEL : 031-111-1234 C.P : 010-1234-5678
                </address>
                <p>
                    2020 DOCDELAB &copy; copyright all right reserved.
                </p>
            </div>
        </div>
    </footer>

</body>
</html>

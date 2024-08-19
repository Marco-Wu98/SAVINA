<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/user/login.css">
    <script src="static/css/user/login.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link rel="stylesheet" href="static/css/bootstrap/bootstrap.css">
</head>

<body>
<div class="main">
    <form action="">
        <div class="form-header">
            <h1 class="form-title__1">SAVINA</h1>
            <!-- <h3 class="form-title__2">Tạo tài khoản cho riêng mình nào</h3> -->
        </div>

        <div class="form-body">
            <div class="form-item">
                <input type="text" name="username" id="username" placeholder="Tên đăng nhập" autocomplete="off">
            </div>
            <div class="form-item">
                <input type="password" name="password" id="password" placeholder="Mật khẩu" autocomplete="off">
                <label for="chk" id="close-icon"><i class="fa-regular fa-eye-slash"></i></label>
                <label for="chk" class="d-none" id="open-icon"><i class="fa-regular fa-eye"></i></label>
                <input type="checkbox" id="chk" class="d-none">
            </div>
            <div class="form-item">
                <input type="submit" value="Đăng nhập"/>
            </div>
        </div>

        <div class="form-footer">
            <div><a href="templates/user/regist.html">Đăng ký</a></div>
        </div>
    </form>
</div>


<!--BOOTSTRAP -->
<script src="static/js/bootstrap/bootstrap.bundle.js"></script>
    </body>

    </html>
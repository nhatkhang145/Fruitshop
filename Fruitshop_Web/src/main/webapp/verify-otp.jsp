<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:choose>
        <c:when test="${sessionScope.otpType == 'register'}">
            <title>Xác thực OTP - Đăng ký</title>
        </c:when>
        <c:when test="${sessionScope.otpType == 'forgot-password'}">
            <title>Xác thực OTP - Quên mật khẩu</title>
        </c:when>
        <c:otherwise>
            <title>Xác thực OTP</title>
        </c:otherwise>
    </c:choose>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --primary-color: #3d8b91;
            --primary-brand-color: #2fb45a;
            --secondary-brand-color: #ff6b6b;
            --white-color: #fff;
            --text-dark: #333;
            --text-light: #666;
            --bg-light: #f9f9f9;
            --border-color: #ddd;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-brand-color) 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .otp-container {
            background: var(--white-color);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 50px 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .otp-icon {
            font-size: 80px;
            color: var(--primary-brand-color);
            margin-bottom: 20px;
            animation: bounce 1s ease-in-out;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        h2 {
            color: var(--text-dark);
            margin-bottom: 10px;
            font-size: 28px;
        }

        .subtitle {
            color: var(--text-light);
            margin-bottom: 30px;
            font-size: 14px;
        }

        .email-sent {
            background: linear-gradient(135deg, #f0f8ff, #e8f5e9);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            color: var(--text-dark);
            border: 2px solid var(--primary-brand-color);
        }

        .email-sent strong {
            color: var(--primary-brand-color);
            word-break: break-all;
        }

        .otp-inputs {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .otp-input {
            width: 60px;
            height: 60px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            transition: all 0.3s;
            background: var(--bg-light);
        }

        .otp-input:focus {
            border-color: var(--primary-brand-color);
            outline: none;
            transform: scale(1.1);
            background: var(--white-color);
            box-shadow: 0 0 10px rgba(47, 180, 90, 0.3);
        }

        .error-message {
            color: var(--secondary-brand-color);
            background: #ffebee;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid var(--secondary-brand-color);
        }

        .success-message {
            color: var(--primary-brand-color);
            background: #e8f5e9;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid var(--primary-brand-color);
        }

        .btn-verify {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-brand-color), #27a04f);
            color: var(--white-color);
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(47, 180, 90, 0.3);
        }

        .btn-verify:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(47, 180, 90, 0.5);
        }

        .btn-verify:active {
            transform: translateY(0);
        }

        .resend-section {
            margin-top: 20px;
            color: var(--text-light);
            font-size: 14px;
        }

        .resend-link {
            color: var(--primary-brand-color);
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s;
        }

        .resend-link:hover {
            text-decoration: underline;
            color: #27a04f;
        }

        .timer {
            color: var(--secondary-brand-color);
            font-weight: bold;
        }

        .back-login {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .back-login a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .back-login a:hover {
            text-decoration: underline;
            color: var(--primary-brand-color);
        }

        .loading {
            display: none;
            margin-top: 10px;
        }

        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid var(--primary-brand-color);
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="otp-container">
        <div class="otp-icon">
            <i class="fas fa-envelope-open-text"></i>
        </div>
        
        <c:choose>
            <c:when test="${sessionScope.otpType == 'register'}">
                <h2>Xác thực Email</h2>
                <p class="subtitle">Vui lòng nhập mã OTP để hoàn tất đăng ký tài khoản</p>
            </c:when>
            <c:when test="${sessionScope.otpType == 'forgot-password'}">
                <h2>Xác thực Email</h2>
                <p class="subtitle">Vui lòng nhập mã OTP để đặt lại mật khẩu</p>
            </c:when>
            <c:otherwise>
                <h2>Xác thực Email</h2>
                <p class="subtitle">Vui lòng nhập mã OTP đã được gửi đến email của bạn</p>
            </c:otherwise>
        </c:choose>
        
        <div class="email-sent">
            📧 Mã OTP đã được gửi đến: <br>
            <strong>
                <c:choose>
                    <c:when test="${not empty sessionScope.otpEmail}">
                        ${sessionScope.otpEmail}
                    </c:when>
                    <c:when test="${not empty sessionScope.registerEmail}">
                        ${sessionScope.registerEmail}
                    </c:when>
                    <c:when test="${not empty sessionScope.emailReset}">
                        ${sessionScope.emailReset}
                    </c:when>
                    <c:otherwise>
                        Email của bạn
                    </c:otherwise>
                </c:choose>
            </strong>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${sessionScope.otpType == 'register'}">
                <form action="${pageContext.request.contextPath}/verify-register-otp" method="post" id="otpForm">
            </c:when>
            <c:when test="${sessionScope.otpType == 'forgot-password'}">
                <form action="${pageContext.request.contextPath}/verifyOTP" method="post" id="otpForm">
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/verifyOTP" method="post" id="otpForm">
            </c:otherwise>
        </c:choose>
        
            <div class="otp-inputs">
                <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" required autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" required autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" required autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" required autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" required autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" required autocomplete="off">
            </div>
            <input type="hidden" name="otp" id="hiddenOTP">
            
            <button type="submit" class="btn-verify">
                <c:choose>
                    <c:when test="${sessionScope.otpType == 'register'}">
                        <i class="fas fa-check-circle"></i> Xác thực & Hoàn tất đăng ký
                    </c:when>
                    <c:when test="${sessionScope.otpType == 'forgot-password'}">
                        <i class="fas fa-check-circle"></i> Xác thực & Tiếp tục
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-check-circle"></i> Xác thực OTP
                    </c:otherwise>
                </c:choose>
            </button>

            <div class="loading" id="loadingSpinner">
                <div class="spinner"></div>
                <p style="margin-top: 10px; color: #666;">Đang xác thực...</p>
            </div>
        </form>

        <div class="resend-section">
            <p>Không nhận được mã? 
                <c:choose>
                    <c:when test="${sessionScope.otpType == 'register'}">
                        <a href="${pageContext.request.contextPath}/resend-register-otp" class="resend-link" id="resendLink">
                            Gửi lại OTP
                        </a>
                    </c:when>
                    <c:when test="${sessionScope.otpType == 'forgot-password'}">
                        <a href="${pageContext.request.contextPath}/forgotPassword" class="resend-link" id="resendLink">
                            Gửi lại OTP
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="#" class="resend-link" id="resendLink">
                            Gửi lại OTP
                        </a>
                    </c:otherwise>
                </c:choose>
                <span id="timerSection" style="display: none;">
                    (<span class="timer" id="timer">60</span>s)
                </span>
            </p>
        </div>

        <div class="back-login">
            <a href="${pageContext.request.contextPath}/login.jsp">
                <i class="fas fa-arrow-left"></i> Quay lại đăng nhập
            </a>
        </div>
    </div>

    <script>
        // Auto focus next input
        const inputs = document.querySelectorAll('.otp-input');
        
        inputs.forEach((input, index) => {
            // Xử lý khi nhập ký tự
            input.addEventListener('input', (e) => {
                const value = e.target.value;
                
                // Lọc chỉ giữ lại số cuối cùng được nhập
                const numericValue = value.replace(/\D/g, '');
                
                if (numericValue.length > 0) {
                    // Chỉ lấy ký tự cuối cùng
                    e.target.value = numericValue.slice(-1);
                    
                    // Tự động chuyển sang ô tiếp theo
                    if (index < inputs.length - 1) {
                        setTimeout(() => {
                            inputs[index + 1].focus();
                        }, 10);
                    }
                } else {
                    // Nếu không phải số, xóa trống
                    e.target.value = '';
                }
            });

            // Xử lý phím Backspace
            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace') {
                    // Nếu ô hiện tại trống, quay lại ô trước
                    if (e.target.value === '' && index > 0) {
                        e.preventDefault();
                        setTimeout(() => {
                            inputs[index - 1].focus();
                            inputs[index - 1].value = '';
                        }, 10);
                    }
                }
                
                // Xử lý phím mũi tên trái/phải
                if (e.key === 'ArrowLeft' && index > 0) {
                    e.preventDefault();
                    inputs[index - 1].focus();
                }
                if (e.key === 'ArrowRight' && index < inputs.length - 1) {
                    e.preventDefault();
                    inputs[index + 1].focus();
                }
            });

            // Xử lý paste
            input.addEventListener('paste', (e) => {
                e.preventDefault();
                const pasteData = e.clipboardData.getData('text');
                const digits = pasteData.replace(/\D/g, '').slice(0, 6);
                
                digits.split('').forEach((digit, i) => {
                    if (inputs[i]) {
                        inputs[i].value = digit;
                    }
                });
                
                // Focus vào ô cuối cùng đã điền hoặc ô cuối
                const lastIndex = Math.min(digits.length - 1, inputs.length - 1);
                if (inputs[lastIndex]) {
                    setTimeout(() => {
                        inputs[lastIndex].focus();
                    }, 10);
                }
            });

            // Xử lý khi click vào ô (select toàn bộ nội dung)
            input.addEventListener('focus', (e) => {
                e.target.select();
            });
        });

        // Submit form - combine OTP inputs
        document.getElementById('otpForm').addEventListener('submit', (e) => {
            e.preventDefault();
            
            let otp = '';
            inputs.forEach(input => otp += input.value);
            
            if (otp.length !== 6) {
                alert('Vui lòng nhập đầy đủ 6 số OTP!');
                inputs[0].focus();
                return;
            }
            
            document.getElementById('hiddenOTP').value = otp;
            
            // Show loading
            document.querySelector('.btn-verify').style.display = 'none';
            document.getElementById('loadingSpinner').style.display = 'block';
            
            e.target.submit();
        });

        // Auto focus first input
        setTimeout(() => {
            inputs[0].focus();
        }, 100);

        // Timer for resend OTP
        let countdown = 60;
        const timerSection = document.getElementById('timerSection');
        const timerElement = document.getElementById('timer');
        const resendLink = document.getElementById('resendLink');

        function startTimer() {
            timerSection.style.display = 'inline';
            resendLink.style.pointerEvents = 'none';
            resendLink.style.opacity = '0.5';

            const interval = setInterval(() => {
                countdown--;
                timerElement.textContent = countdown;

                if (countdown <= 0) {
                    clearInterval(interval);
                    timerSection.style.display = 'none';
                    resendLink.style.pointerEvents = 'auto';
                    resendLink.style.opacity = '1';
                    countdown = 60;
                }
            }, 1000);
        }

        // Start timer on page load
        startTimer();
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP - Đăng ký</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .otp-container {
            background: white;
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
            color: #4CAF50;
            margin-bottom: 20px;
            animation: bounce 1s ease-in-out;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .email-sent {
            background: linear-gradient(135deg, #f0f8ff, #e8f5e9);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            color: #333;
            border: 2px solid #4CAF50;
        }

        .email-sent strong {
            color: #4CAF50;
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
            border: 2px solid #ddd;
            border-radius: 10px;
            transition: all 0.3s;
            background: #f9f9f9;
        }

        .otp-input:focus {
            border-color: #4CAF50;
            outline: none;
            transform: scale(1.1);
            background: white;
            box-shadow: 0 0 10px rgba(76, 175, 80, 0.3);
        }

        .error-message {
            color: #f44336;
            background: #ffebee;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #f44336;
        }

        .success-message {
            color: #4CAF50;
            background: #e8f5e9;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #4CAF50;
        }

        .btn-verify {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }

        .btn-verify:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(76, 175, 80, 0.5);
        }

        .btn-verify:active {
            transform: translateY(0);
        }

        .resend-section {
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }

        .resend-link {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s;
        }

        .resend-link:hover {
            text-decoration: underline;
            color: #45a049;
        }

        .timer {
            color: #f44336;
            font-weight: bold;
        }

        .back-login {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .back-login a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .back-login a:hover {
            text-decoration: underline;
            color: #764ba2;
        }

        .loading {
            display: none;
            margin-top: 10px;
        }

        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #4CAF50;
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
        
        <h2>Xác thực Email</h2>
        <p class="subtitle">Vui lòng nhập mã OTP đã được gửi đến email của bạn</p>
        
        <div class="email-sent">
            📧 Mã OTP đã được gửi đến: <br>
            <strong>${sessionScope.registerEmail}</strong>
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

        <form action="${pageContext.request.contextPath}/verify-register-otp" method="post" id="otpForm">
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
                <i class="fas fa-check-circle"></i> Xác thực & Hoàn tất đăng ký
            </button>

            <div class="loading" id="loadingSpinner">
                <div class="spinner"></div>
                <p style="margin-top: 10px; color: #666;">Đang xác thực...</p>
            </div>
        </form>

        <div class="resend-section">
            <p>Không nhận được mã? 
                <a href="${pageContext.request.contextPath}/resend-register-otp" class="resend-link" id="resendLink">
                    Gửi lại OTP
                </a>
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
                        inputs[index + 1].focus();
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
                        inputs[index - 1].focus();
                        inputs[index - 1].value = '';
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
                    inputs[lastIndex].focus();
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

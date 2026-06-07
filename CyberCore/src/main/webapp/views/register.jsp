<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>


<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-success text-white text-center py-3">
                    <h4 class="mb-0"><i class="fa-solid fa-user-plus"></i> Tạo Tài Khoản Mới</h4>
                </div>
                <div class="card-body p-4">
                    <form action="register" method="post">
                        <div class="mb-3">
                            <label class="form-label">Họ và Tên</label>
                            <input type="text" class="form-control" name="fullname" placeholder="Trần Tuấn Phát" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="Email đăng nhập" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" placeholder="0123456789" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" name="password" placeholder="Tạo mật khẩu" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100 fw-bold">Đăng Ký</button>
                    </form>
                    <div class="mt-3 text-center">
                        <p>Đã có tài khoản? <a href="login.jsp" class="text-decoration-none text-success">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%@ include file="footer.jsp" %>

Hình ảnh:


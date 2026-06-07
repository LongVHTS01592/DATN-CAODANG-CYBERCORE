<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberCore Admin - Quản Lý Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #1e293b;
            color: #f8fafc;
        }
        .sidebar-brand {
            font-size: 1.3rem;
            font-weight: 700;
            color: #38bdf8;
            padding: 1.5rem 1rem;
            border-bottom: 1px solid #334155;
        }
        .nav-menu .nav-link {
            color: #94a3b8;
            padding: 0.8rem 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }
        .nav-menu .nav-link:hover, .nav-menu .nav-link.active {
            background-color: #334155;
            color: #fff;
            border-radius: 0.25rem;
        }
    </style>
</head>
<body>


<div class="container-fluid p-0">
    <div class="row g-0">
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse px-3">
            <div class="sidebar-brand text-center mb-3">
                <i class="fa-solid fa-microchip"></i> CYBERCORE ADMIN
            </div>
            <div class="position-sticky">
                <ul class="nav flex-column nav-menu gap-1">
                    <li class="nav-item">
                        <a class="nav-link active" href="#"><i class="fa-solid fa-house"></i> Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ProductAdminController"><i class="fa-solid fa-box-archive"></i> Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-solid fa-list-ul"></i> Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-solid fa-file-invoice-dollar"></i> Đơn hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-solid fa-users"></i> Khách hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-solid fa-ticket"></i> Mã giảm giá</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fa-solid fa-star"></i> Đánh giá</a>
                    </li>
                    <li class="nav-item mt-4 pt-3 border-top border-secondary">
                        <a class="nav-link text-danger" href="LogoutController"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a>
                    </li>
                </ul>
            </div>
        </nav>


        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <h2 class="fw-bold mb-4">Quản lý Người dùng</h2>


            <div class="card shadow-sm border-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>Họ tên</th>
                        <th>Username</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td class="fw-bold">${u.fullName}</td>
                            <td>${u.username}</td>
                            <td><span class="badge bg-secondary">${u.roleName}</span></td>
                            <td>
                                   <span class="badge ${u.isActive ? 'bg-success' : 'bg-danger'}">
                                           ${u.isActive ? 'Hoạt động' : 'Đã khóa'}
                                   </span>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#userModal${u.userID}">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                                <a href="UserController?action=toggle&id=${u.userID}" class="btn btn-sm ${u.isActive ? 'btn-outline-danger' : 'btn-outline-success'}">
                                    <i class="fa-solid ${u.isActive ? 'fa-lock' : 'fa-unlock'}"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>


<c:forEach items="${users}" var="u">
    <div class="modal fade" id="userModal${u.userID}" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title">Chi tiết người dùng: ${u.fullName}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Email:</strong> ${u.email}</p>
                    <p><strong>Số điện thoại:</strong> ${u.phone}</p>
                    <hr>
                    <h6>Danh sách địa chỉ:</h6>
                    <ul class="list-group">
                        <c:forEach items="${u.addresses}" var="addr">
                            <li class="list-group-item">
                                <i class="fa-solid fa-location-dot text-danger me-2"></i>
                                    ${addr.detailedAddress}, ${addr.wardName}, ${addr.districtName}, ${addr.provinceName}
                                <c:if test="${addr.isDefault}"><span class="badge bg-primary ms-2">Mặc định</span></c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</c:forEach>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var activeTab = '${activeTab}';
        if (activeTab === 'list') {
            var tabEl = document.querySelector('a[href="#list"]');
            var tab = new bootstrap.Tab(tabEl);
            tab.show();
        } else {
            var tabEl = document.querySelector('a[href="#edition"]');
            var tab = new bootstrap.Tab(tabEl);
            tab.show();
        }
    });
</script>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberCore Admin - Hệ quản trị linh kiện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


    <style>
        html, body { height: 100%; margin: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; }


        /* Flexbox layout để sidebar luôn cao bằng màn hình */
        .wrapper { display: flex; min-height: 100vh; }


        .sidebar { width: 250px; background-color: #1e293b; color: #f8fafc; flex-shrink: 0; }


        .sidebar-brand { font-size: 1.3rem; font-weight: 700; color: #38bdf8; padding: 1.5rem 1rem; border-bottom: 1px solid #334155; }


        .nav-menu .nav-link { color: #94a3b8; padding: 0.8rem 1rem; display: flex; align-items: center; gap: 10px; transition: all 0.3s; }
        .nav-menu .nav-link:hover, .nav-menu .nav-link.active { background-color: #334155; color: #fff; border-radius: 0.25rem; }


        .stat-card { background: #fff; padding: 1.25rem; border-radius: 0.5rem; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        .card-label { color: #64748b; font-size: 0.85rem; font-weight: 600; text-transform: uppercase; }
        .card-value { color: #0f172a; font-size: 1.8rem; font-weight: 700; margin: 0.5rem 0; }


        /* Đảm bảo nội dung chính tự giãn */
        .main-content { flex-grow: 1; padding: 1.5rem; }
    </style>
</head>
<body>


<div class="wrapper">
    <nav class="sidebar">
        <div class="sidebar-brand text-center mb-3">
            <i class="fa-solid fa-microchip"></i> CYBERCORE ADMIN
        </div>
        <ul class="nav flex-column nav-menu px-3 gap-1">
            <li class="nav-item"><a class="nav-link active" href="#"><i class="fa-solid fa-house"></i> Dashboard</a></li>
            <li class="nav-item"><a class="nav-link" href="ProductAdminController"><i class="fa-solid fa-box-archive"></i> Sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fa-solid fa-list-ul"></i> Danh mục</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fa-solid fa-file-invoice-dollar"></i> Đơn hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fa-solid fa-users"></i> Khách hàng</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fa-solid fa-ticket"></i> Mã giảm giá</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fa-solid fa-star"></i> Đánh giá</a></li>
            <li class="nav-item mt-4 pt-3 border-top border-secondary"><a class="nav-link text-danger" href="LogoutController"><i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a></li>
        </ul>
    </nav>


    <main class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h2 fw-bold text-dark">Tổng Quan Hệ Thống</h1>
            <div class="text-muted"><i class="fa-regular fa-calendar-check me-2"></i> Hôm nay: 06/06/2026</div>
        </div>


        <div class="row g-3 mb-4">
            <div class="col-lg-3 col-sm-6"><div class="stat-card"><div class="card-label">Tổng doanh thu</div><div class="card-value"><fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol="đ"/></div><span class="text-success small fw-bold"><i class="fa-solid fa-arrow-up"></i> Tăng trưởng</span></div></div>
            <div class="col-lg-3 col-sm-6"><div class="stat-card"><div class="card-label">Đơn hàng mới</div><div class="card-value">${newOrdersCount != null ? newOrdersCount : 0}</div><span class="text-success small fw-bold"><i class="fa-solid fa-plus"></i> Đang chờ duyệt</span></div></div>
            <div class="col-lg-3 col-sm-6"><div class="stat-card"><div class="card-label">Sản phẩm sắp hết</div><div class="card-value text-danger">${lowStockCount != null ? lowStockCount : 0}</div><span class="text-secondary small">Cần nhập kho</span></div></div>
            <div class="col-lg-3 col-sm-6"><div class="stat-card"><div class="card-label">Thành viên mới</div><div class="card-value">${newUsersCount != null ? newUsersCount : 0}</div><span class="text-success small fw-bold"><i class="fa-solid fa-arrow-up"></i> Tuần này</span></div></div>
        </div>


        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-0">
                <h5 class="mb-0 fw-bold"><i class="fa-solid fa-list-check text-info me-2"></i>Đơn hàng mới nhất</h5>
                <button class="btn btn-sm btn-outline-primary fw-bold">Xem tất cả</button>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light"><tr><th>Mã đơn</th><th>Khách hàng</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Trạng thái</th></tr></thead>
                    <tbody>
                    <c:forEach items="${recentOrders}" var="bill">
                        <tr>
                            <td class="fw-bold">#ORD-${bill.billID}</td>
                            <td>${bill.shippingRecipientName}</td>
                            <td><fmt:formatDate value="${bill.orderDate}" pattern="dd/MM/yyyy"/></td>
                            <td class="fw-bold"><fmt:formatNumber value="${bill.totalAmount}" type="currency" currencySymbol="đ"/></td>
                            <td><span class="badge ${bill.orderStatus == 'Pending' ? 'bg-warning text-dark' : 'bg-success'}">${bill.orderStatus}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty recentOrders}">
                        <tr><td colspan="5" class="text-center text-muted py-5"><i class="fa-solid fa-inbox fs-2 d-block mb-2"></i>Chưa có dữ liệu giao dịch.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


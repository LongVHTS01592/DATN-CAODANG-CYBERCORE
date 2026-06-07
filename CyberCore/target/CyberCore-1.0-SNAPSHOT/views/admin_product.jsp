<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberCore Admin - Quản Lý Sản Phẩm</title>
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Quản lý Sản phẩm</h2>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productModal">
                    <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                </button>
            </div>


            <div class="card shadow-sm">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá bán</th>
                        <th>Bảo hành</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><img src="https://via.placeholder.com/50" class="rounded"></td>
                        <td class="fw-bold">Intel Core i9-14900K</td>
                        <td>15.000.000 đ</td>
                        <td>36 tháng</td>
                        <td><span class="badge bg-success">Đang bán</span></td>
                        <td class="text-center">
                            <button class="btn btn-sm btn-outline-warning"><i class="fa-solid fa-pen"></i></button>
                            <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</div>


<div class="modal fade" id="productModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header"><h5 class="modal-title">Thông tin Sản phẩm</h5></div>
            <form action="ProductController" method="POST">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6"><label>Tên sản phẩm</label><input type="text" class="form-control" name="productName" required></div>
                        <div class="col-md-6"><label>Giá bán</label><input type="number" class="form-control" name="sellPrice" required></div>
                        <div class="col-12"><label>Mô tả chi tiết</label><textarea class="form-control" name="description" rows="3"></textarea></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Lưu dữ liệu</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Giữ trạng thái tab active mượt mà sau khi cập nhật dữ liệu
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


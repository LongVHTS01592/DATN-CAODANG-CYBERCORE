<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục - CyberCore</title>
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
<body class="bg-light">


<div class="container-fluid">
    <div class="row">
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
                <h2 class="fw-bold text-dark">Quản lý Danh mục</h2>
            </div>


            <div class="row">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm p-4">
                        <h5 class="mb-3 fw-bold text-primary">
                            <i class="fa-solid ${empty categoryEdit ? 'fa-plus' : 'fa-pen-to-square'} me-2"></i>
                            ${empty categoryEdit ? 'Thêm Danh mục' : 'Cập nhật Danh mục'}
                        </h5>
                        <form action="CategoryController" method="POST">
                            <input type="hidden" name="action" value="${empty categoryEdit ? 'insert' : 'update'}">
                            <input type="hidden" name="id" value="${categoryEdit.categoryID}">


                            <div class="mb-3">
                                <label class="form-label">Tên danh mục</label>
                                <input type="text" name="name" class="form-control" value="${categoryEdit.categoryName}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Danh mục cha</label>
                                <select name="parentId" class="form-select">
                                    <option value="">-- Chọn danh mục gốc --</option>
                                    <c:forEach items="${listCategories}" var="cat">
                                        <option value="${cat.categoryID}" ${cat.categoryID == categoryEdit.parentCategoryID ? 'selected' : ''}>
                                                ${cat.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Slug (SEO)</label>
                                <input type="text" name="slug" class="form-control" value="${categoryEdit.slug}">
                            </div>


                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary fw-bold">
                                    <i class="fa-solid fa-floppy-disk me-1"></i> Lưu thay đổi
                                </button>


                                <%-- Nút Hủy chỉ xuất hiện khi đang ở chế độ Edit --%>
                                <c:if test="${not empty categoryEdit}">
                                    <a href="CategoryController" class="btn btn-outline-secondary fw-bold">
                                        <i class="fa-solid fa-times me-1"></i> Hủy chỉnh sửa
                                    </a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>


                <div class="col-md-8">
                    <div class="card border-0 shadow-sm">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Danh mục</th>
                                    <th>Cha</th>
                                    <th>Slug</th>
                                    <th class="text-center">Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${listCategories}" var="c">
                                    <tr>
                                        <td>${c.categoryID}</td>
                                        <td class="fw-bold">${c.categoryName}</td>
                                        <td>${c.parentCategoryID != null ? 'Có' : '---'}</td>
                                        <td><small class="text-muted">${c.slug}</small></td>
                                        <td class="text-center">
                                            <a href="CategoryController?action=edit&id=${c.categoryID}" class="btn btn-sm btn-outline-warning"><i class="fa-solid fa-edit"></i></a>
                                            <a href="CategoryController?action=delete&id=${c.categoryID}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa danh mục này?')"><i class="fa-solid fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


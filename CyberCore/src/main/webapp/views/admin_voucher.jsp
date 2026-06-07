<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>CyberCore Admin - Quản Lý Mã Giảm Giá</title>
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
    .main-content { background-color: #1e2226; min-height: 100vh; padding: 2rem; }
    .inner-card { background-color: #252930; border: 1px solid #373b3e; border-radius: 8px; padding: 25px; }
    .form-control { background-color: #1a1d20; border: 1px solid #373b3e; color: #fff; }
    .table-custom { color: #ced4da; }
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
      <div class="d-flex justify-content-between mb-4">
        <h2 class="fw-bold">Quản lý Khuyến mãi (Voucher)</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#voucherModal">
          <i class="fa-solid fa-plus"></i> Tạo Voucher
        </button>
      </div>


      <div class="card shadow-sm border-0">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-dark">
          <tr>
            <th>Mã Code</th>
            <th>Loại giảm</th>
            <th>Giá trị</th>
            <th>Sử dụng (Đã dùng/Tổng)</th>
            <th>Hạn dùng</th>
            <th>Trạng thái</th>
            <th class="text-center">Thao tác</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${vouchers}" var="v">
            <tr>
              <td class="fw-bold text-uppercase">${v.voucherCode}</td>
              <td>${v.discountType}</td>
              <td><fmt:formatNumber value="${v.discountValue}" type="number"/></td>
              <td>${v.usedCount} / ${v.usageLimit}</td>
              <td><fmt:formatDate value="${v.endDate}" pattern="dd/MM/yyyy" /></td>
              <td>
                                   <span class="badge ${v.status ? 'bg-success' : 'bg-danger'}">
                                       ${v.status ? 'Hoạt động' : 'Đã khóa'}
                                   </span>
              </td>
              <td class="text-center">
                <button class="btn btn-sm btn-outline-warning"><i class="fa-solid fa-pen"></i></button>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </main>
  </div>
</div>


<div class="modal fade" id="voucherModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="VoucherController" method="POST">
        <div class="modal-header"><h5 class="modal-title">Tạo mã khuyến mãi mới</h5></div>
        <div class="modal-body">
          <div class="row g-3">
            <div class="col-md-6"><label>Mã Voucher</label><input type="text" name="code" class="form-control" required></div>
            <div class="col-md-6"><label>Kiểu giảm</label>
              <select name="type" class="form-select">
                <option value="PERCENT">Phần trăm (%)</option>
                <option value="AMOUNT">Số tiền (VNĐ)</option>
              </select>
            </div>
            <div class="col-md-4"><label>Giá trị giảm</label><input type="number" name="value" class="form-control"></div>
            <div class="col-md-4"><label>Giảm tối đa</label><input type="number" name="maxAmount" class="form-control"></div>
            <div class="col-md-4"><label>Giới hạn dùng</label><input type="number" name="limit" class="form-control"></div>
          </div>
        </div>
        <div class="modal-footer"><button type="submit" class="btn btn-success">Lưu Voucher</button></div>
      </form>
    </div>
  </div>
</div>
</body>
</html>


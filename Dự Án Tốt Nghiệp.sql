use ComputerStoreEnterpriseDB;

select *from Bills;
SELECT OrderStatus, COUNT(*) AS SoLuongDonHang
FROM Bills
GROUP BY OrderStatus;
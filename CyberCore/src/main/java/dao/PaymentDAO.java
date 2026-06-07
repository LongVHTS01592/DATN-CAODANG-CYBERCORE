package dao;

import model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    private Payment map(ResultSet rs) throws SQLException {

        Payment p = new Payment();

        p.setPaymentID(rs.getInt("PaymentID"));
        p.setBillID(rs.getInt("BillID"));

        p.setPaymentMethod(
                rs.getString("PaymentMethod"));

        p.setPaymentStatus(
                rs.getString("PaymentStatus"));

        p.setAmount(
                rs.getBigDecimal("Amount"));

        p.setTransactionCode(
                rs.getString("TransactionCode"));

        p.setPaymentDate(
                rs.getTimestamp("PaymentDate"));

        p.setCreatedAt(
                rs.getTimestamp("CreatedAt"));

        return p;
    }

    public List<Payment> findAll() {

        List<Payment> list = new ArrayList<>();

        String sql = "SELECT * FROM Payments";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Payment findByBillId(int billId) {

        String sql =
                "SELECT * FROM Payments WHERE BillID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, billId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(Payment p) {

        String sql = """
                INSERT INTO Payments
                (
                BillID,
                PaymentMethod,
                PaymentStatus,
                Amount,
                TransactionCode,
                PaymentDate
                )
                VALUES
                (?,?,?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, p.getBillID());
            ps.setString(2, p.getPaymentMethod());
            ps.setString(3, p.getPaymentStatus());
            ps.setBigDecimal(4, p.getAmount());
            ps.setString(5, p.getTransactionCode());
            ps.setTimestamp(6, p.getPaymentDate());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateStatus(
            int billId,
            String status) {

        String sql =
                "UPDATE Payments SET PaymentStatus=? WHERE BillID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setInt(2, billId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
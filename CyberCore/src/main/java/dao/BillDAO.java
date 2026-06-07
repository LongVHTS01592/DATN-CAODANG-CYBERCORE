package dao;

import model.Bill;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    private Bill map(ResultSet rs) throws SQLException {

        Bill b = new Bill();

        b.setBillID(rs.getInt("BillID"));
        b.setUserID(rs.getInt("UserID"));

        b.setOrderDate(rs.getTimestamp("OrderDate"));

        b.setShippingRecipientName(
                rs.getString("ShippingRecipientName"));

        b.setShippingPhone(
                rs.getString("ShippingPhone"));

        b.setShippingAddressText(
                rs.getString("ShippingAddressText"));

        b.setTotalAmount(
                rs.getBigDecimal("TotalAmount"));

        b.setOrderStatus(
                rs.getString("OrderStatus"));

        b.setNotes(
                rs.getString("Notes"));

        return b;
    }

    public List<Bill> findAll() {

        List<Bill> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Bills ORDER BY BillID DESC";

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

    public Bill findById(int id) {

        String sql =
                "SELECT * FROM Bills WHERE BillID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Bill> findByUserId(int userId) {

        List<Bill> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Bills WHERE UserID=? ORDER BY BillID DESC";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int insert(Bill b) {

        String sql = """
                INSERT INTO Bills
                (
                UserID,
                ShippingRecipientName,
                ShippingPhone,
                ShippingAddressText,
                TotalAmount,
                OrderStatus,
                Notes
                )
                VALUES
                (?,?,?,?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS)
        ) {

            ps.setInt(1, b.getUserID());

            ps.setString(2,
                    b.getShippingRecipientName());

            ps.setString(3,
                    b.getShippingPhone());

            ps.setString(4,
                    b.getShippingAddressText());

            ps.setBigDecimal(5,
                    b.getTotalAmount());

            ps.setString(6,
                    b.getOrderStatus());

            ps.setString(7,
                    b.getNotes());

            int row = ps.executeUpdate();

            if (row > 0) {

                ResultSet rs =
                        ps.getGeneratedKeys();

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public boolean updateStatus(
            int billId,
            String status) {

        String sql =
                "UPDATE Bills SET OrderStatus=? WHERE BillID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setInt(2, billId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int billId) {

        String sql =
                "DELETE FROM Bills WHERE BillID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, billId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /*
     * Dashboard
     */

    public BigDecimal getTotalRevenue() {

        String sql = """
                SELECT ISNULL(SUM(TotalAmount),0)
                FROM Bills
                WHERE OrderStatus='Completed'
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql);
                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getBigDecimal(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }

    public int countPendingOrders() {

        String sql = """
                SELECT COUNT(*)
                FROM Bills
                WHERE OrderStatus='Pending'
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql);
                ResultSet rs =
                        ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Bill> getRecentOrders(int top) {

        List<Bill> list = new ArrayList<>();

        String sql =
                "SELECT TOP (?) * FROM Bills ORDER BY OrderDate DESC";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, top);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
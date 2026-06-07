package dao;

import model.BillDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDetailDAO {

    private BillDetail map(ResultSet rs)
            throws SQLException {

        BillDetail b = new BillDetail();

        b.setBillDetailID(
                rs.getInt("BillDetailID"));

        b.setBillID(
                rs.getInt("BillID"));

        b.setProductID(
                rs.getInt("ProductID"));

        b.setQuantity(
                rs.getInt("Quantity"));

        b.setPriceAtSale(
                rs.getBigDecimal("PriceAtSale"));

        return b;
    }

    public List<BillDetail> findByBillId(int billId) {

        List<BillDetail> list = new ArrayList<>();

        String sql =
                "SELECT * FROM BillDetails WHERE BillID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, billId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean insert(BillDetail b) {

        String sql = """
                INSERT INTO BillDetails
                (
                BillID,
                ProductID,
                Quantity,
                PriceAtSale
                )
                VALUES
                (?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, b.getBillID());
            ps.setInt(2, b.getProductID());
            ps.setInt(3, b.getQuantity());

            ps.setBigDecimal(4,
                    b.getPriceAtSale());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteByBillId(int billId) {

        String sql =
                "DELETE FROM BillDetails WHERE BillID=?";

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
}
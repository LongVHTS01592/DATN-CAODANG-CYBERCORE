package dao;

import model.Voucher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {

    private Voucher map(ResultSet rs) throws SQLException {

        Voucher v = new Voucher();

        v.setVoucherID(rs.getInt("VoucherID"));
        v.setVoucherCode(rs.getString("VoucherCode"));
        v.setDescription(rs.getString("Description"));

        v.setDiscountType(rs.getString("DiscountType"));

        v.setDiscountValue(rs.getBigDecimal("DiscountValue"));
        v.setMaxDiscountAmount(rs.getBigDecimal("MaxDiscountAmount"));
        v.setMinOrderValue(rs.getBigDecimal("MinOrderValue"));

        v.setStartDate(rs.getTimestamp("StartDate"));
        v.setEndDate(rs.getTimestamp("EndDate"));

        v.setUsageLimit(rs.getInt("UsageLimit"));
        v.setUsedCount(rs.getInt("UsedCount"));

        v.setStatus(rs.getBoolean("Status"));

        return v;
    }

    public List<Voucher> findAll() {

        List<Voucher> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Vouchers ORDER BY VoucherID DESC";

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

    public Voucher findById(int id) {

        String sql =
                "SELECT * FROM Vouchers WHERE VoucherID=?";

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

    public Voucher findByCode(String code) {

        String sql =
                "SELECT * FROM Vouchers WHERE VoucherCode=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, code);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(Voucher v) {

        String sql = """
                INSERT INTO Vouchers
                (
                VoucherCode,
                Description,
                DiscountType,
                DiscountValue,
                MaxDiscountAmount,
                MinOrderValue,
                StartDate,
                EndDate,
                UsageLimit,
                UsedCount,
                Status
                )
                VALUES
                (?,?,?,?,?,?,?,?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, v.getVoucherCode());
            ps.setString(2, v.getDescription());
            ps.setString(3, v.getDiscountType());

            ps.setBigDecimal(4, v.getDiscountValue());
            ps.setBigDecimal(5, v.getMaxDiscountAmount());
            ps.setBigDecimal(6, v.getMinOrderValue());

            ps.setTimestamp(7, v.getStartDate());
            ps.setTimestamp(8, v.getEndDate());

            ps.setInt(9, v.getUsageLimit());
            ps.setInt(10, v.getUsedCount());

            ps.setBoolean(11, v.isStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}

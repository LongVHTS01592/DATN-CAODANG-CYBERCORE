package dao;

import model.UserAddress;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserAddressDAO {

    private UserAddress map(ResultSet rs) throws SQLException {

        UserAddress a = new UserAddress();

        a.setAddressID(rs.getInt("AddressID"));
        a.setUserID(rs.getInt("UserID"));

        a.setRecipientName(
                rs.getString("RecipientName"));

        a.setPhone(
                rs.getString("Phone"));

        a.setProvinceName(
                rs.getString("ProvinceName"));

        a.setDistrictName(
                rs.getString("DistrictName"));

        a.setWardName(
                rs.getString("WardName"));

        a.setDetailedAddress(
                rs.getString("DetailedAddress"));

        a.setDefault(
                rs.getBoolean("IsDefault"));

        return a;
    }

    public List<UserAddress> findByUserId(int userId) {

        List<UserAddress> list = new ArrayList<>();

        String sql =
                "SELECT * FROM UserAddresses WHERE UserID=?";

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

    public UserAddress getDefaultAddress(int userId) {

        String sql = """
                SELECT *
                FROM UserAddresses
                WHERE UserID=?
                AND IsDefault=1
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(UserAddress a) {

        String sql = """
                INSERT INTO UserAddresses
                (
                UserID,
                RecipientName,
                Phone,
                ProvinceName,
                DistrictName,
                WardName,
                DetailedAddress,
                IsDefault
                )
                VALUES
                (?,?,?,?,?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, a.getUserID());
            ps.setString(2, a.getRecipientName());
            ps.setString(3, a.getPhone());
            ps.setString(4, a.getProvinceName());
            ps.setString(5, a.getDistrictName());
            ps.setString(6, a.getWardName());
            ps.setString(7, a.getDetailedAddress());
            ps.setBoolean(8, a.isDefault());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int addressId) {

        String sql =
                "DELETE FROM UserAddresses WHERE AddressID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, addressId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
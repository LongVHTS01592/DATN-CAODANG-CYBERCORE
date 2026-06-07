package dao;

import model.Cart;

import java.sql.*;

public class CartDAO {

    private Cart map(ResultSet rs) throws SQLException {

        Cart c = new Cart();

        c.setCartID(rs.getInt("CartID"));
        c.setUserID(rs.getInt("UserID"));
        c.setCreatedAt(rs.getTimestamp("CreatedAt"));
        c.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

        return c;
    }

    public Cart findById(int id) {

        String sql =
                "SELECT * FROM Cart WHERE CartID=?";

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

    public Cart findByUserId(int userId) {

        String sql =
                "SELECT * FROM Cart WHERE UserID=?";

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

    public boolean createCart(int userId) {

        String sql =
                "INSERT INTO Cart(UserID) VALUES(?)";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int cartId) {

        String sql =
                "DELETE FROM Cart WHERE CartID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
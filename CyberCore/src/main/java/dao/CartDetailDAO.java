package dao;

import model.CartDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDetailDAO {

    private CartDetail map(ResultSet rs) throws SQLException {

        CartDetail c = new CartDetail();

        c.setCartDetailID(rs.getInt("CartDetailID"));
        c.setCartID(rs.getInt("CartID"));
        c.setProductID(rs.getInt("ProductID"));
        c.setQuantity(rs.getInt("Quantity"));

        return c;
    }

    public List<CartDetail> findByCartId(int cartId) {

        List<CartDetail> list = new ArrayList<>();

        String sql =
                "SELECT * FROM CartDetails WHERE CartID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public CartDetail findProductInCart(int cartId, int productId) {

        String sql =
                "SELECT * FROM CartDetails WHERE CartID=? AND ProductID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addToCart(int cartId, int productId, int quantity) {

        String sql =
                "INSERT INTO CartDetails(CartID,ProductID,Quantity) VALUES(?,?,?)";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateQuantity(int cartDetailId, int quantity) {

        String sql =
                "UPDATE CartDetails SET Quantity=? WHERE CartDetailID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartDetailId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean removeItem(int cartDetailId) {

        String sql =
                "DELETE FROM CartDetails WHERE CartDetailID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, cartDetailId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean clearCart(int cartId) {

        String sql =
                "DELETE FROM CartDetails WHERE CartID=?";

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
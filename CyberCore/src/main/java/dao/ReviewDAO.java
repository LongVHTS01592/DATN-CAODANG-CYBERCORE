package dao;

import model.Review;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    private Review map(ResultSet rs) throws SQLException {

        Review r = new Review();

        r.setReviewID(rs.getInt("ReviewID"));
        r.setUserID(rs.getInt("UserID"));
        r.setProductID(rs.getInt("ProductID"));

        r.setRating(rs.getInt("Rating"));

        r.setComment(rs.getString("Comment"));

        r.setCreatedAt(
                rs.getTimestamp("CreatedAt"));

        return r;
    }

    public List<Review> findByProductId(int productId) {

        List<Review> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Reviews WHERE ProductID=? ORDER BY CreatedAt DESC";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean insert(Review r) {

        String sql = """
                INSERT INTO Reviews
                (
                UserID,
                ProductID,
                Rating,
                Comment
                )
                VALUES
                (?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, r.getUserID());
            ps.setInt(2, r.getProductID());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int reviewId) {

        String sql =
                "DELETE FROM Reviews WHERE ReviewID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, reviewId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public double getAverageRating(int productId) {

        String sql =
                "SELECT AVG(CAST(Rating AS FLOAT)) FROM Reviews WHERE ProductID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
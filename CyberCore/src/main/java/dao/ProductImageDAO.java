package dao;

import model.ProductImage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO {

    private ProductImage map(ResultSet rs) throws SQLException {

        ProductImage p = new ProductImage();

        p.setImageID(rs.getInt("ImageID"));
        p.setProductID(rs.getInt("ProductID"));
        p.setImageURL(rs.getString("ImageURL"));
        p.setDisplayOrder(rs.getInt("DisplayOrder"));

        return p;
    }

    public List<ProductImage> findAll() {

        List<ProductImage> list = new ArrayList<>();

        String sql =
                "SELECT * FROM ProductImages";

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

    public ProductImage findById(int id) {

        String sql =
                "SELECT * FROM ProductImages WHERE ImageID=?";

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

    public List<ProductImage> findByProductId(int productId) {

        List<ProductImage> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM ProductImages
                WHERE ProductID=?
                ORDER BY DisplayOrder
                """;

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

    public boolean insert(ProductImage p) {

        String sql = """
                INSERT INTO ProductImages
                (
                ProductID,
                ImageURL,
                DisplayOrder
                )
                VALUES
                (?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, p.getProductID());
            ps.setString(2, p.getImageURL());
            ps.setInt(3, p.getDisplayOrder());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(ProductImage p) {

        String sql = """
                UPDATE ProductImages
                SET
                ProductID=?,
                ImageURL=?,
                DisplayOrder=?
                WHERE ImageID=?
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, p.getProductID());
            ps.setString(2, p.getImageURL());
            ps.setInt(3, p.getDisplayOrder());
            ps.setInt(4, p.getImageID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id) {

        String sql =
                "DELETE FROM ProductImages WHERE ImageID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteByProductId(int productId) {

        String sql =
                "DELETE FROM ProductImages WHERE ProductID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
package dao;

import model.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Product map(ResultSet rs) throws SQLException {

        Product p = new Product();

        p.setProductID(rs.getInt("ProductID"));
        p.setProductName(rs.getString("ProductName"));

        p.setCategoryID(rs.getInt("CategoryID"));
        p.setBrandID(rs.getInt("BrandID"));

        p.setOriginalPrice(rs.getBigDecimal("OriginalPrice"));
        p.setSellPrice(rs.getBigDecimal("SellPrice"));
        p.setDiscountPrice(rs.getBigDecimal("DiscountPrice"));

        p.setMainImageURL(rs.getString("MainImageURL"));

        p.setDescriptionText(rs.getString("DescriptionText"));

        p.setWarrantyMonths(rs.getInt("WarrantyMonths"));

        p.setStatus(rs.getInt("Status"));

        p.setCreatedAt(rs.getTimestamp("CreatedAt"));

        return p;
    }

    public List<Product> findAll() {

        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM Products ORDER BY ProductID DESC";

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

    public Product findById(int id) {

        String sql =
                "SELECT * FROM Products WHERE ProductID=?";

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

    public List<Product> findByCategory(int categoryId) {

        List<Product> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Products WHERE CategoryID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> findByBrand(int brandId) {

        List<Product> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Products WHERE BrandID=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, brandId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> searchByName(String keyword) {

        List<Product> list = new ArrayList<>();

        String sql =
                "SELECT * FROM Products WHERE ProductName LIKE ?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Product> getNewestProducts(int top) {

        List<Product> list = new ArrayList<>();

        String sql =
                "SELECT TOP (?) * FROM Products ORDER BY CreatedAt DESC";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
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

    public boolean insert(Product p) {

        String sql = """
                INSERT INTO Products
                (
                ProductName,
                CategoryID,
                BrandID,
                OriginalPrice,
                SellPrice,
                DiscountPrice,
                MainImageURL,
                DescriptionText,
                WarrantyMonths,
                Status
                )
                VALUES
                (?,?,?,?,?,?,?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, p.getProductName());
            ps.setInt(2, p.getCategoryID());
            ps.setInt(3, p.getBrandID());

            ps.setBigDecimal(4, p.getOriginalPrice());
            ps.setBigDecimal(5, p.getSellPrice());

            ps.setBigDecimal(6, p.getDiscountPrice());

            ps.setString(7, p.getMainImageURL());
            ps.setString(8, p.getDescriptionText());

            ps.setInt(9, p.getWarrantyMonths());
            ps.setInt(10, p.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(Product p) {

        String sql = """
                UPDATE Products
                SET
                ProductName=?,
                CategoryID=?,
                BrandID=?,
                OriginalPrice=?,
                SellPrice=?,
                DiscountPrice=?,
                MainImageURL=?,
                DescriptionText=?,
                WarrantyMonths=?,
                Status=?
                WHERE ProductID=?
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, p.getProductName());
            ps.setInt(2, p.getCategoryID());
            ps.setInt(3, p.getBrandID());

            ps.setBigDecimal(4, p.getOriginalPrice());
            ps.setBigDecimal(5, p.getSellPrice());

            ps.setBigDecimal(6, p.getDiscountPrice());

            ps.setString(7, p.getMainImageURL());
            ps.setString(8, p.getDescriptionText());

            ps.setInt(9, p.getWarrantyMonths());
            ps.setInt(10, p.getStatus());

            ps.setInt(11, p.getProductID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id) {

        String sql =
                "DELETE FROM Products WHERE ProductID=?";

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
}
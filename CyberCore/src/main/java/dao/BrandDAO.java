package dao;

import model.Brand;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {

    private Brand map(ResultSet rs) throws SQLException {

        Brand b = new Brand();

        b.setBrandID(rs.getInt("BrandID"));
        b.setBrandName(rs.getString("BrandName"));
        b.setLogoURL(rs.getString("LogoURL"));
        b.setCountry(rs.getString("Country"));

        return b;
    }

    public List<Brand> findAll(){

        List<Brand> list = new ArrayList<>();

        String sql = "SELECT * FROM Brands";

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ){

            while(rs.next()){
                list.add(map(rs));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public Brand findById(int id){

        String sql =
                "SELECT * FROM Brands WHERE BrandID=?";

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ){

            ps.setInt(1,id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                return map(rs);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(Brand b){

        String sql = """
                INSERT INTO Brands
                (
                BrandName,
                LogoURL,
                Country
                )
                VALUES
                (?,?,?)
                """;

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ){

            ps.setString(1,b.getBrandName());
            ps.setString(2,b.getLogoURL());
            ps.setString(3,b.getCountry());

            return ps.executeUpdate()>0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(Brand b){

        String sql = """
                UPDATE Brands
                SET
                BrandName=?,
                LogoURL=?,
                Country=?
                WHERE BrandID=?
                """;

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ){

            ps.setString(1,b.getBrandName());
            ps.setString(2,b.getLogoURL());
            ps.setString(3,b.getCountry());
            ps.setInt(4,b.getBrandID());

            return ps.executeUpdate()>0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id){

        String sql =
                "DELETE FROM Brands WHERE BrandID=?";

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ){

            ps.setInt(1,id);

            return ps.executeUpdate()>0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }
}
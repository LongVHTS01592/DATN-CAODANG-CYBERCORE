package dao;

import model.Category;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    private Category map(ResultSet rs) throws SQLException {

        Category c = new Category();

        c.setCategoryID(rs.getInt("CategoryID"));
        c.setCategoryName(rs.getString("CategoryName"));

        int parent = rs.getInt("ParentCategoryID");

        if(rs.wasNull()){
            c.setParentCategoryID(null);
        }else{
            c.setParentCategoryID(parent);
        }

        c.setDescription(rs.getString("Description"));
        c.setSlug(rs.getString("Slug"));

        return c;
    }

    public List<Category> findAll(){

        List<Category> list = new ArrayList<>();

        String sql = "SELECT * FROM Categories";

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

    public Category findById(int id){

        String sql =
                "SELECT * FROM Categories WHERE CategoryID=?";

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

    public boolean insert(Category c){

        String sql = """
                INSERT INTO Categories
                (
                CategoryName,
                ParentCategoryID,
                Description,
                Slug
                )
                VALUES
                (?,?,?,?)
                """;

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ){

            ps.setString(1,c.getCategoryName());

            if(c.getParentCategoryID()==null){
                ps.setNull(2, Types.INTEGER);
            }else{
                ps.setInt(2,c.getParentCategoryID());
            }

            ps.setString(3,c.getDescription());
            ps.setString(4,c.getSlug());

            return ps.executeUpdate()>0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(Category c){

        String sql = """
                UPDATE Categories
                SET
                CategoryName=?,
                ParentCategoryID=?,
                Description=?,
                Slug=?
                WHERE CategoryID=?
                """;

        try(
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ){

            ps.setString(1,c.getCategoryName());

            if(c.getParentCategoryID()==null){
                ps.setNull(2,Types.INTEGER);
            }else{
                ps.setInt(2,c.getParentCategoryID());
            }

            ps.setString(3,c.getDescription());
            ps.setString(4,c.getSlug());

            ps.setInt(5,c.getCategoryID());

            return ps.executeUpdate()>0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id){

        String sql =
                "DELETE FROM Categories WHERE CategoryID=?";

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
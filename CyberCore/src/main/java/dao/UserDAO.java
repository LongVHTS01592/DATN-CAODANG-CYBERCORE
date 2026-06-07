package dao;

import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private User map(ResultSet rs) throws SQLException {

        User u = new User();

        u.setUserID(rs.getInt("UserID"));
        u.setUsername(rs.getString("Username"));
        u.setPasswordHash(rs.getString("PasswordHash"));
        u.setFullName(rs.getString("FullName"));
        u.setEmail(rs.getString("Email"));
        u.setPhone(rs.getString("Phone"));
        u.setRoleID(rs.getInt("RoleID"));
        u.setActive(rs.getBoolean("IsActive"));
        u.setCreatedAt(rs.getTimestamp("CreatedAt"));
        u.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

        return u;
    }

    public List<User> findAll() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT * FROM Users";

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

    public User findById(int id) {

        String sql =
                "SELECT * FROM Users WHERE UserID=?";

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

    public User findByUsername(String username) {

        String sql =
                "SELECT * FROM Users WHERE Username=?";

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public User login(String username, String passwordHash) {

        String sql = """
                SELECT *
                FROM Users
                WHERE Username=?
                AND PasswordHash=?
                AND IsActive=1
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, username);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean insert(User u) {

        String sql = """
                INSERT INTO Users
                (
                Username,
                PasswordHash,
                FullName,
                Email,
                Phone,
                RoleID,
                IsActive
                )
                VALUES
                (?,?,?,?,?,?,?)
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasswordHash());
            ps.setString(3, u.getFullName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPhone());
            ps.setInt(6, u.getRoleID());
            ps.setBoolean(7, u.isActive());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean update(User u) {

        String sql = """
                UPDATE Users
                SET
                PasswordHash=?,
                FullName=?,
                Email=?,
                Phone=?,
                RoleID=?,
                IsActive=?,
                UpdatedAt=GETDATE()
                WHERE UserID=?
                """;

        try (
                Connection con = DBContext.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, u.getPasswordHash());
            ps.setString(2, u.getFullName());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPhone());
            ps.setInt(5, u.getRoleID());
            ps.setBoolean(6, u.isActive());
            ps.setInt(7, u.getUserID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean delete(int id) {

        String sql =
                "DELETE FROM Users WHERE UserID=?";

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

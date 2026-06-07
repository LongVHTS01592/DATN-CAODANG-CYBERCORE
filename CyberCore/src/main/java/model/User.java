package model;

import java.sql.Timestamp;

public class User {
    private int userID;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private String phone;

    private int roleID;
    private Role role;

    private boolean isActive;

    private Timestamp createdAt;
    private Timestamp updatedAt;

    public User() {
    }
}

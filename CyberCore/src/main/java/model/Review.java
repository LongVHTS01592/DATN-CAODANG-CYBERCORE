package model;

import java.sql.Timestamp;

public class Review {

    private int reviewID;

    private int userID;
    private int productID;

    private User user;
    private Product product;

    private int rating;

    private String comment;

    private Timestamp createdAt;

    public Review() {
    }
}

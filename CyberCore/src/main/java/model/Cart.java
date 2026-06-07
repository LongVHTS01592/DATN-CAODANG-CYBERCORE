package model;

import java.sql.Timestamp;
import java.util.List;

public class Cart {

    private int cartID;

    private int userID;

    private Timestamp createdAt;
    private Timestamp updatedAt;

    private List<CartDetail> details;

    public Cart() {
    }
}

package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Bill {

    private int billID;

    private int userID;

    private User user;

    private Timestamp orderDate;

    private String shippingRecipientName;

    private String shippingPhone;

    private String shippingAddressText;

    private BigDecimal totalAmount;

    private String orderStatus;

    private String notes;

    private List<BillDetail> billDetails;

    public Bill() {
    }
}
package model;

import java.math.BigDecimal;

public class BillDetail {

    private int billDetailID;

    private int billID;

    private int productID;

    private Product product;

    private int quantity;

    private BigDecimal priceAtSale;

    public BillDetail() {
    }
}

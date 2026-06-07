package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Product {

    private int productID;

    private String productName;

    private int categoryID;
    private int brandID;

    private Category category;
    private Brand brand;

    private BigDecimal originalPrice;
    private BigDecimal sellPrice;
    private BigDecimal discountPrice;

    private String mainImageURL;

    private String descriptionText;

    private int warrantyMonths;

    private int status;

    private Timestamp createdAt;

    private List<ProductImage> images;

    public Product() {
    }
}

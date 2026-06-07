package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Voucher {

    private int voucherID;

    private String voucherCode;

    private String description;

    private String discountType;

    private BigDecimal discountValue;

    private BigDecimal maxDiscountAmount;

    private BigDecimal minOrderValue;

    private Timestamp startDate;

    private Timestamp endDate;

    private int usageLimit;

    private int usedCount;

    private boolean status;

    public Voucher() {
    }
}

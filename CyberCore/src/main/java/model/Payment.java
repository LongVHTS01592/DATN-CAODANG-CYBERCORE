    package model;

    import java.math.BigDecimal;
    import java.sql.Timestamp;

    public class Payment {

        private int paymentID;

        private int billID;

        private Bill bill;

        private String paymentMethod;

        private String paymentStatus;

        private BigDecimal amount;

        private String transactionCode;

        private Timestamp paymentDate;

        private Timestamp createdAt;

        public Payment() {
        }
    }

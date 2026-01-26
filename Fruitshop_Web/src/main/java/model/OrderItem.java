package model;

import java.math.BigDecimal;

public class OrderItem {
    private int id;
    private int orderId;
    private Integer productId;
    private String productName;
    
    // Thông tin deal (MỚI)
    private String dealType;          // "weekend", "sale", null
    private Integer dealId;           // ID của weekend_deals
    private BigDecimal originalPrice; // Giá gốc
    private BigDecimal discountAmount;// Số tiền giảm
    private BigDecimal finalPrice;    // Giá cuối (đã giảm)
    
    private int quantity;
    private BigDecimal total;
    
    // For display
    private Product product;
    
    // Tương thích với code cũ
    private double price;  // deprecated, dùng finalPrice

    public OrderItem() {
    }

    public OrderItem(int id, int orderId, Integer productId, String productName, 
                     double price, int quantity, double total) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.finalPrice = BigDecimal.valueOf(price);
        this.quantity = quantity;
        this.total = BigDecimal.valueOf(total);
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDealType() {
        return dealType;
    }

    public void setDealType(String dealType) {
        this.dealType = dealType;
    }

    public Integer getDealId() {
        return dealId;
    }

    public void setDealId(Integer dealId) {
        this.dealId = dealId;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
    // Tương thích với code cũ
    public double getPrice() {
        return finalPrice != null ? finalPrice.doubleValue() : price;
    }

    public void setPrice(double price) {
        this.price = price;
        this.finalPrice = BigDecimal.valueOf(price);
    }
    
    public double getTotalDouble() {
        return total != null ? total.doubleValue() : 0;
    }
    
    public boolean hasDeal() {
        return dealType != null && discountAmount != null && discountAmount.compareTo(BigDecimal.ZERO) > 0;
    }
}

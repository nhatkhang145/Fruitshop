package model;

public class Product {
    private int id;
    private String name;
    private double price;
    private double salePrice;
    private int quantity;
    private String description;
    private String image;
    private int categoryId;

    // Constructor không tham số
    public Product() {
    }

    // Constructor đầy đủ tham số
    public Product(int id, String name, double price, double salePrice, int quantity, String description, String image, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.salePrice = salePrice;
        this.quantity = quantity;
        this.description = description;
        this.image = image;
        this.categoryId = categoryId;
    }

    // Getter và Setter (Bạn tự generate trong IDE nhé, ở đây mình viết gọn)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
}
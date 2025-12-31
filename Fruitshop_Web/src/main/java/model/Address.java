package model;

public class Address {
    private int id;
    private int userId;
    private String receiverName;
    private String phoneNumber;
    private String address;
    private String city;
    private boolean isDefault;

    public Address() {
    }

    public Address(int id, int userId, String receiverName, String phoneNumber, 
                   String address, String city, boolean isDefault) {
        this.id = id;
        this.userId = userId;
        this.receiverName = receiverName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.city = city;
        this.isDefault = isDefault;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public boolean isDefault() {
        return isDefault;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }
}

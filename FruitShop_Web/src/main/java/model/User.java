package model;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private int role;
    private String avatar;
    private String gender; // <--- 1. THÊM BIẾN NÀY

    public User() {
    }

    public User(int id, String fullName, String email, String password, String phone, int role, String avatar, String gender) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
        this.avatar = avatar;
        this.gender = gender;
    }

    // Getter & Setter cũ giữ nguyên, thêm 2 cái mới cho gender:
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    // --- 2. THÊM GETTER/SETTER CHO GENDER ---
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
}
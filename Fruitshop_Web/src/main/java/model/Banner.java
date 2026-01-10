package model;

public class Banner {
    private int id;
    private String title;
    private String image;
    private String link;
    private int displayOrder;
    private int status;

    public Banner() {
    }

    public Banner(int id, String title, String image, String link, int displayOrder, int status) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.link = link;
        this.displayOrder = displayOrder;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getLink() {
        return link;
    }
    public void setLink(String link) {
        this.link = link;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }
    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
}
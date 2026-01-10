package dal;

import model.Banner;
import java.util.List;

public class BannerDAO {

    // 1. Lấy tất cả banner
    public List<Banner> getAllBanners() {
        String sql = "SELECT id, title, description, image_url AS imageUrl, link, display_order AS displayOrder, status FROM banners ORDER BY display_order ASC";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Banner.class)
                        .list()
        );
    }

    // 2. Lấy banner theo ID
    public Banner getBannerById(int id) {
        String sql = "SELECT id, title, description, image_url AS imageUrl, link, display_order AS displayOrder, status FROM banners WHERE id = ?";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, id)
                        .mapToBean(Banner.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    // 3. Lấy banner active cho trang chủ
    public List<Banner> getActiveBanners() {
        String sql = "SELECT id, title, description, image_url AS imageUrl, link, display_order AS displayOrder, status FROM banners WHERE status = 1 ORDER BY display_order ASC";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Banner.class)
                        .list()
        );
    }

    // 4. Thêm mới
    public int insert(Banner b) {
        String sql = "INSERT INTO banners (title, description, image_url, link, display_order, status) VALUES (:title, :description, :imageUrl, :link, :displayOrder, :status)";
        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(b)
                        .execute()
        );
    }

    // 5. Cập nhật
    public int update(Banner b) {
        String sql = "UPDATE banners SET title=:title, description=:description, image_url=:imageUrl, link=:link, display_order=:displayOrder, status=:status WHERE id=:id";
        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(b)
                        .execute()
        );
    }

    // 6. Xóa
    public int delete(int id) {
        String sql = "DELETE FROM banners WHERE id = ?";
        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, id)
                        .execute()
        );
    }
}
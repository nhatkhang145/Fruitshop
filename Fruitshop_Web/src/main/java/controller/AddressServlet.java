package controller;

import dal.AddressDAO;
import model.Address;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AddressServlet", urlPatterns = {"/addresses"})
public class AddressServlet extends HttpServlet {

    private AddressDAO addressDAO = new AddressDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy danh sách địa chỉ của user
        List<Address> addresses = addressDAO.getAddressesByUserId(user.getId());
        request.setAttribute("addresses", addresses);

        request.getRequestDispatcher("addresses.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addAddress(request, user);
                    request.setAttribute("message", "Thêm địa chỉ thành công!");
                    break;
                case "update":
                    updateAddress(request, user);
                    request.setAttribute("message", "Cập nhật địa chỉ thành công!");
                    break;
                case "delete":
                    deleteAddress(request, user);
                    request.setAttribute("message", "Xóa địa chỉ thành công!");
                    break;
                case "setDefault":
                    setDefaultAddress(request, user);
                    request.setAttribute("message", "Đã thiết lập địa chỉ mặc định!");
                    break;
                default:
                    request.setAttribute("error", "Hành động không hợp lệ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        // Lấy lại danh sách địa chỉ và forward về trang
        List<Address> addresses = addressDAO.getAddressesByUserId(user.getId());
        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("addresses.jsp").forward(request, response);
    }

    // Thêm địa chỉ mới
    private void addAddress(HttpServletRequest request, User user) {
        String receiverName = request.getParameter("receiverName");
        String phoneNumber = request.getParameter("phoneNumber");
        String addressDetail = request.getParameter("address");
        String city = request.getParameter("city");
        String isDefaultStr = request.getParameter("isDefault");
        boolean isDefault = "on".equals(isDefaultStr) || "1".equals(isDefaultStr);

        Address address = new Address();
        address.setUserId(user.getId());
        address.setReceiverName(receiverName);
        address.setPhoneNumber(phoneNumber);
        address.setAddress(addressDetail);
        address.setCity(city);
        address.setDefault(isDefault);

        addressDAO.addAddress(address);
    }

    // Cập nhật địa chỉ
    private void updateAddress(HttpServletRequest request, User user) {
        int addressId = Integer.parseInt(request.getParameter("addressId"));
        String receiverName = request.getParameter("receiverName");
        String phoneNumber = request.getParameter("phoneNumber");
        String addressDetail = request.getParameter("address");
        String city = request.getParameter("city");
        String isDefaultStr = request.getParameter("isDefault");
        boolean isDefault = "on".equals(isDefaultStr) || "1".equals(isDefaultStr);

        // Kiểm tra địa chỉ có thuộc user này không
        Address existingAddress = addressDAO.getAddressById(addressId);
        if (existingAddress == null || existingAddress.getUserId() != user.getId()) {
            throw new RuntimeException("Không có quyền cập nhật địa chỉ này!");
        }

        Address address = new Address();
        address.setId(addressId);
        address.setUserId(user.getId());
        address.setReceiverName(receiverName);
        address.setPhoneNumber(phoneNumber);
        address.setAddress(addressDetail);
        address.setCity(city);
        address.setDefault(isDefault);

        addressDAO.updateAddress(address);
    }

    // Xóa địa chỉ
    private void deleteAddress(HttpServletRequest request, User user) {
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        // Kiểm tra địa chỉ có thuộc user này không
        Address existingAddress = addressDAO.getAddressById(addressId);
        if (existingAddress == null || existingAddress.getUserId() != user.getId()) {
            throw new RuntimeException("Không có quyền xóa địa chỉ này!");
        }

        // Không cho xóa địa chỉ mặc định
        if (existingAddress.isDefault()) {
            throw new RuntimeException("Không thể xóa địa chỉ mặc định!");
        }

        addressDAO.deleteAddress(addressId);
    }

    // Đặt địa chỉ mặc định
    private void setDefaultAddress(HttpServletRequest request, User user) {
        int addressId = Integer.parseInt(request.getParameter("addressId"));

        // Kiểm tra địa chỉ có thuộc user này không
        Address existingAddress = addressDAO.getAddressById(addressId);
        if (existingAddress == null || existingAddress.getUserId() != user.getId()) {
            throw new RuntimeException("Không có quyền thay đổi địa chỉ này!");
        }

        addressDAO.setDefaultAddress(user.getId(), addressId);
    }
}

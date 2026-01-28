package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

@WebServlet(name = "CKFinderConnectorServlet", urlPatterns = {
        "/ckfinder/connector",
        "/ckfinder/core/connector/java/connector",
        "/assets/ckfinder/ckfinder/core/connector/java/connector.java",
        "/ckfinder/core/connector/java/connector.java"
})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CKFinderConnectorServlet extends HttpServlet {

    private String uploadBasePath;
    private String baseUrl;

    @Override
    public void init() throws ServletException {
        super.init();
        uploadBasePath = getServletContext().getRealPath("/uploads/ckfinder/");
        createDir(uploadBasePath);
        createDir(uploadBasePath + "images/");
        createDir(uploadBasePath + "files/");
    }

    private void createDir(String path) {
        File dir = new File(path);
        if (!dir.exists())
            dir.mkdirs();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        baseUrl = req.getContextPath() + "/uploads/ckfinder/";
        String command = req.getParameter("command");
        if (command == null)
            command = "";

        switch (command) {
            case "Init":
                handleInit(req, resp);
                break;
            case "GetFolders":
                handleGetFolders(req, resp);
                break;
            case "GetFiles":
                handleGetFiles(req, resp);
                break;
            default:
                resp.setStatus(200);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        baseUrl = req.getContextPath() + "/uploads/ckfinder/";
        String command = req.getParameter("command");
        if ("QuickUpload".equals(command) || "FileUpload".equals(command)) {
            handleUpload(req, resp);
        } else {
            doGet(req, resp);
        }
    }

    private void handleInit(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/xml;charset=UTF-8");
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "0");
        PrintWriter out = resp.getWriter();
        out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        out.print("<Connector>");
        out.print("<Error number=\"0\"/>");
        out.print(
                "<ConnectorInfo enabled=\"true\" s=\"\" c=\"\" thumbsEnabled=\"true\" uploadCheckImages=\"false\" thumbsUrl=\""
                        + baseUrl + "_thumbs/\" thumbsDirectAccess=\"false\" imgWidth=\"1600\" imgHeight=\"1200\"/>");
        out.print("<ResourceTypes>");
        out.print("<ResourceType name=\"Images\" url=\"" + baseUrl
                + "images/\" allowedExtensions=\"bmp,gif,jpeg,jpg,png,webp\" deniedExtensions=\"\" maxSize=\"10485760\" hash=\"a1b2c3\" hasChildren=\"true\" acl=\"255\"/>");
        out.print("<ResourceType name=\"Files\" url=\"" + baseUrl
                + "files/\" allowedExtensions=\"7z,csv,doc,docx,gif,jpeg,jpg,pdf,png,ppt,rar,txt,xls,xlsx,zip\" deniedExtensions=\"\" maxSize=\"52428800\" hash=\"d4e5f6\" hasChildren=\"true\" acl=\"255\"/>");
        out.print("</ResourceTypes>");
        out.print("<PluginsInfo/>");
        out.print("</Connector>");
        out.flush();
    }

    private void handleGetFolders(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type = req.getParameter("type");
        if (type == null)
            type = "Images";
        String currentFolder = req.getParameter("currentFolder");
        if (currentFolder == null)
            currentFolder = "/";

        String folder = type.equals("Images") ? "images/" : "files/";
        File dir = new File(uploadBasePath + folder);

        resp.setContentType("application/xml;charset=UTF-8");
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "0");
        PrintWriter out = resp.getWriter();
        StringBuilder xml = new StringBuilder();
        xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        xml.append("<Connector resourceType=\"").append(type).append("\">");
        xml.append("<Error number=\"0\"/>");
        xml.append("<CurrentFolder path=\"").append(currentFolder).append("\" url=\"").append(baseUrl).append(folder)
                .append("\" acl=\"255\"/>");
        xml.append("<Folders>");
        if (dir.exists() && dir.isDirectory()) {
            File[] subDirs = dir.listFiles();
            if (subDirs != null) {
                for (File f : subDirs) {
                    if (f.isDirectory() && !f.getName().startsWith(".")) {
                        xml.append("<Folder name=\"").append(escapeXml(f.getName()))
                                .append("\" hasChildren=\"false\" acl=\"255\"/>");
                    }
                }
            }
        }
        xml.append("</Folders>");
        xml.append("</Connector>");
        out.print(xml.toString());
        out.flush();
    }

    private void handleGetFiles(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type = req.getParameter("type");
        if (type == null)
            type = "Images";
        String currentFolder = req.getParameter("currentFolder");
        if (currentFolder == null)
            currentFolder = "/";

        String folder = type.equals("Images") ? "images/" : "files/";
        File dir = new File(uploadBasePath + folder);

        resp.setContentType("application/xml;charset=UTF-8");
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "0");
        PrintWriter out = resp.getWriter();
        StringBuilder xml = new StringBuilder();
        xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        xml.append("<Connector resourceType=\"").append(type).append("\">");
        xml.append("<Error number=\"0\"/>");
        xml.append("<CurrentFolder path=\"").append(currentFolder).append("\" url=\"").append(baseUrl).append(folder)
                .append("\" acl=\"255\"/>");
        xml.append("<Files>");
        if (dir.exists() && dir.isDirectory()) {
            File[] files = dir.listFiles();
            if (files != null) {
                for (File f : files) {
                    if (f.isFile() && !f.getName().startsWith(".")) {
                        long sizeKB = f.length() / 1024;
                        if (sizeKB == 0)
                            sizeKB = 1;
                        String date = new java.text.SimpleDateFormat("yyyyMMddHHmm")
                                .format(new java.util.Date(f.lastModified()));
                        xml.append("<File name=\"").append(escapeXml(f.getName()))
                                .append("\" date=\"").append(date)
                                .append("\" size=\"").append(sizeKB).append("\"/>");
                    }
                }
            }
        }
        xml.append("</Files>");
        xml.append("</Connector>");
        out.print(xml.toString());
        out.flush();
    }

    private void handleUpload(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        if (type == null)
            type = "Images";
        String folder = type.equals("Images") ? "images/" : "files/";
        String uploadPath = uploadBasePath + folder;
        createDir(uploadPath);

        Part filePart = null;
        try {
            filePart = req.getPart("upload");
        } catch (Exception e) {
            sendError(resp, req, "No file");
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            sendError(resp, req, "No file uploaded");
            return;
        }

        String originalName = getFileName(filePart);
        if (originalName == null || originalName.isEmpty()) {
            sendError(resp, req, "Invalid file name");
            return;
        }

        String ext = "";
        int dot = originalName.lastIndexOf('.');
        if (dot > 0)
            ext = originalName.substring(dot);

        String newName = UUID.randomUUID().toString() + ext;

        try {
            filePart.write(uploadPath + newName);
        } catch (Exception e) {
            sendError(resp, req, "Upload failed");
            return;
        }

        String fileUrl = req.getContextPath() + "/uploads/ckfinder/" + folder + newName;
        String currentFolder = req.getParameter("currentFolder");
        if (currentFolder == null)
            currentFolder = "/";
        sendSuccess(resp, req, fileUrl, newName, type, currentFolder, folder);
    }

    private void sendSuccess(HttpServletResponse resp, HttpServletRequest req, String url, String fileName, String type,
            String currentFolder, String folder)
            throws IOException {
        String funcNum = req.getParameter("CKEditorFuncNum");
        PrintWriter out = resp.getWriter();

        if (funcNum != null && !funcNum.isEmpty()) {
            resp.setContentType("text/html;charset=UTF-8");
            out.println(
                    "<script>window.parent.CKEDITOR.tools.callFunction(" + funcNum + ",'" + url + "','');</script>");
        } else {
            resp.setContentType("text/html;charset=UTF-8");
            resp.setHeader("Cache-Control", "no-cache");
            StringBuilder xml = new StringBuilder();
            xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            xml.append("<Connector resourceType=\"").append(type).append("\">");
            xml.append("<Error number=\"0\"/>");
            xml.append("<CurrentFolder path=\"").append(currentFolder).append("\" url=\"")
                    .append(req.getContextPath()).append("/uploads/ckfinder/").append(folder)
                    .append("\" acl=\"255\"/>");
            xml.append("<NewFile name=\"").append(fileName).append("\"/>");
            xml.append("</Connector>");
            out.print("<textarea>" + xml.toString() + "</textarea>");
            out.flush();
        }
    }

    private void sendError(HttpServletResponse resp, HttpServletRequest req, String msg) throws IOException {
        String funcNum = req.getParameter("CKEditorFuncNum");
        PrintWriter out = resp.getWriter();
        if (funcNum != null && !funcNum.isEmpty()) {
            resp.setContentType("text/html;charset=UTF-8");
            out.println(
                    "<script>window.parent.CKEDITOR.tools.callFunction(" + funcNum + ",'','" + msg + "');</script>");
        } else {
            resp.setContentType("text/html;charset=UTF-8");
            resp.setHeader("Cache-Control", "no-cache");
            out.print("<textarea><?xml version=\"1.0\" encoding=\"utf-8\"?><Connector><Error number=\"203\" text=\""
                    + msg + "\"/></Connector></textarea>");
            out.flush();
        }
    }

    private String getFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd != null) {
            for (String token : cd.split(";")) {
                token = token.trim();
                if (token.startsWith("filename=")) {
                    String name = token.substring(9).replace("\"", "");
                    int idx = Math.max(name.lastIndexOf('/'), name.lastIndexOf('\\'));
                    return idx >= 0 ? name.substring(idx + 1) : name;
                }
            }
        }
        return null;
    }

    private String escapeXml(String s) {
        if (s == null)
            return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&apos;");
    }
}

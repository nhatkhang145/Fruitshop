package com.ckfinder.authentication;

import com.cksource.ckfinder.authentication.Authenticator;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

@Named
public class ConfigBasedAuthenticator implements Authenticator {

    @Inject
    private HttpServletRequest request;

    @Override
    public boolean authenticate() {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        Object userObj = session.getAttribute("user");
        if (userObj instanceof User user) {
            // Only allow admins into CKFinder.
            return user.getRole() == 1;
        }

        return false;
    }
}
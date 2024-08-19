package fpt.hieunm.application.services.User;

import fpt.hieunm.application.models.pojo.User;

import java.util.List;

public interface UserService {

    public void registerUser(User user);

    public User getUser(String username, String password);

    public void updateUser(User user);

    public void saveUser(User user);

    User findByEmail(String email);

    List<User> findAllUsers();
}

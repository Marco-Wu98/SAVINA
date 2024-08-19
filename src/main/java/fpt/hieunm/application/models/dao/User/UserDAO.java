package fpt.hieunm.application.models.dao.User;

import fpt.hieunm.application.models.pojo.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserDAO {
    public List<User> getAllUsers();

    User getUser(String username, String password);

    void save(User user);

    User findByEmail(String email);

    User findByUserName(String userName);

    void updateUser(User user);
}

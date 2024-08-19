package fpt.hieunm.application.services.User;

import fpt.hieunm.application.models.dao.User.UserDAO;
import fpt.hieunm.application.models.pojo.CustomExceptions;
import fpt.hieunm.application.models.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDAO userDAO;

    @Override
    public void registerUser(User user) throws RuntimeException {
        // Kiểm tra xem email đã được sử dụng để đăng ký chưa
        User existingUserByEmail = userDAO.findByEmail(user.getEmail());
        if (existingUserByEmail != null) {
            throw new CustomExceptions.EmailAlreadyExistsException("Email đã được sử dụng để đăng ký");
        }

        // Kiểm tra xem username đã tồn tại chưa
        User existingUserByUsername = userDAO.findByUserName(user.getUserName());
        if (existingUserByUsername != null) {
            throw new CustomExceptions.UsernameAlreadyExistsException("Tên đăng nhập đã tồn tại");
        }
    }

    @Override
    public User getUser(String username, String password) {
        return userDAO.getUser(username, password);
    }

    @Override
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    @Override
    public void saveUser(User user) {
        userDAO.save(user);
    }

    @Override
    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    @Override
    public List<User> findAllUsers() {
        return userDAO.getAllUsers();
    }
}

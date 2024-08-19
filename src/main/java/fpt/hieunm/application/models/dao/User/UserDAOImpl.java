package fpt.hieunm.application.models.dao.User;

import fpt.hieunm.application.models.pojo.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public List<User> getAllUsers() {
        Session session = sessionFactory.getCurrentSession();
        Query<User> query = session.createQuery("from User", User.class);
        List<User> users = query.list();
        return users;
    }


    @Override
    @Transactional(readOnly = true)
    public User getUser(String username, String password) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from User where userName=:username and pwd=:password";
        Query<User> query = session.createQuery(hql, User.class);
        query.setParameter("username", username);
        query.setParameter("password", password);
        User user = query.uniqueResult();
        return user;
    }

    @Override
    @Transactional
    public void save(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.save(user);
    }

    @Override
    @Transactional
    public User findByEmail(String email) {
        User user = null;
        Session session = sessionFactory.getCurrentSession();
        String hql = "from User where email=:email";
        Query<User> query = session.createQuery(hql, User.class);
        query.setParameter("email", email);
        user = query.uniqueResult();
        return user;
    }

    @Override
    @Transactional
    public User findByUserName(String userName) {
        User user = null;
        Session session = sessionFactory.getCurrentSession();
        String hql = "from User where userName=:userName";
        Query<User> query = session.createQuery(hql, User.class);
        query.setParameter("userName", userName);
        user = query.uniqueResult();
        return user;
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
    }
}

package fpt.hieunm.application.models.dao.Cart;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.CartItem;
import fpt.hieunm.application.models.pojo.User;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class CartDAOImpl implements CartDAO {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    @Transactional
    public void add(User user, Book book, int quantity) {
        Session session = sessionFactory.getCurrentSession();
        CartItem cartItem = new CartItem();
        cartItem.setUser(user);
        cartItem.setBook(book);
        cartItem.setBuyQuantity(quantity);
        session.save(cartItem);
    }


    @Override
    @Transactional
    public Map<Book, Integer> getAllByUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from CartItem where user = :user";
        Query query = session.createQuery(hql, CartItem.class);
        query.setParameter("user", user);
        List<CartItem> cartItems = query.getResultList();
        Map<Book, Integer> resultMap = new HashMap<>();
        for (CartItem item : cartItems) {
            resultMap.put(item.getBook(), item.getBuyQuantity());
        }
        return resultMap;
    }


    // Sửa lần 1
    @Override
    @Transactional
    public boolean checkExistByBookId(User user, int bookId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "select count(*) from CartItem c where c.user = :user and c.book.id = :bookId";
        Long count = (Long) session.createQuery(hql)
                .setParameter("user", user)
                .setParameter("bookId", bookId)
                .uniqueResult();
        return count != null && count > 0;
    }

    @Override
    @Transactional
    public void updateToCart(User user, int bookId, int quantity) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from CartItem c where c.user = :user and c.book.id = :bookId";
        Query query = session.createQuery(hql, CartItem.class);
        query.setParameter("user", user);
        query.setParameter("bookId", bookId);
        CartItem cartItem = (CartItem) query.getSingleResult();
        cartItem.setBuyQuantity(cartItem.getBuyQuantity() + quantity);
        session.merge(cartItem);
    }

    @Override
    @Transactional
    public void deleteFromCart(User user, int bookId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from CartItem c where c.user = :user and c.book.id = :bookId";
        Query query = session.createQuery(hql, CartItem.class);
        query.setParameter("user", user);
        query.setParameter("bookId", bookId);
        CartItem cartItem = (CartItem) query.getSingleResult();
        session.delete(cartItem);
    }

    @Override
    @Transactional
    public void updateQuantity(User user, int bookId, int quantity) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from CartItem c where c.user = :user and c.book.id = :bookId";
        Query query = session.createQuery(hql, CartItem.class);
        query.setParameter("user", user);
        query.setParameter("bookId", bookId);
        CartItem cartItem = (CartItem) query.getSingleResult();
        cartItem.setBuyQuantity(quantity);
        session.merge(cartItem);
    }


}

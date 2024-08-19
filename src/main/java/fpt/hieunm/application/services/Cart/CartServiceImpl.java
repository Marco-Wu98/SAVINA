package fpt.hieunm.application.services.Cart;

import fpt.hieunm.application.models.dao.Book.BookDAO;
import fpt.hieunm.application.models.dao.Cart.CartDAO;
import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    CartDAO cartDAO;

    @Override
    public void add(User user, Book book, int quantity) {
        cartDAO.add(user, book, quantity);
    }


    @Override
    public Map<Book, Integer> getAllByUser(User user) {
        return cartDAO.getAllByUser(user);
    }

    @Override
    public boolean checkExistByBookId(User user, int bookId) {
        return cartDAO.checkExistByBookId(user, bookId);
    }

    @Override
    public void updateToCart(User user, int bookId, int quantity) {
        cartDAO.updateToCart(user, bookId, quantity);
    }

    @Override
    public void updateQuantity(User user, int bookId, int quantity) {
        cartDAO.updateQuantity(user, bookId, quantity);
    }

    @Override
    public void deleteFromCart(User user, int bookId) {
        cartDAO.deleteFromCart(user, bookId);
    }
}

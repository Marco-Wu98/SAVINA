package fpt.hieunm.application.models.dao.Cart;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.User;

import java.util.Map;

public interface CartDAO {
    void add(User user, Book book, int quantity);

    Map<Book, Integer> getAllByUser(User user);

    boolean checkExistByBookId(User user, int bookId);

    void updateToCart(User user, int bookId, int quantity);

    void deleteFromCart(User user, int bookId);

    void updateQuantity(User user, int bookId, int quantity);
}

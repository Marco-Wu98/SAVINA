package fpt.hieunm.application.services.Book;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.Subcategory;

import java.util.List;

public interface BookService {
    List<Book> getBooksBySubcategory(String subcategory, int page, int pageSize);

    long countBooksBySubcategory(String subcategory);

    List<Book> getBooksByCategory(String category, int page, int pageSize);

    long countBooksByCategory(String category);

    String formatSubcategory(String subcategory);

    byte[] getImageData(int bookId);

    List<Book> getBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher, int page, int pageSize);

    long countBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher);

    Book getBookById(int bookId);

    List<Book> getBooksBySubcategoryWithoutPagination(String subcategory);

    List<Book> searchBooks(String keyword);

    List<Book> getBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher, int page, int pageSize);

    long countBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher);

    List<Book> getArrangedBooksBySubcategory(String subcategory, int page, int pageSize, String option);

    List<Book> getArrangedBooksByCategory(String category, int page, int pageSize, String option);

    Subcategory getSubcategory(int subcategoryId);

    void saveBook(Book book);

    void deleteBook(int bookId);

    List<Book> findAllBooks();
}


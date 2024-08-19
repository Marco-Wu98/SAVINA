package fpt.hieunm.application.models.dao.Book;


import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.Subcategory;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface BookDAO {
    public List<Book> getAllBooks();

    List<Book> findBySubcategory(String subcategory, int firstResult, int maxResults);

    long countBySubcategory(String subcategory);

    //    ========================================================================

    List<Book> findByCategory(String category, int firstResult, int maxResults);

    long countByCategory(String category);

    //    ========================================================================


    byte[] getImageData(int bookId);

//    List<Book> findBySubcategoryWithPriceFilter(String subcategory, int minPrice, int maxPrice, int firstResult, int pageSize);
//
//    long countBySubcategoryWithPriceFilter(String subcategory, int minPrice, int maxPrice);

    List<Book> getBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher, int firstResult, int pageSize);

    long countBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher);

    List<Book> getBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, int firstResult, int pageSize);

    long countBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice);

    Book getBookById(int bookId);

    List<Book> getBooksBySubcategoryWithoutPagination(String subcategory);

    List<Book> searchBooks(String keyword);

    List<Book> getBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, int firstResult, int pageSize);

    long countBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice);

    List<Book> getBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher, int firstResult, int pageSize);

    long countBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher);

    List<Book> getArrangedBooksBySubcategory(String subcategory, int firstResult, int pageSize, String option);

    List<Book> getArrangedBooksByCategory(String category, int firstResult, int pageSize, String option);

   void saveBook(Book book);

   Subcategory getSubcategoryById(int subcategoryId);

   void deleteBookById(int bookId);
}

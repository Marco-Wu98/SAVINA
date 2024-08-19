package fpt.hieunm.application.models.dao.Book;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.Subcategory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class BookDAOImpl implements BookDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public List<Book> getAllBooks() {
        Session session = sessionFactory.getCurrentSession();
        Query<Book> query = session.createQuery("FROM Book", Book.class);
        return query.getResultList();
    }

    @Override

//    ========================================================================
    @Transactional
    public List<Book> findBySubcategory(String subcategory, int firstResult, int maxResults) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory";
        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("subcategory", subcategory);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        return query.list();
    }

    @Override
    @Transactional
    public long countBySubcategory(String subcategory) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(b) FROM Book b WHERE b.subcategory.subcategoryName = :subcategory";
        Query<Long> query = session.createQuery(hql, Long.class);
        query.setParameter("subcategory", subcategory);
        return query.getSingleResult();
    }

    //    ========================================================================
    @Override
    @Transactional
    public List<Book> findByCategory(String category, int firstResult, int maxResults) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Book b WHERE b.subcategory.category.categoryName = :category";
        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("category", category);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        return query.list();

    }

    @Override
    @Transactional
    public long countByCategory(String category) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(b) FROM Book b WHERE b.subcategory.category.categoryName = :category";
        Query<Long> query = session.createQuery(hql, Long.class);
        query.setParameter("category", category);
        return query.getSingleResult();
    }

//    ========================================================================


    @Override
    @Transactional
    public byte[] getImageData(int bookId) {
        Session session = sessionFactory.getCurrentSession();
        Book book = session.get(Book.class, bookId);
        if (book != null) {
            return book.getCoverImage();
        } else {
            return null;
        }
    }

//    @Override
//    @Transactional
//    public List<Book> findBySubcategoryWithPriceFilter(String subcategory, int minPrice, int maxPrice, int firstResult, int pageSize) {
//        Session session = sessionFactory.openSession();
//        String hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory AND (b.price * (1 - b.discount / 100.0)) BETWEEN :minPrice AND :maxPrice";
//        Query<Book> query = session.createQuery(hql, Book.class);
//        query.setParameter("subcategory", subcategory);
//        query.setParameter("minPrice", minPrice);
//        query.setParameter("maxPrice", maxPrice);
//        query.setFirstResult(firstResult);
//        query.setMaxResults(pageSize);
//
//        return query.list();
//
//    }
//
//    @Override
//    @Transactional
//    public long countBySubcategoryWithPriceFilter(String subcategory, int minPrice, int maxPrice) {
//        Session session = sessionFactory.getCurrentSession();
//        String hql = "SELECT COUNT(b) FROM Book b WHERE b.subcategory.subcategoryName = :subcategory AND (b.price * (1 - b.discount / 100.0)) BETWEEN :minPrice AND :maxPrice";
//        Query<Long> query = session.createQuery(hql, Long.class);
//        query.setParameter("subcategory", subcategory);
//        query.setParameter("minPrice", minPrice);
//        query.setParameter("maxPrice", maxPrice);
//        return query.getSingleResult();
//    }

//    ===========================================================

    @Override
    @Transactional
    public List<Book> getBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher, int firstResult, int pageSize) {
        Session session = sessionFactory.openSession();
        String hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory AND (b.price * (1 - b.discount / 100.0)) BETWEEN :minPrice AND :maxPrice AND b.publisher = :publisher";
        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("subcategory", subcategory);
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        query.setParameter("publisher", publisher);
        query.setFirstResult(firstResult);
        query.setMaxResults(pageSize);

        return query.list();
    }

    @Override
    @Transactional
    public long countBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(b) FROM Book b WHERE b.subcategory.subcategoryName = :subcategory AND (b.price * (1 - b.discount / 100.0)) BETWEEN :minPrice AND :maxPrice AND b.publisher = :publisher";
        Query<Long> query = session.createQuery(hql, Long.class);
        query.setParameter("subcategory", subcategory);
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        query.setParameter("publisher", publisher);
        return query.getSingleResult();
    }


    @Override
    @Transactional
    public List<Book> getBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, int firstResult, int pageSize) {
        Session session = sessionFactory.openSession();
        String hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory AND (b.price * (1 - b.discount / 100.0)) BETWEEN :minPrice AND :maxPrice";
        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("subcategory", subcategory);
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        query.setFirstResult(firstResult);
        query.setMaxResults(pageSize);

        return query.list();
    }

    @Override
    @Transactional
    public long countBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(b) FROM Book b WHERE b.subcategory.subcategoryName = :subcategory AND (b.price * (1 - b.discount / 100.0)) BETWEEN :minPrice AND :maxPrice";
        Query<Long> query = session.createQuery(hql, Long.class);
        query.setParameter("subcategory", subcategory);
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        return query.getSingleResult();
    }

    @Override
    @Transactional
    public Book getBookById(int bookId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM Book b WHERE b.id = :bookId";
        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("bookId", bookId);
        return query.getSingleResult();
    }

    @Override
    @Transactional
    public List<Book> getBooksBySubcategoryWithoutPagination(String subcategory) {
        Session session = sessionFactory.getCurrentSession();
        String sql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory";
        Query<Book> query = session.createQuery(sql, Book.class);
        query.setParameter("subcategory", subcategory);
        return query.list();
    }


    //    SEARCH BOOKS
    @Override
    @Transactional
    public List<Book> searchBooks(String keyword) {
        Session session = sessionFactory.getCurrentSession();
        String sql = "SELECT * FROM t_book WHERE title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE :keyword";
        NativeQuery<Book> query = session.createNativeQuery(sql, Book.class);
        query.setParameter("keyword", "%" + keyword + "%");
        return query.list();
    }

    @Override
    @Transactional
    public List<Book> getBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, int firstResult, int pageSize) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT * FROM t_book WHERE title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE :keyword AND (price * (1 - discount / 100.0)) BETWEEN :minPrice AND :maxPrice";
        NativeQuery<Book> query = session.createNativeQuery(hql, Book.class);
        query.setParameter("keyword", "%" + keyword + "%");
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        query.setFirstResult(firstResult);
        query.setMaxResults(pageSize);
        return query.list();
    }

    @Override
    @Transactional
    public long countBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(*) FROM t_book  WHERE title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE :keyword AND (price * (1 - discount / 100.0)) BETWEEN :minPrice AND :maxPrice";
        NativeQuery<Long> query = session.createNativeQuery(hql, Long.class);
        query.setParameter("keyword", "%" + keyword + "%");
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        return query.getSingleResult();
    }

    @Override
    @Transactional
    public List<Book> getBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher, int firstResult, int pageSize) {
        Session session = sessionFactory.openSession();
        String hql = "SELECT * FROM t_book WHERE title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE :keyword AND (price * (1 - discount / 100.0)) BETWEEN :minPrice AND :maxPrice AND publisher = :publisher";
        NativeQuery<Book> query = session.createNativeQuery(hql, Book.class);
        query.setParameter("keyword", "%" + keyword + "%");
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        query.setParameter("publisher", publisher);
        query.setFirstResult(firstResult);
        query.setMaxResults(pageSize);
        return query.list();
    }

    @Override
    @Transactional
    public long countBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(*) FROM t_book WHERE title COLLATE SQL_Latin1_General_CP1_CI_AI LIKE :keyword AND (price * (1 - discount / 100.0)) BETWEEN :minPrice AND :maxPrice AND publisher = :publisher";
        NativeQuery<Long> query = session.createNativeQuery(hql, Long.class);
        query.setParameter("keyword", "%" + keyword + "%");
        query.setParameter("minPrice", minPrice);
        query.setParameter("maxPrice", maxPrice);
        query.setParameter("publisher", publisher);
        return query.getSingleResult();
    }

    // Arrange
    @Override
    @Transactional
    public List<Book> getArrangedBooksBySubcategory(String subcategory, int firstResult, int maxResults, String option) {
        Session session = sessionFactory.getCurrentSession();
        String hql;
        if (option.equals("price-up")) {
            hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory ORDER BY b.price * (1 - b.discount / 100)";
        } else if (option.equals("price-down")) {
            hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory ORDER BY b.price * (1 - b.discount / 100) DESC";
        } else if (option.equals("discount")) {
            hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory ORDER BY b.discount";
        } else {
            hql = "FROM Book b WHERE b.subcategory.subcategoryName = :subcategory ORDER BY b.saleQuantity DESC";
        }

        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("subcategory", subcategory);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        return query.list();
    }

    @Override
    @Transactional
    public List<Book> getArrangedBooksByCategory(String category, int firstResult, int maxResults, String option) {
        Session session = sessionFactory.getCurrentSession();
        String hql;
        if (option.equals("price-up")) {
            hql = "FROM Book b WHERE b.subcategory.category.categoryName = :category ORDER BY b.price * (1 - b.discount / 100)";
        } else if (option.equals("price-down")) {
            hql = "FROM Book b WHERE b.subcategory.category.categoryName = :category ORDER BY b.price * (1 - b.discount / 100) DESC";
        } else if (option.equals("discount")) {
            hql = "FROM Book b WHERE b.subcategory.category.categoryName = :category ORDER BY b.discount";
        } else {
            hql = "FROM Book b WHERE b.subcategory.category.categoryName = :category ORDER BY b.saleQuantity DESC";
        }
        Query<Book> query = session.createQuery(hql, Book.class);
        query.setParameter("category", category);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        return query.list();
    }

    @Override
    @Transactional
    public void saveBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(book);
    }

    @Override
    @Transactional
    public Subcategory getSubcategoryById(int subcategoryId) {
        Session session = sessionFactory.getCurrentSession();
        Subcategory subcategory = session.get(Subcategory.class, subcategoryId);
        return subcategory;
    }

    @Override
    @Transactional
    public void deleteBookById(int bookId) {
        Session session = sessionFactory.getCurrentSession();
        Book book = session.get(Book.class, bookId);
        session.delete(book);
    }


}

package fpt.hieunm.application.models.dao.Subcategory;

import jakarta.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class SubcategoryDAOImpl implements SubcategoryDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public String getCategoryName(String subcategoryName) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "select sc.category.categoryName from Subcategory sc where sc.subcategoryName = :subcategoryName";
        Query query = session.createQuery(hql);
        query.setParameter("subcategoryName", subcategoryName);
        String categoryName = (String) query.getSingleResult();
        return categoryName;
    }
}

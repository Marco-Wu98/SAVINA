package fpt.hieunm.application.services.Subcategory;

import fpt.hieunm.application.models.dao.Subcategory.SubcategoryDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SubcategoryServiceImpl implements SubcategoryService {
    @Autowired
    SubcategoryDAO subcategoryDAO;

    @Override
    public String getCategoryName(String subcategoryName) {
        return subcategoryDAO.getCategoryName(subcategoryName);
    }
}

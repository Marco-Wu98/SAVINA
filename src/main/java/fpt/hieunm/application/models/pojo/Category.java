package fpt.hieunm.application.models.pojo;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "t_category")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "category_name")
    private String categoryName;

    @OneToMany(mappedBy = "category")
    private List<Subcategory> subcategories;
}

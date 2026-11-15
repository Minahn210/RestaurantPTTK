package model7;

import java.io.Serializable;

/**
 * Lớp thực thể DishCategory7 - loại món ăn. Ánh xạ bảng tblDishCategory7.
 */
public class DishCategory7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String description;

    public DishCategory7() {
    }

    public DishCategory7(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

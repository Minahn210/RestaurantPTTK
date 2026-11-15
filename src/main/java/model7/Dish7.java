package model7;

import java.io.Serializable;

/**
 * Lớp thực thể Dish7 - món ăn. Ánh xạ bảng tblDish7.
 * Thuộc tính đối tượng category: DishCategory7 (khóa ngoại tblDishCategory7id).
 */
public class Dish7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private float price;
    private String unit;
    private String description;
    private String image;
    private String status;
    private DishCategory7 category;

    public Dish7() {
    }

    public Dish7(String name, float price, String unit, String description, String image, String status,
            DishCategory7 category) {
        this.name = name;
        this.price = price;
        this.unit = unit;
        this.description = description;
        this.image = image;
        this.status = status;
        this.category = category;
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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public DishCategory7 getCategory() {
        return category;
    }

    public void setCategory(DishCategory7 category) {
        this.category = category;
    }
}

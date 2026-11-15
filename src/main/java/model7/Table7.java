package model7;

import java.io.Serializable;

/**
 * Lớp thực thể Table7 - bàn ăn. Ánh xạ bảng tblTable7.
 */
public class Table7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String location;
    private int capacity;
    private String description;

    public Table7() {
    }

    public Table7(int id, String name, String location, int capacity, String description) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.capacity = capacity;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

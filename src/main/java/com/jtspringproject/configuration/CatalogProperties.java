package com.jtspringproject.configuration;

import java.util.ArrayList;
import java.util.List;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "catalog")
public class CatalogProperties {

    private List<ProductEntry> products = new ArrayList<>();

    public List<ProductEntry> getProducts() { return products; }
    public void setProducts(List<ProductEntry> products) { this.products = products; }

    public static class ProductEntry {
        private String name;
        private String description;
        private int price;
        private int weight;
        private String category;
        private String image;

        public String getName()        { return name; }
        public void setName(String v)  { this.name = v; }

        public String getDescription()        { return description; }
        public void setDescription(String v)  { this.description = v; }

        public int getPrice()       { return price; }
        public void setPrice(int v) { this.price = v; }

        public int getWeight()       { return weight; }
        public void setWeight(int v) { this.weight = v; }

        public String getCategory()        { return category; }
        public void setCategory(String v)  { this.category = v; }

        public String getImage()        { return image; }
        public void setImage(String v)  { this.image = v; }
    }
}

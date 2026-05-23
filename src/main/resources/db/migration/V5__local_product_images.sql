-- V5: Switch all products to locally-served SVG images (no external URLs)

-- Fruits (category 1)
UPDATE PRODUCT SET image = '/images/fruits.svg'
WHERE category_id = 1;

-- Vegetables (category 2)
UPDATE PRODUCT SET image = '/images/vegetables.svg'
WHERE category_id = 2;

-- Meat (category 3)
UPDATE PRODUCT SET image = '/images/meat.svg'
WHERE category_id = 3;

-- Fish (category 4)
UPDATE PRODUCT SET image = '/images/fish.svg'
WHERE category_id = 4;

-- Dairy (category 5)
UPDATE PRODUCT SET image = '/images/dairy.svg'
WHERE category_id = 5;

-- Bakery (category 6)
UPDATE PRODUCT SET image = '/images/bakery.svg'
WHERE category_id = 6;

-- Drinks (category 7)
UPDATE PRODUCT SET image = '/images/drinks.svg'
WHERE category_id = 7;

-- Sweets (category 8)
UPDATE PRODUCT SET image = '/images/sweets.svg'
WHERE category_id = 8;

-- Other (category 9)
UPDATE PRODUCT SET image = '/images/other.svg'
WHERE category_id = 9;

-- V3: Additional sample products across all categories

INSERT INTO PRODUCT (description, image, name, price, quantity, weight, category_id) VALUES
-- Fruits (category 1)
('Sweet and tropical',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/800px-Red_Apple.jpg',
 'Banana', 2, 60, 120, 1),
('Rich in vitamins',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Oranges_and_orange_juice.jpg/800px-Oranges_and_orange_juice.jpg',
 'Orange', 3, 50, 180, 1),
('Juicy summer fruit',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Garden_strawberries_%28jul%29.jpg/800px-Garden_strawberries_%28jul%29.jpg',
 'Strawberries', 5, 30, 300, 1),

-- Vegetables (category 2)
('Crunchy and healthy',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Salad_garden_greens.jpg/800px-Salad_garden_greens.jpg',
 'Carrot', 2, 80, 200, 2),
('Fresh leafy greens',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Spinach_leaves.jpg/800px-Spinach_leaves.jpg',
 'Spinach', 3, 40, 150, 2),
('Garden fresh tomatoes',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Tomato_je.jpg/800px-Tomato_je.jpg',
 'Tomato', 2, 100, 250, 2),

-- Meat (category 3)
('Premium quality beef',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Standing_rib_roast.jpg/800px-Standing_rib_roast.jpg',
 'Beef Steak', 25, 20, 500, 3),
('Free-range chicken',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/A_small_cup_of_coffee.JPG/800px-A_small_cup_of_coffee.JPG',
 'Chicken Breast', 12, 35, 400, 3),

-- Fish (category 4)
('Wild-caught Atlantic salmon',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Altlantic_salmon.jpg/800px-Altlantic_salmon.jpg',
 'Salmon Fillet', 18, 25, 300, 4),
('Fresh white fish',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Dried_cod_on_a_rack.jpg/800px-Dried_cod_on_a_rack.jpg',
 'Cod Fillet', 14, 20, 350, 4),

-- Dairy (category 5)
('Organic whole milk',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Milk_glass.jpg/800px-Milk_glass.jpg',
 'Whole Milk', 2, 120, 1000, 5),
('Creamy Greek style',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Greekyogurt.jpg/800px-Greekyogurt.jpg',
 'Greek Yogurt', 3, 60, 500, 5),
('Aged cheddar',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Cheddar_cheese_medium_closeup.jpg/800px-Cheddar_cheese_medium_closeup.jpg',
 'Cheddar Cheese', 6, 45, 400, 5),

-- Bakery (category 6)
('Freshly baked sourdough',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Bread_and_grains.jpg/800px-Bread_and_grains.jpg',
 'Sourdough Bread', 4, 30, 800, 6),
('Buttery and flaky',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Croissant%2C_Sichuan_style.jpg/800px-Croissant%2C_Sichuan_style.jpg',
 'Croissant', 2, 50, 100, 6),

-- Drinks (category 7)
('Cold-pressed goodness',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Oranges_and_orange_juice.jpg/800px-Oranges_and_orange_juice.jpg',
 'Orange Juice', 3, 80, 1000, 7),
('Sparkling mineral water',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Fresh_made_lemonade_%282%29.jpg/800px-Fresh_made_lemonade_%282%29.jpg',
 'Sparkling Water', 1, 200, 500, 7),

-- Sweets (category 8)
('70% dark chocolate',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Chocolate_%28blue_background%29.jpg/800px-Chocolate_%28blue_background%29.jpg',
 'Dark Chocolate', 4, 55, 100, 8),
('Assorted flavors',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Gummy_bears.jpg/800px-Gummy_bears.jpg',
 'Gummy Bears', 2, 90, 200, 8),

-- Other (category 9)
('Extra virgin, cold pressed',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Olive_oil_from_Oneglia.jpg/800px-Olive_oil_from_Oneglia.jpg',
 'Olive Oil', 8, 40, 750, 9),
('Himalayan pink salt',
 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Salt_shaker_on_white_background.jpg/800px-Salt_shaker_on_white_background.jpg',
 'Pink Salt', 3, 70, 500, 9);

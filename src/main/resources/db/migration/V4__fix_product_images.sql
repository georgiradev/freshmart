-- V4: Fix broken and incorrect product image URLs

-- V2 products had dead external image links
UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/320px-Red_Apple.jpg'
WHERE name = 'Apple';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Egg_spiral_background_free.png/320px-Egg_spiral_background_free.png'
WHERE name = 'Cracked Eggs';

-- V3 Banana had an Apple image URL by mistake
UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Troisb.jpg/320px-Banana-Troisb.jpg'
WHERE name = 'Banana';

-- Fix other V3 products with wrong or low-quality images
UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Orange-Whole-%26-Split.jpg/320px-Orange-Whole-%26-Split.jpg'
WHERE name = 'Orange';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/PerfectStrawberry.jpg/320px-PerfectStrawberry.jpg'
WHERE name = 'Strawberries';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Farmer_brand_carrots.jpg/320px-Farmer_brand_carrots.jpg'
WHERE name = 'Carrot';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Tomato_je.jpg/320px-Tomato_je.jpg'
WHERE name = 'Tomato';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Chicken_Breast_-_Baked_%28cropped%29.jpg/320px-Chicken_Breast_-_Baked_%28cropped%29.jpg'
WHERE name = 'Chicken Breast';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Milk_glass.jpg/320px-Milk_glass.jpg'
WHERE name = 'Whole Milk';

UPDATE PRODUCT SET image = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Orange_juice_1_edit1.jpg/320px-Orange_juice_1_edit1.jpg'
WHERE name = 'Orange Juice';

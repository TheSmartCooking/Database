-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe_ingredient(1, 1, 2, 'g');
CALL insert_recipe_ingredient_by_name(1, 'Sugar', 1, 'tsp');
CALL insert_recipe_ingredients(
    2,
    '[{"ingredient_id": 1, "quantity": 2, "unit": "g"},' ||
    ' {"ingredient_id": 2, "quantity": 1, "unit": "tsp"}]'
);
CALL insert_recipe_ingredients_by_name(
    3,
    '[{"ingredient_name": "Salt", "quantity": 2, "unit": "g"},' ||
    ' {"ingredient_name": "Pepper", "quantity": 1, "unit": "tsp"}]'
);

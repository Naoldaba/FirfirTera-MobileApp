import { Category, Recipe } from '../../schemas/recipe.schema';

export const RecipeStub = (): Recipe => {
  return {
    name: 'Spaghetti Bolognese',
    description: 'Classic Italian pasta dish',
    cookTime: 30,
    people: 4,
    ingredients: ['Spaghetti', 'Tomato Sauce', 'Ground Beef'],
    steps: ['Boil water', 'Cook spaghetti', 'Prepare Bolognese sauce'],
    fasting: 'non-fasting',
    type: Category.DINNER,
    image: 'https://example.com/spaghetti-bolognese.jpg',
    cook_id: 'someCookId',
  };
};

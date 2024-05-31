import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Recipe } from '../schemas/recipe.schema';
import { Query } from 'express-serve-static-core';
import * as jwt from 'jsonwebtoken';
import { error } from 'console';

export interface JwtPayload {
  id: string;
  role: string | string[];
}

@Injectable()
export class RecipeService {
  constructor(
    @InjectModel(Recipe.name)
    private recipeModel: Model<Recipe>,
  ) {}

  async showAll(): Promise<Recipe[]> {
    const recipes = await this.recipeModel.find();
    return recipes;
  }

  async getSingleRecipe(recipeId: string) {
    console.log(recipeId);
    let recipe;
    try {
      recipe = await this.recipeModel.findById(recipeId).exec();
    } catch {
      throw new NotFoundException('Could not find recipe');
    }
    if (!recipe) {
      throw new NotFoundException('Could not find recipe');
    }
    return recipe;
  }

  async getRecipesByCookId(cookId: string): Promise<Recipe[]> {
    try {
      const recipes = await this.recipeModel.find({ cook_id: cookId }).exec();
      if (!recipes || recipes.length == 0) {
        throw new NotFoundException('No recipes found');
      }
      return recipes;
    } catch (error) {
      throw new NotFoundException('No recipes found');
    }
  }

  async getFasting(fasting) {
    let recipe;
    try {
      recipe = await this.recipeModel.find({ fasting: fasting });
    } catch {
      throw new NotFoundException('Recipe not found');
    }
    if (!recipe) {
      throw new NotFoundException('Recipe Not Found');
    }
    return recipe;
  }

  async getByType(type) {
    console.log(type);
    let recipe;
    try {
      recipe = await this.recipeModel.find({ type: type });
    } catch {
      throw new NotFoundException('Recipe not found');
    }
    if (!recipe) {
      throw new NotFoundException('Recipe Not Found');
    }
    return recipe;
  }

  async find(query: Query): Promise<Recipe[]> {
    console.log(query);
    try {
      const keyword: any = {};

      if (query.keyword) {
        keyword.name = {
          $regex: `${query.keyword}`,
          $options: 'i',
        };
        keyword.type = {
          $regex: `${query.category}`,
          $options: 'i',
        };
      }

      console.log(keyword);

      const recipes = await this.recipeModel.find(keyword);
      return recipes;
    } catch (error) {
      throw new NotFoundException('Recipe Not Found');
    }
  }

  async insertRecipe(
    recipe: Recipe,
    authorizationHeader: string,
  ): Promise<Recipe> {
    const decodedToken = await this.decodeToken(authorizationHeader);

    if (decodedToken.role.includes('cook')) {
      recipe.cook_id = decodedToken.id;
    } else {
      throw new UnauthorizedException(
        'Only cooks are allowed to create recipes',
      );
    }

    // Parse ingredients and steps from strings into arrays
    if (typeof recipe.ingredients === 'string') {
      recipe.ingredients = JSON.parse(recipe.ingredients);
    }
    if (typeof recipe.steps === 'string') {
      recipe.steps = JSON.parse(recipe.steps);
    }

    console.log(recipe);
    const createdRecipe = await this.recipeModel.create(recipe);
    return createdRecipe;
  }

  async searchByTitle(name: string): Promise<Recipe[]> {
    const recipes = await this.recipeModel.find({ name });
    if (!recipes || recipes.length === 0) {
      throw new NotFoundException('Recipe not found!');
    }

    return recipes;
  }

  async updateById(id: string, recipe: Recipe): Promise<Recipe> {
    const updatedRecipe = await this.recipeModel.findByIdAndUpdate(id, recipe, {
      new: true,
      runValidators: true,
    });

    if (!updatedRecipe) {
      throw new NotFoundException(`Could not find recipe with ID ${id}`);
    }

    return updatedRecipe;
  }

  async updateRecipe(
    recipeId,
    recipeName,
    recipeDesc,
    cooktime,
    people,
    steps,
    ings,
    fasting,
    type,
    image,
  ) {
    console.log(recipeId, recipeName);
    let updated;
    try {
      updated = await this.recipeModel.findById(recipeId);
    } catch {
      throw new NotFoundException('could not find reicpe');
    }
    if (recipeName) {
      updated.name = recipeName;
    }
    if (recipeDesc) {
      updated.description = recipeDesc;
    }
    if (cooktime) {
      updated.cookTime = cooktime;
    }
    if (people) {
      updated.people = people;
    }
    if (steps) {
      updated.steps = steps;
    }
    if (ings) {
      updated.ingredients = ings;
    }
    updated.fasting = fasting;
    if (type) {
      updated.type = type;
    }
    if (image) {
      updated.image = image;
    }
    updated.save();
    console.log(updated);
  }

  async deleteById(id: string): Promise<Recipe> {
    const deletedRecipe = await this.recipeModel.findByIdAndDelete(id).lean();

    if (!deletedRecipe) {
      throw new NotFoundException('Recipe not found!');
    }

    return deletedRecipe as Recipe;
  }

  private decodeToken(authorizationHeader: string): JwtPayload | null {
    if (authorizationHeader && authorizationHeader.startsWith('Bearer ')) {
      const token = authorizationHeader.substring(7);
      try {
        const decodedToken = jwt.verify(
          token,
          process.env.JWT_SECRET,
        ) as JwtPayload;
        return decodedToken;
      } catch (error) {
        console.error('Token verification failed:', error.message);
        throw new UnauthorizedException('Invalid token');
      }
    } else {
      throw new UnauthorizedException(
        'No JWT Token found in the Authorization header',
      );
    }
  }
}

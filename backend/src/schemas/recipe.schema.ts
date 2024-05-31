import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';

export enum Category {
  FASTING = 'Fasting',
  NON_FASTING = 'Non-Fasting',
  BREAKFAST = 'Breakfast',
  LUNCH = 'Lunch',
  SNACK = 'Snack',
  DINNER = 'Dinner',
}

@Schema({ timestamps: true })
export class Recipe {
  @Prop()
  name: string;

  @Prop()
  description: string;

  @Prop()
  cookTime: number;

  @Prop()
  people: number;

  @Prop([String])
  ingredients: string[];

  @Prop([String])
  steps: string[];

  @Prop()
  fasting: string;

  @Prop()
  type: Category;

  @Prop()
  image: string;

  @Prop()
  cook_id: string;
}

export const RecipeSchema = SchemaFactory.createForClass(Recipe);

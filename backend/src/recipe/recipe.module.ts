import { Module } from '@nestjs/common';
import { RecipeController } from './recipe.controller';
import { RecipeService } from './recipe.service';
import { MongooseModule } from '@nestjs/mongoose';
import { RecipeSchema } from '../schemas/recipe.schema';
import { UploadService } from '../Upload/upload.service';

@Module({
  imports: [MongooseModule.forFeature([{ name: 'Recipe', schema: RecipeSchema }])],
  controllers: [RecipeController],
  providers: [RecipeService,UploadService],
  exports:[RecipeService]
})
export class RecipeModule { }

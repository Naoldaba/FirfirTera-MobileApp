import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  Headers,
  UseGuards,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { RecipeService } from './recipe.service';
import { FileInterceptor } from '@nestjs/platform-express';
import { multerConfig } from '../Upload/multer.config';
import { UploadService } from '../Upload/upload.service';
import { Category, Recipe } from '../schemas/recipe.schema';
import { createRecipeDto, updateRecipeDto } from '../dto/recipe.dto';
import { Roles } from '../decorators/roles.decorator';
import { RolesGuard } from '../guards/roles.guard';
import { Query as ExpressQuery } from 'express-serve-static-core';
import { Role } from '../entities/role.enum';
import { AuthGuard } from '@nestjs/passport';

@Controller('recipes')
@UseGuards(AuthGuard('jwt'), RolesGuard)
export class RecipeController {
  constructor(
    private recipeService: RecipeService,
    private readonly uploadService: UploadService,
  ) {}

  @Get()
  async getAllRecipes(): Promise<Recipe[]> {
    return this.recipeService.showAll();
  }

  @Post('new')
  @UseInterceptors(FileInterceptor('image', multerConfig))
  @Roles(Role.COOK)
  @Roles(Role.ADMIN)
  async createRecipe(
    @Body('name') name: string,
    @Body('description') description: string,
    @Body('cookTime') cookTime: number,
    @Body('people') people: number,
    @Body('ingredients') ingredients: string[],
    @Body('steps') steps: string[],
    @Body('fasting') fasting: string,
    @Body('type') type: Category,
    @UploadedFile() file: Express.Multer.File,
    @Headers('Authorization') authorization: string,
  ): Promise<Recipe> {
    this.uploadService.uploadFile(file);

    console.log(
      'the file is that created',
      name,
      description,
      cookTime,
      people,
      ingredients,
      steps,
      fasting,
      type,
      file.path,
    );

    const serverBaseURL = 'https://2076-213-55-95-177.ngrok-free.app/uploads/';
    const filePath = `${serverBaseURL}${file.filename}`;
    const createdRecipe = await this.recipeService.insertRecipe(
      {
        name,
        description,
        cookTime,
        people,
        ingredients,
        steps,
        fasting,
        type,
        image: filePath,
        cook_id: '1',
      },
      authorization,
    );
    return createdRecipe;
  }

  @Get('query')
  async search(@Query() query: ExpressQuery): Promise<Recipe[]> {
    console.log(query);
    return this.recipeService.find(query);
  }

  @Get(':id')
  async getProduct(@Param('id') prodId: string) {
    console.log(prodId);
    return await this.recipeService.getSingleRecipe(prodId);
  }

  @Get('myrecipes/:cookId')
  @Roles(Role.COOK)
  async getRecipesByCookId(@Param('cookId') cookId: string): Promise<Recipe[]> {
    console.log(cookId);
    return this.recipeService.getRecipesByCookId(cookId);
  }

  @Get(':title')
  async searchRecipe(@Param('title') title: string): Promise<Recipe[]> {
    return this.recipeService.searchByTitle(title);
  }

  @Get('category/:fasting')
  async getFasting(@Param('fasting') fasting) {
    if (fasting === 'true' || fasting === 'false') {
      return await this.recipeService.getFasting(fasting);
    } else {
      return await this.recipeService.getByType(fasting);
    }
  }

  @Patch(':id')
  @UseInterceptors(FileInterceptor('image', multerConfig))
  @Roles(Role.COOK)
  @Roles(Role.ADMIN)
  async updateProduct(
    @Param('id') recipeId: string,
    @Body('name') recipeName: string,
    @Body('description') recipeDesc: string,
    @Body('cookTime') cooktime: number,
    @Body('people') people: number,
    @Body('steps') steps: string[],
    @Body('ingredients') ings: string[],
    @Body('fasting') fasting: string,
    @Body('type') type: Category,
    @UploadedFile() file: Express.Multer.File,
  ) {

      this.uploadService.uploadFile(file) 
      const serverBaseURL = 'https://2076-213-55-95-177.ngrok-free.app/uploads/';
      const image = `${serverBaseURL}${file.filename}`;
      console.log('the Id is:', recipeId);
      console.log('thumbs up')

      await this.recipeService.updateRecipe(
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
      );
    }

  @Delete(':id')
  @Roles(Role.COOK)
  async deleteRecipe(
    @Param('id')
    id: string,
  ): Promise<Recipe> {
    return this.recipeService.deleteById(id);
  }
}
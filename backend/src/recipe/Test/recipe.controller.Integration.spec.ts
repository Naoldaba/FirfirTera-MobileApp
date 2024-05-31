import { Test, TestingModule } from '@nestjs/testing';
import { Connection } from 'mongoose';
import { AppModule } from '../../app.module';
import { DatabaseService } from '../../database/database.service';
import { RecipeStub } from './recipe.stub';
import * as request from 'supertest';
import { HttpStatus, INestApplication } from '@nestjs/common';

describe('RecipeController (Integration with Guards)', () => {
  let app: INestApplication;
  let dbConnection: Connection;
  let authToken: string;

  beforeAll(async () => {
    const moduleRef: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleRef.createNestApplication();
    dbConnection = moduleRef
      .get<DatabaseService>(DatabaseService)
      .getDbHandle();

    await app.init();

    const signUpDto = {
      firstName: 'Chef',
      lastName: 'Cook',
      email: 'chef@example.com',
      password: 'password123',
      role: 'cook',
    };

    const response = await request(app.getHttpServer())
      .post('/auth/signup/cook')
      .send(signUpDto);

    console.log('Signup Status:', response.status);
    console.log('Signup Response:', response.body);
    authToken = await response.body.token;
  });

  afterAll(async () => {
    await dbConnection.collection('users').deleteMany({});

    await app.close();
  });
  afterEach(async () => {
    await dbConnection.collection('recipes').deleteMany({});
  });

  it('GET /recipes should return an array of recipes for a valid user', async () => {
    const response = await request(app.getHttpServer())
      .get('/recipes')
      .set('Authorization', `Bearer ${authToken}`);
    console.log('still here: ', authToken);
    expect(response.status).toBe(200);
    expect(Array.isArray(response.body)).toBe(true);
  });

  it('/recipes/query (GET) should return an array of recipes based on query parameters', async () => {
    // Assuming your query parameters, adjust accordingly
    const queryParams = {
      keyword: 'chicken',
      category: 'main',
    };

    const response = await request(app.getHttpServer())
      .get('/recipes?query')
      .set('Authorization', `Bearer ${authToken}`)
      .query(queryParams)
      .expect(HttpStatus.OK);

    // Assert your expectations based on the response
    expect(Array.isArray(response.body)).toBe(true);
  });

  it('/recipes/:id (GET) should return a recipe by ID', async () => {
    // Create a sample recipe and obtain its ID
    let sampleRecipe = RecipeStub();
    const insertedResult = await dbConnection
      .collection('recipes')
      .insertOne(sampleRecipe);

    const _id = insertedResult.insertedId;

    const response = await request(app.getHttpServer())
      .get(`/recipes/${_id}`)
      .set('Authorization', `Bearer ${authToken}`)
      .expect(HttpStatus.OK);

    // Assert your expectations based on the response
  });

  it('GET /recipes/:title should return recipes by title', async () => {
    const sampleRecipe = RecipeStub();
    await dbConnection.collection('recipes').insertOne(sampleRecipe);

    const response = await request(app.getHttpServer())
      .get(`/recipes/${sampleRecipe.name}`)
      .set('Authorization', `Bearer ${authToken}`)
      .expect(HttpStatus.NOT_FOUND);
  });

  it('GET /recipes/category/:fasting should return recipes by fasting or type', async () => {
    const sampleRecipe = RecipeStub();
    await dbConnection.collection('recipes').insertOne(sampleRecipe);

    const response = await request(app.getHttpServer())
      .get(`/recipes/category/${sampleRecipe.fasting}`)
      .set('Authorization', `Bearer ${authToken}`)
      .expect(HttpStatus.OK);

    expect(response.body).toHaveLength(1);
  });

  it('GET /recipes/category/:type should return recipes by type', async () => {
    const sampleRecipe = RecipeStub();
    await dbConnection.collection('recipes').insertOne(sampleRecipe);

    const response = await request(app.getHttpServer())
      .get(`/recipes/category/${sampleRecipe.type}`)
      .set('Authorization', `Bearer ${authToken}`)
      .expect(HttpStatus.OK);

    expect(response.body).toHaveLength(1);
  });

  it('GET /recipes/myrecipes/:cookId should return recipes for a cook user', async () => {
    const sampleRecipe = RecipeStub();
    await dbConnection.collection('recipes').insertOne(sampleRecipe);

    const response = await request(app.getHttpServer())
      .get(`/recipes/myrecipes/${sampleRecipe.cook_id}`)
      .set('Authorization', `Bearer ${authToken}`)
      .expect(HttpStatus.OK);
  });
  it('GET /recipes/myrecipes/:cookId should not return recipes for Regular  user', async () => {
    const sampleRecipe = RecipeStub();
    await dbConnection.collection('recipes').insertOne(sampleRecipe);
    const signUpDto = {
      firstName: 'Chef',
      lastName: 'Cook',
      email: 'chef@example.com',
      password: 'password123',
      role: 'normal',
    };

    let response = await request(app.getHttpServer())
      .post('/auth/signup/normal')
      .send(signUpDto);

    authToken = await response.body.token;
    response = await request(app.getHttpServer())
      .get(`/recipes/myrecipes/${sampleRecipe.cook_id}`)
      .set('Authorization', `Bearer ${authToken}`)
      .expect(401);
  });
});

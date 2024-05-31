import { Test, TestingModule } from '@nestjs/testing';
import { Connection } from 'mongoose';
import { AppModule } from '../../app.module';
import { DatabaseService } from '../../database/database.service';
import { RecipeStub } from '../../recipe/Test/recipe.stub';
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
    await app.close();
  });

  beforeEach(async () => {
    await dbConnection.collection('users').deleteMany({});
  });

  it('/auth/signup/cook (POST) should sign up a cook user', async () => {
    const signUpDto = {
      firstName: 'Chef',
      lastName: 'Cook',
      email: 'chef@example.com',
      password: 'password123',
      role: 'cook',
    };

    const response = await request(app.getHttpServer())
      .post('/auth/signup/cook')
      .send(signUpDto)
      .expect(201);

    expect(response.body).toHaveProperty('token');
  });

  it('/auth/signup/normal (POST) should sign up a cook user', async () => {
    const signUpDto = {
      firstName: 'Chef',
      lastName: 'Cook',
      email: `chef-${Date.now()}@example.com`,
      password: 'password123',
      role: 'normal',
    };

    const response = await request(app.getHttpServer())
      .post('/auth/signup/normal')
      .send(signUpDto)
      .expect(201);

    expect(response.body).toHaveProperty('token');
    console.log(response.body.token);
  });

  it('/auth/login (POST) should return a valid token on successful login', async () => {
    const loginDto = {
      email: 'test@example.com',
      password: 'testpassword',
    };

    // Assuming you have a signup endpoint to create a user for testing
    const signUpResponse = await request(app.getHttpServer())
      .post('/auth/signup/normal')
      .send({
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        password: 'testpassword',
        role: 'normal',
      });

    // Ensure that the user was successfully created
    expect(signUpResponse.status).toBe(HttpStatus.CREATED);

    // Attempt to log in with the created user's credentials
    const response = await request(app.getHttpServer())
      .post('/auth/login')
      .send(loginDto)
      .expect(HttpStatus.CREATED);

    // Ensure that the response contains a valid token
    expect(response.body).toHaveProperty('token');
  });

  it('/auth/login (POST) should return an error for invalid credentials', async () => {
    const invalidLoginDto = {
      email: 'nonexistent@example.com',
      password: 'invalidpassword',
    };

    // Attempt to log in with invalid credentials
    const response = await request(app.getHttpServer())
      .post('/auth/login')
      .send(invalidLoginDto)
      .expect(HttpStatus.UNAUTHORIZED);

    // Ensure that the response indicates an unauthorized status
    expect(response.status).toBe(HttpStatus.UNAUTHORIZED);
  });
});

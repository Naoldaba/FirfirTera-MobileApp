import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as express from 'express';
import { ValidationPipe } from '@nestjs/common';

const path = require('path');

async function bootstrap() {
  console.log('Creating Nest application...');
  const app = await NestFactory.create(AppModule);

  console.log('Enabling CORS...');
  app.enableCors({
    origin: '*',
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
  });

  console.log('Setting up global pipes...');
  app.useGlobalPipes(new ValidationPipe());

  console.log('Setting up static file serving...');
  app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
  app.use(express.json({ limit: '10mb' }));

  console.log('Setting up root route...');
  app.use('/', (req, res) => {
    res.send('Welcome');
  });

  console.log('Starting the application...');
  await app.listen(3000);
  console.log('Application started.');

  return app.getHttpAdapter().getInstance();
}

console.log('Bootstrap process starting...');
bootstrap();
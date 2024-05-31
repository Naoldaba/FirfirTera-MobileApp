import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as express from 'express';

import { Patch, ValidationPipe } from '@nestjs/common';
import { join } from 'path';
const path = require('path');

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: '*',
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
  });
  app.useGlobalPipes(new ValidationPipe());
  app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
  app.use(express.json({ limit: '10mb' }));

  await app.listen(3000).then(() => {
    'the surver is starting...';
  });
}
bootstrap();

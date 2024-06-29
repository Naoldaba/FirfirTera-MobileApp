import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as express from 'express';
import { ValidationPipe } from '@nestjs/common';
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

  app.use('/', (req, res) => {
    res.send('Welcome');
  });

  await app.listen(3000).then(()=>{console.log("server running on port ")});
  return app.getHttpAdapter().getInstance();
}

export default bootstrap();

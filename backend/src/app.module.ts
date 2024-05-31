import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { RecipeModule } from './recipe/recipe.module';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from './schemas/user.schema';
import { APP_GUARD, Reflector } from '@nestjs/core';
import { RolesGuard } from './guards/roles.guard';
import { JwtStrategy } from './auth/strategies/jwt.strategy';
import { UserModule } from './user/user.module';
import * as bodyParser from 'body-parser';
import { DatabaseModule } from './database/database.module';
import { CommentModule } from './comment/comment.module';
import { join } from 'path';
import { ServeStaticModule } from '@nestjs/serve-static';

// import { CorsModule } from '@nestjs/platform-express';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'uploads'),
      serveRoot: '/uploads',
    }),
    MongooseModule.forRoot(process.env.DB_URI),
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
    AuthModule,
    RecipeModule,
    CommentModule,
    UserModule,
    DatabaseModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
    Reflector,
    JwtStrategy,
  ],
})
export class AppModule {}

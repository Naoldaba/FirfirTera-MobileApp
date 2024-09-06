import {
  Body,
  Controller,
  Post,
  UnauthorizedException,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from '../dto/login.dto';
import { SignUpDto } from '../dto/signup.dto';
import e from 'express';
import { UploadService } from '../Upload/upload.service';
import { multerConfig } from '../Upload/multer.config';
import { FileInterceptor } from '@nestjs/platform-express';
import { title } from 'process';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private readonly uploadService: UploadService,
  ) {}

  @Post('signup')
  @UseInterceptors(FileInterceptor('image', multerConfig))
  async signUpNormal(
    @Body('role') role: string,
    @Body('bio') bio: string,
    @Body('firstName') firstName: string,
    @Body('lastName') lastName: string,
    @Body('email') email: string,
    @Body('password') password: string,
    @UploadedFile() file: Express.Multer.File,
  ): Promise<{ token: string }> {
    const filePath = await this.uploadService.uploadFile(file); 

    let role1 = [];
    if (!role || role === 'normal') {
      role1 = ['normal'];
    } else if (role === 'cook') {
      role1 = ['cook'];
    } else if (role === 'admin') {
      role1 = ['admin'];
    } else {
      throw new UnauthorizedException('Invalid role');
    }

    return this.authService.signUp({
      role: role1,
      bio,
      firstName,
      lastName,
      email,
      password,
      image: filePath, 
    });
  }

  @Post('signup/cook')
  signUpCook(@Body() signUpDto: SignUpDto): Promise<{ token: string }> {
    if (!signUpDto.role || signUpDto.role !== 'cook') {
      throw new UnauthorizedException('Invalid role');
    }
    signUpDto.role = ['cook'];
    return this.authService.signUp(signUpDto);
  }

  @Post('login')
  login(@Body() loginDto: LoginDto): Promise<{ token: string }> {
    return this.authService.login(loginDto);
  }
}

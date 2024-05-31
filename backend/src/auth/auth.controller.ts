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
import { UploadService } from 'src/Upload/upload.service';
import { multerConfig } from 'src/Upload/multer.config';
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
    this.uploadService.uploadFile(file);

    const serverBaseURL = 'http://10.0.2.2:3000/uploads/';
    const filePath = `${serverBaseURL}${file.filename}`;

    var role1 = [];
    if (!role || role == 'normal') {
      role1 = ['normal'];
      console.log('am here');
      return this.authService.signUp({
        role: role1,
        bio,
        firstName,
        lastName,
        email,
        password,
        image: filePath,
      });
    } else if (role == 'cook') {
      role1 = ['cook'];
      return this.authService.signUp({
        role: role1,
        bio,
        firstName,
        lastName,
        email,
        password,
        image: filePath,
      });
    } else if (role == 'admin') {
      role1 = ['admin'];
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
    throw new UnauthorizedException('Invalid role');
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

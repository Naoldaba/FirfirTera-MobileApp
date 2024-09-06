import {
  Controller,
  Param,
  Body,
  Delete,
  Get,
  Patch,
  UseGuards,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { UserService } from '../user/user.service';

import { User } from '../schemas/user.schema';
import { updateUserDto } from '../dto/update-user.dto';
import { AuthGuard } from '@nestjs/passport';
import { Role } from '../entities/role.enum';
import { Roles } from '../decorators/roles.decorator';
import { RolesGuard } from '../guards/roles.guard';
import { FileInterceptor } from '@nestjs/platform-express';
import { UploadService } from '../Upload/upload.service';
import { multerConfig } from '../Upload/multer.config';

@Controller('user')

@UseGuards(AuthGuard('jwt'), RolesGuard)
export class UserController {
  constructor(
    private readonly userService: UserService,
    private readonly uploadService: UploadService,
  ) {}

  @Get(':id')
  async getById(@Param('id') userId: string): Promise<User> {
    console.log('hi')
    return this.userService.getById(userId);
  }

  @Patch(':id')
  @UseInterceptors(FileInterceptor('image', multerConfig))
  async updateUser(
    @Param('id') userId: string,
    @Body('firstName') firstName: string,
    @Body('lastName') lastName: string,
    @Body('email') email: string,
    @UploadedFile() file: Express.Multer.File,
  ) {
    const imagePath = this.uploadService.uploadFile(file);
    try {
      this.userService.updateById(userId, firstName, lastName, email);
    } catch {
      throw new Error('could not update user');
    }
  }

  @Delete(':id')
  async deleteUser(@Param('id') userId: string): Promise<User> {
    console.log(userId);
    return this.userService.deleteById(userId);
  }

  // this route only works for admin
  @Get()
  @Roles(Role.EDIT, Role.CREATE, Role.DELETE, Role.ADMIN)
  async getAll(): Promise<User[]> {
    
    return this.userService.getAllUsers();
  }

  @Patch('changeRole/:id')
  @Roles(Role.ADMIN)
  async updateRole(@Param('id') userId: string, @Body('role') role: string) {
    try {
      this.userService.changeRole(userId, role);
    } catch {
      throw new Error('could not update role');
    }
  }
}

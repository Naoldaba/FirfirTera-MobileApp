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
import { UploadService } from '../Upload/upload.service';

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
  @Roles(Role.COOK)
  @Roles(Role.ADMIN)
  async updateUser(
    @Param('id') userId: string,
    @Body('firstName') firstName: string,
    @Body('lastName') lastName: string,
  ) : Promise<User> {
    try {
      const updated = this.userService.updateById(userId, firstName, lastName);
      return updated
    } catch {
      throw new Error('could not update user');
    }
  }

  @Delete(':id')
  async deleteUser(@Param('id') userId: string): Promise<User> {
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

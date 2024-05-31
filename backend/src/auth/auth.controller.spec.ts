import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { getModelToken } from '@nestjs/mongoose';
import { JwtService } from '@nestjs/jwt';
import { UnauthorizedException } from '@nestjs/common';
import { User } from '../schemas/user.schema';
import { SignUpDto } from '../dto/signup.dto';
import { LoginDto } from '../dto/login.dto';
import * as bcrypt from 'bcryptjs';
import { Model } from 'mongoose';

describe('AuthController', () => {
  let controller: AuthController;
  let authService: AuthService;
  let userModel: Model<User>;
  let jwtService: JwtService;

  const mockJwtService = {
    sign: jest.fn(),
  };

  const mockUserModel = {
    create: jest.fn(),
    findOne: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [
        AuthService,
        { provide: getModelToken(User.name), useValue: mockUserModel },
        { provide: JwtService, useValue: mockJwtService },
      ],
    }).compile();

    controller = module.get<AuthController>(AuthController);
    authService = module.get<AuthService>(AuthService);
    userModel = module.get<Model<User>>(getModelToken(User.name));
    jwtService = module.get<JwtService>(JwtService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('signUpNormal', () => {
    it('should create a normal user and return a token', async () => {
      const signUpDto: SignUpDto = {
        firstName: 'Abebe',
        lastName: 'Kebede',
        email: 'Abebe@example.com',
        password: 'passpass',
        role: 'normal',
        image: 'image of Abebe',
        bio: 'Bio of Abebe',
      };

      const createdUser = {
        ...signUpDto,
        _id: 'a uuid',
        password: await bcrypt.hash(signUpDto.password, 10),
      };

      mockUserModel.create.mockResolvedValue(createdUser);
      mockJwtService.sign.mockReturnValue('a jwt token');

      expect({ token: 'fjaks' }).toEqual({
        token: 'a jwt token',
        role: 'normal',
      });
    });
  });

  describe('signUpCook', () => {
    it('should create a cook user and return a token', async () => {
      const signUpDto: SignUpDto = {
        firstName: 'kebede',
        lastName: 'chala',
        email: 'kebede@example.com',
        password: 'passwordkebede',
        role: 'cook',
        image: 'kebede Title',
        bio: 'kebede Bio',
      };

      const createdUser = {
        ...signUpDto,
        _id: 'a uuid',
        password: await bcrypt.hash(signUpDto.password, 10),
      };

      mockUserModel.create.mockResolvedValue(createdUser);
      mockJwtService.sign.mockReturnValue('a jwt token');

      const result = await controller.signUpCook(signUpDto);

      expect(result).toEqual({ token: 'a jwt token', role: 'cook' });
    });
  });

  describe('login', () => {
    let loginDto: LoginDto;
    const password = 'passwordkebede';

    beforeAll(async () => {
      const hashedPassword = await bcrypt.hash(password, 10);
      loginDto = {
        email: 'kebede@example.com',
        password: hashedPassword,
      };
    });

    it('should throw UnauthorizedException if user is not found', async () => {
      mockUserModel.findOne.mockResolvedValue(null);

      await expect(controller.login(loginDto)).rejects.toThrow(
        UnauthorizedException,
      );
    });

    it('should throw UnauthorizedException if password is incorrect', async () => {
      const user = {
        _id: 'a uuid',
        role: ['user'],
        password: await bcrypt.hash('anotherpassword', 10),
      };

      mockUserModel.findOne.mockResolvedValue(user);

      await expect(controller.login(loginDto)).rejects.toThrow(
        UnauthorizedException,
      );
    });
  });
});

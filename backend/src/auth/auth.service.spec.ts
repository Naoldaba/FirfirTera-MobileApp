import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { getModelToken } from '@nestjs/mongoose';
import { JwtService } from '@nestjs/jwt';
import { UnauthorizedException, ConflictException } from '@nestjs/common';
import { User } from '../schemas/user.schema';
import * as bcrypt from 'bcryptjs';
import { Model } from 'mongoose';
import { MongoError } from 'mongodb';

describe('AuthService', () => {
  let service: AuthService;
  let jwtService: JwtService;
  let userModel: Model<User>;

  const mockJwtService = {
    sign: jest.fn(),
  };

  const mockUserModel = {
    create: jest.fn(),
    findOne: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: getModelToken(User.name), useValue: mockUserModel },
        { provide: JwtService, useValue: mockJwtService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    jwtService = module.get<JwtService>(JwtService);
    userModel = module.get<Model<User>>(getModelToken(User.name));
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  try {
    describe('signUp', () => {
      it('should create a user and return a token and role', async () => {
        const signUpDto = {
          firstName: 'Abebe',
          lastName: 'Kebede',
          email: 'Abebe@example.com',
          password: 'passpass',
          role: ['normal'],
          title: 'Title of Abebe',
          bio: 'Bio of Abebe',
          image: 'image of Abebe',
        };

        const createdUser = {
          ...signUpDto,
          _id: 'a uuid',

          password: await bcrypt.hash(signUpDto.password, 10),
        };

        mockUserModel.create.mockResolvedValue(createdUser);
        mockJwtService.sign.mockReturnValue('a jwt token');

        const result = await service.signUp(signUpDto);

        expect(result).toEqual({ token: 'a jwt token', role: signUpDto.role });
      });
    });
  } catch (error) {
    if (error instanceof MongoError && error.code === 11000) {
      throw new ConflictException('Email is already in use');
    } else {
      throw error;
    }
  }
});
describe('AuthService', () => {
  let service: AuthService;
  let jwtService: JwtService;
  let userModel: Model<User>;

  const mockJwtService = {
    sign: jest.fn(),
  };

  const mockUserModel = {
    findOne: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: getModelToken(User.name), useValue: mockUserModel },
        { provide: JwtService, useValue: mockJwtService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    jwtService = module.get<JwtService>(JwtService);
    userModel = module.get<Model<User>>(getModelToken(User.name));
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('login', () => {
    const loginDto = {
      email: 'test@example.com',
      password: 'password',
    };

    it('should login and return a token and role', async () => {
      const user = {
        _id: 'a uuid',
        role: ['user'],
        password: await bcrypt.hash('password', 10),
      };

      mockUserModel.findOne.mockResolvedValue(user);
      mockJwtService.sign.mockReturnValue('a jwt token');

      const result = await service.login(loginDto);

      expect(result).toEqual({ token: 'a jwt token', role: user.role });
    });

    it('should throw UnauthorizedException if user is not found', async () => {
      mockUserModel.findOne.mockResolvedValue(null);

      await expect(service.login(loginDto)).rejects.toThrow(
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

      await expect(service.login(loginDto)).rejects.toThrow(
        UnauthorizedException,
      );
    });
  });
});

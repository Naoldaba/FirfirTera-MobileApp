import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from '../schemas/user.schema';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';
import { SignUpDto } from '../dto/signup.dto';
import { LoginDto } from '../dto/login.dto';
import { MongoError } from 'mongodb';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name)
    private userModel: Model<User>,
    private jwtService: JwtService,
  ) {}

  async signUp(
    signUpDto: SignUpDto,
  ): Promise<{ token: string; role: string[]; id: string }> {
    const { firstName, lastName, email, password, role, image } = signUpDto;

    const hashedPassword = await bcrypt.hash(password, 10);

    try {
      const user = await this.userModel.create({
        firstName,
        lastName,
        email,
        password: hashedPassword,
        role: Array.isArray(role) ? role : [role],
        image,
      });

      const token = this.jwtService.sign({ id: user._id, role: user.role });

      return { token: token, role: user.role, id: user.id };
    } catch (error) {
      if (error instanceof MongoError && error.code === 11000) {
        throw new ConflictException('Duplicate email');
      }
      throw error;
    }
  }

  async login(
    loginDto: LoginDto,
  ): Promise<{ token: string; role: string[]; id: string }> {
    const { email, password } = loginDto;
    const user = await this.userModel.findOne({ email });
    if (!user) {
      throw new UnauthorizedException(
        'User is not registered yet please signup.',
      );
    }

    const isPasswordMatched = await bcrypt.compare(password, user.password);

    if (!isPasswordMatched) {
      throw new UnauthorizedException('Incorrect password!');
    }

    const token = this.jwtService.sign({ id: user._id, role: user.role });

    return { token: token, role: user.role, id: user.id };
  }
}

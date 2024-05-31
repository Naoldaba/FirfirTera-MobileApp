// upload.service.ts
import { Injectable, BadRequestException } from '@nestjs/common';
import { multerConfig } from './multer.config';
import { diskStorage } from 'multer';

@Injectable()
export class UploadService {
  async uploadFile(file: Express.Multer.File): Promise<string> {
    if (!file) {
      throw new BadRequestException('No file provided');
    }

    console.log('File path:', file.path);

    return file.path;
  }
}



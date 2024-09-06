import { BadRequestException, Injectable } from '@nestjs/common';

@Injectable()
export class UploadService {
  async uploadFile(file: Express.Multer.File): Promise<string> {
    if (!file) {
      throw new BadRequestException('No file provided');
    }

    const uploadedFile = (file as any);
    const url = uploadedFile.secure_url || uploadedFile.path;
    if (!url) {
      throw new BadRequestException('Upload failed');
    }
    return url;
  }
}

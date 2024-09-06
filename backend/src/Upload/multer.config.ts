import { ConfigModule } from '@nestjs/config';
import { v2 as cloudinary } from 'cloudinary'; 
import { CloudinaryStorage } from 'multer-storage-cloudinary';

ConfigModule.forRoot({
  envFilePath: '.env',
}),

cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.API_KEY,
  api_secret: process.env.API_SECRET,
});

const storage = new CloudinaryStorage({
  cloudinary: cloudinary, 
  params: async (req, file) => {
    return {
      folder: 'FirfirTera',
      format: 'jpg',
      public_id: Date.now() + '-' + file.originalname,
    };
  },
});

export const multerConfig = {
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5,  
  },
  fileFilter: (req, file, cb) => {
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
      cb(null, true); 
    } else {
      cb(null, false); 
    }
  },
};

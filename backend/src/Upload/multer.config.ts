import { diskStorage } from 'multer';

const multer = require("multer");
const path = require("path");

const uploadPath = path.join(__dirname, "..","..", "uploads");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(uploadPath, "/")); 
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)); 
  },
});
export const multerConfig = multer({
  storage: storage,
  // fileFilter: (req, file, cb) => {
  //   if (
  //     file.mimetype == "image/jpg" ||
  //     file.mimetype == "image/png" ||
  //     file.mimetype == "image/JPG"
  //   ) {
  //     cb(null, true);
  //   } else {
  //     console.log("The file type is must be png or jpg");
  //     cb(null, false);
  //   }
  // },
  limits: {
    fileSize: 1024 * 1024 * 5,
  },
});




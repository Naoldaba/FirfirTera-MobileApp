import { diskStorage } from 'multer';

// export const multerConfig = {
//   storage: diskStorage({
//     destination: 'http://localhost:3000/uploads',
//     filename: (req, file, callback) => {
//       const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
//       const extension = file.originalname.split('.').pop();
//       callback(null, file.fieldname + '-' + uniqueSuffix + '.' + extension);
//     },
//   }),
// };

const multer = require("multer");
const path = require("path");

const uploadPath = path.join(__dirname, "..","..", "uploads");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(uploadPath, "/")); // Full path including timestamp folder
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)); // Include file extension
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




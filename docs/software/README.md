# Реалізація інформаційного та програмного забезпечення


## SQL-скрипт для створення початкового наповнення бази даних

```sql
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Role` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Role` (
  `id` INT NOT NULL,
  `Rolecol` VARCHAR(45) NULL,
  `permission` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_Name` VARCHAR(45) NOT NULL,
  `last_Name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `Usercol_UNIQUE` (`password` ASC) VISIBLE,
  UNIQUE INDEX `last_Name_UNIQUE` (`last_Name` ASC) VISIBLE,
  UNIQUE INDEX `first_Name_UNIQUE` (`first_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Media` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Media` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `keywords` VARCHAR(45) NULL,
  `createdAt` DATE NULL,
  `updatedAt` DATE NULL,
  `User_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Media_User_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_Media_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `mydb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Admin` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Admin` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CommentModeration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CommentModeration` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CommentModeration` (
  `comment_Id` INT NOT NULL,
  `userId` INT NOT NULL,
  `moderatorId` INT NOT NULL,
  `moderationReason` VARCHAR(45) NULL,
  `moderationDate` DATE NULL,
  `moderationStatus` VARCHAR(45) NULL,
  PRIMARY KEY (`comment_Id`),
  INDEX `fk_CommentModeration_Admin1_idx` (`moderatorId` ASC) VISIBLE,
  INDEX `fk_CommentModeration_User1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_CommentModeration_Admin1`
    FOREIGN KEY (`moderatorId`)
    REFERENCES `mydb`.`Admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CommentModeration_User1`
    FOREIGN KEY (`userId`)
    REFERENCES `mydb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DeleteAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`DeleteAccount` ;

CREATE TABLE IF NOT EXISTS `mydb`.`DeleteAccount` (
  `id` INT NOT NULL,
  `userId` INT NULL,
  `reason` VARCHAR(45) NULL,
  `date` DATE NULL,
  `type` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `Admin_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_DeleteAccount_Admin1_idx` (`Admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_DeleteAccount_Admin1`
    FOREIGN KEY (`Admin_id`)
    REFERENCES `mydb`.`Admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UserRole` ;

CREATE TABLE IF NOT EXISTS `mydb`.`UserRole` (
  `User_id` INT NOT NULL,
  `User_id1` INT NOT NULL,
  `Role_id` INT NOT NULL,
  PRIMARY KEY (`User_id`),
  INDEX `fk_UserRole_User1_idx` (`User_id1` ASC) VISIBLE,
  INDEX `fk_UserRole_Role1_idx` (`Role_id` ASC) VISIBLE,
  CONSTRAINT `fk_UserRole_User1`
    FOREIGN KEY (`User_id1`)
    REFERENCES `mydb`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserRole_Role1`
    FOREIGN KEY (`Role_id`)
    REFERENCES `mydb`.`Role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Fill database with data
USE mybd;

START TRANSACTION;
-- Role
INSERT INTO `mydb`.`Role` (`id`, `Rolecol`, `permission`) VALUES
(1, 'Admin', 'Full Access'),
(2, 'Editor', 'Edit Content'),
(3, 'Viewer', 'View Content'),
(4, 'Moderator', 'Manage Comments'),
(5, 'Contributor', 'Submit Content');

-- User
INSERT INTO `User` (`id`,`first_Name`, `last_Name`, `email`, `password`) 
VALUES 
(1,'John', 'Doe', 'john.doe@example.com', 'password123'),
(2,'Jane', 'Smith', 'jane.smith@example.com', 'securepassword'),
(3,'Alice', 'Johnson', 'alice.johnson@example.com', 'mypassword'),
(4,'George', 'Joestar', 'George.Joestar@example.com', 'bestpassword'),
(5,'Nicole', 'Tesla', 'Nicole.Nesla@example.com', 'cringepassword');

-- Media
INSERT INTO `Media` (`id`,`title`,`keywords`,`createdAT`,`updatedAT`,`User_id`) 
VALUES
(1,'test.png','image','07-12','2020-08-12',1),
(2,'Metalica.mp3','Rock,music,guitar','07-12','2020-08-12',2),
(3,'message.txt','text','07-12','2019-03-7',3),
(4,'recipe.mp4','video,cooking','07-12','2019-01-01',4),
(5,'test.png','image','2018-06-11','2020-08-12',5);

--  Admin
INSERT INTO `mydb`.`Admin` (`id`, `name`) VALUES
(1, 'Super Admin'),
(2, 'Moderator Andryi'),
(3, 'Moderator Boris'),
(4, 'Deleted Admin 1'),
(5, 'Deleted Admin 2');

-- CommentModeration
INSERT INTO `mydb`.`CommentModeration` (`comment_Id`, `userId`, `moderatorId`, `moderationReason`, `moderationDate`, `moderationStatus`) VALUES
(1, 1, 2, 'Inappropriate Language', '2020-08-12', 'Removed'),
(2, 2, 1, 'Spam', '2024-11-13', 'Flagged'),
(3, 3, 3, 'Off-topic', '2020-08-12', 'Removed'),
(4, 4, 4, 'Hate Speech', '2019-01-01', 'Banned'),
(5, 5, 5, 'Misleading Info', '2020-08-12', 'Under Review');

INSERT INTO `mydb`.`DeleteAccount` (`id`, `userId`, `reason`, `date`, `type`, `description`, `Admin_id`) VALUES
(1, 3, 'Privacy Concerns', '2024-11-14', 'Permanent', 'User requested account deletion', 1),
(2, 2, 'Inactive Account', '2024-11-13', 'Temporary', 'Account marked as inactive', 2),
(3, 1, 'Too Many Emails', '2024-11-10', 'Temporary', 'User opted for temporary deactivation', 3),
(4, 4, 'Security Issues', '2024-10-01', 'Permanent', 'Security concerns raised by user', 4),
(5, 5, 'Other', '2024-09-15', 'Permanent', 'No specific reason provided', 5);

INSERT INTO `mydb`.`UserRole` (`User_id`, `User_id1`, `Role_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

COMMIT;
```

## RESTfull сервіс для управління даними
### Головний файл app.js
```js
const express = require("express");
const bodyParser = require("body-parser");
const mediaRoutes = require("./routes/mediaRoutes");
const userRoutes = require("./routes/userRoutes");
const roleRoutes = require("./routes/roleRoutes");

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());

// Routes
app.use("/api/media", mediaRoutes);
app.use("/api/user", userRoutes);
app.use("/api/role", roleRoutes);

// Error handling
app.use((err, req, res, next) => {
  res.status(err.status || 500).json({
    status: "error",
    message: err.message || "Internal Server Error",
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
```
### Підключення до бази даних
```js
const mysql = require("mysql2");

const conn = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "rootpass",
  database: "mydb",
});

conn.connect((err) => {
  if (err) {
    console.error("Error connecting to database:", err.message);
    process.exit(1);
  }
  console.log("Connected to database");
});

module.exports = conn;

```
### Контролери
#### User
```js
const conn = require("../db/connection");
const errorFactory = require("../middlewares/errorFactory");

exports.getAllUsers = (req, res, next) => {
    conn.query("SELECT * FROM User", (err, data) => {
        if (err) return next(errorFactory.databaseError(err.message));
        res.status(200).json({ status: "success", data });
      });
};

exports.addUser = (req, res, next) => {
  const { firstName, lastName, email, password } = req.body;
  if (!firstName || !lastName || !email || !password) {
    return next(errorFactory.validationError("All user fields are required"));
  }
  const query = "INSERT INTO User (firstName, lastName, email, password) VALUES (?, ?, ?, ?)";
  const values = [firstName, lastName, email, password];
  conn.query(query, values, (err, data) => {
    if (err) {
      return next(errorFactory.databaseError(err.message));
    }
    res.status(201).json({ status: "success", data });
  });
};

exports.getUserById = (req, res, next) => {
  conn.query("SELECT * FROM User WHERE id = ?", [req.params.id], (err, data) => {
    if (err) return next(errorFactory.databaseError(err.message));
    if (!data.length) return next(errorFactory.notFound("User not found"));
    res.status(200).json({ status: "success", data: data[0] });
  });
};

exports.deleteUser = (req, res, next) => {
  const userId = req.params.id;
  conn.query("DELETE FROM DeleteAccount WHERE userId = ?", [userId], (err) => {
    if (err) return next(errorFactory.databaseError(err.message));
    conn.query("DELETE FROM User WHERE id = ?", [userId], (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      if (data.affectedRows === 0) return next(errorFactory.notFound("User not found"));
      res.status(200).json({ status: "success", message: "User deleted successfully" });
    });
  });
};

exports.updateUser = (req, res, next) => {
  const userId = req.params.id;
  const { firstName, lastName, email, password } = req.body;
  if (!firstName || !lastName || !email || !password) {
    return next(errorFactory.validationError("All user fields are required"));
  }
  conn.query(
    "UPDATE User SET firstName = ?, lastName = ?, email = ?, password = ? WHERE id = ?",
    [firstName, lastName, email, password, userId],
    (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      if (data.affectedRows === 0) return next(errorFactory.notFound("User not found"));
      res.status(200).json({ status: "success", message: "User updated successfully" });
    }
  );
};
```
#### Media
```js
const conn = require("../db/connection");
const errorFactory = require("../middlewares/errorFactory");

exports.getAllMedia = (req, res, next) => {
  conn.query("SELECT * FROM Media", (err, data) => {
    if (err) return next(errorFactory.databaseError(err.message));
    res.status(200).json({ status: "success", data });
  });
};

exports.createMedia = (req, res, next) => {
  const { title, keywords, createdAt, updatedAt, userId } = req.body;
  if (!title || !keywords || !createdAt || !updatedAt || !userId) {
    return next(errorFactory.validationError("All media fields are required"));
  }
  conn.query(
    "INSERT INTO Media (title, keywords, createdAt, updatedAt, userId) VALUES (?)",
    [[title, keywords, createdAt, updatedAt, userId]],
    (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      res.status(201).json({ status: "success", data });
    }
  );
};

exports.getMediaById = (req, res, next) => {
  conn.query(
    "SELECT * FROM Media WHERE id = ?",
    [req.params.id],
    (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      if (!data.length) return next(errorFactory.notFound("Media not found"));
      res.status(200).json({ status: "success", data: data[0] });
    }
  );
};

exports.updateMedia = (req, res, next) => {
  const mediaId = req.params.id;
  const { title, keywords, updatedAt, userId } = req.body;
  if (!title || !keywords || !updatedAt || !userId) {
    return next(errorFactory.validationError("All fields except createdAt are required"));
  }
  conn.query(
    "UPDATE Media SET title = ?, keywords = ?, updatedAt = ?, userId = ? WHERE id = ?",
    [title, keywords, updatedAt, userId, mediaId],
    (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      if (data.affectedRows === 0) return next(errorFactory.notFound("Media not found"));
      res.status(200).json({ status: "success", message: "Media updated successfully" });
    }
  );
};

exports.deleteMedia = (req, res, next) => {
  const mediaId = req.params.id;
  conn.query("DELETE FROM Media WHERE id = ?", [mediaId], (err, data) => {
    if (err) return next(errorFactory.databaseError(err.message));
    if (data.affectedRows === 0) return next(errorFactory.notFound("Media not found"));
    res.status(200).json({ status: "success", message: "Media deleted successfully" });
  });
};
```
#### Role
```js
const conn = require("../db/connection");
const errorFactory = require("../middlewares/errorFactory");

exports.getAllRoles = (req, res, next) => {
  conn.query("SELECT * FROM Role", (err, data) => {
    if (err) return next(errorFactory.databaseError(err.message));
    res.status(200).json({ status: "success", data });
  });
};

exports.getRoleById = (req, res, next) => {
  const roleId = req.params.id;
  conn.query("SELECT * FROM Role WHERE id = ?", [roleId], (err, data) => {
    if (err) return next(errorFactory.databaseError(err.message));
    if (!data.length) return next(errorFactory.notFound("Role not found"));
    res.status(200).json({ status: "success", data: data[0] });
  });
};

exports.addRole = (req, res, next) => {
  const { roleName, permission } = req.body;
  if (!roleName || !permission) {
    return next(errorFactory.validationError("Role name and permission are required"));
  }
  conn.query(
    "INSERT INTO Role (roleName, permission) VALUES (?, ?)",
    [roleName, permission],
    (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      res.status(201).json({ status: "success", data });
    }
  );
};

exports.updateRole = (req, res, next) => {
  const roleId = req.params.id;
  const { roleName, permission } = req.body;
  if (!roleName || !permission) {
    return next(errorFactory.validationError("Role name and permission are required"));
  }
  conn.query(
    "UPDATE Role SET roleName = ?, permission = ? WHERE id = ?",
    [roleName, permission, roleId],
    (err, data) => {
      if (err) return next(errorFactory.databaseError(err.message));
      if (data.affectedRows === 0) return next(errorFactory.notFound("Role not found"));
      res.status(200).json({ status: "success", message: "Role updated successfully" });
    }
  );
};

exports.deleteRole = (req, res, next) => {
  const roleId = req.params.id;
  conn.query("DELETE FROM Role WHERE id = ?", [roleId], (err, data) => {
    if (err) return next(errorFactory.databaseError(err.message));
    if (data.affectedRows === 0) return next(errorFactory.notFound("Role not found"));
    res.status(200).json({ status: "success", message: "Role deleted successfully" });
  });
};
```
### Routes
#### User
```js
const express = require("express");
const userController = require("../controllers/userController");

const router = express.Router();

router.get("/", userController.getAllUsers);
router.post("/", userController.addUser);
router.get("/:id", userController.getUserById);
router.delete("/:id", userController.deleteUser);
router.put("/:id", userController.updateUser);

module.exports = router;
```
#### Media
```js
const express = require("express");
const mediaController = require("../controllers/mediaControllers");

const router = express.Router();

router.get("/", mediaController.getAllMedia);
router.get("/:id", mediaController.getMediaById);
router.post("/", mediaController.createMedia);
router.put("/:id", mediaController.updateMedia);
router.delete("/:id", mediaController.deleteMedia);

module.exports = router;
```
#### Role
```js
const express = require("express");
const router = express.Router();
const roleController = require("../controllers/roleController");

router.get("/", roleController.getAllRoles);
router.get("/:id", roleController.getRoleById);
router.post("/", roleController.addRole);
router.put("/:id", roleController.updateRole);
router.delete("/:id", roleController.deleteRole);

module.exports = router;
```
### Оброблення помилок
```js
exports.databaseError = (message) => ({
    status: 500,
    message: `Database error: ${message}`,
  });
  
  exports.validationError = (message) => ({
    status: 400,
    message: `Validation error: ${message}`,
  });
  
  exports.notFound = (message) => ({
    status: 404,
    message: `Not Found: ${message}`,
  });
```

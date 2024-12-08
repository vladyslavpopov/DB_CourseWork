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
  `id` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(45) NULL,
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
  `id` INT NOT NULL AUTO_INCREMENT,
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
USE mydb;

START TRANSACTION;
-- Role
INSERT INTO `mydb`.`Role` (`id`, `Role`, `permission`) VALUES
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
(1,'test.png','image','2024-07-12','2020-08-12',1),
(2,'Metalica.mp3','Rock,music,guitar','2024-07-12','2020-08-12',2),
(3,'message.txt','text','2024-07-12','2019-03-7',3),
(4,'recipe.mp4','video,cooking','2024-07-12','2019-01-01',4),
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
### Головний файл
```js
const express = require('express');
const userRoutes = require('./routes/userRoute');
const mediaRoutes = require('./routes/mediaRoute');
const roleRoutes = require('./routes/roleRoute');

const app = express();
const PORT = 3001;

app.use(express.json());

app.use('/api/users', userRoutes);
app.use('/api/media', mediaRoutes);
app.use('/api/roles', roleRoutes);

app.use((err, req, res, next) => {
    if (err.statusCode) {
      return res.status(err.statusCode).json({
        error: err.error,
        message: err.message,
        statusCode: err.statusCode,
      });
    }
    
    res.status(500).json({
      error: true,
      message: err.message || 'Internal server error',
      statusCode: 500,
    });
  });

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
```

### Підключення бази даних
```js
const mysql = require('mysql2/promise');

const db = mysql.createPool({
  host: 'localhost',
  user: 'root', 
  password: 'root1234', 
  database: 'mydb',
});

db.getConnection()
  .then(() => console.log('Database connected successfully'))
  .catch((err) => console.error('Database connection failed:', err));

module.exports = db;

```

### Обробник помилок
```js
function errorHandler(message) {
    const error = new Error(message || 'Internal Server Error');
    error.statusCode = 500;
    error.error = true;
    return error;
}
  
function notFoundHandler(message) {
    const error = new Error(message || 'Resource not found');
    error.statusCode = 404;
    error.error = true;
    return error;
}
  
function badRequestHandler(message) {
    const error = new Error(message || 'Bad request');
    error.statusCode = 400;
    error.error = true;
    return error;
}
    
module.exports = {
    errorHandler,
    notFoundHandler,
    badRequestHandler,
};
  
```

### Контролери додатка
#### UserController
```js
const db = require('../db'); 
const { badRequestHandler, notFoundHandler } = require('../errorHandler');

async function getAllUsers(req, res, next) {
  try {
    const [users] = await db.query('SELECT * FROM User');
    res.status(200).json({
      status: 'success', 
      data: users
    });
  } catch (err) {
    next(err);
  }
}

async function getUserById(req, res, next) {
  try {
    const { id } = req.params;
    const [user] = await db.query('SELECT * FROM User WHERE id = ?', [id]);
    
    if (user.length === 0) {
      return next(notFoundHandler('User not found')); 
    }

    res.status(200).json({
      status: 'succes',
      data: user[0]
    });
  } catch (err) {
    next(err);
  }
}

async function createUser(req, res, next) {
  try {
    const { first_Name, last_Name, email, password } = req.body;

    if (!first_Name || !last_Name || !email || !password) {
      return next(badRequestHandler('All fields are required'));
    }

    const result = await db.query(
      'INSERT INTO User (first_Name, last_Name, email, password) VALUES (?, ?, ?, ?)',
      [first_Name, last_Name, email, password]
    );

    res.status(201).json({ message: 'User created successfully', id: result[0].insertId });
  } catch (err) {
    next(err);
  }
}

async function updateUser(req, res, next) {
  try {
    const { id } = req.params;
    const { first_Name, last_Name, email, password } = req.body;

    if (!first_Name || !last_Name || !email || !password) {
      return next(badRequestHandler('All fields are required'));
    }

    const [result] = await db.query(
      'UPDATE User SET first_Name = ?, last_Name = ?, email = ?, password = ? WHERE id = ?',
      [first_Name, last_Name, email, password, id]
    );

    if (result.affectedRows === 0) {
      return next(badRequestHandler('User not found or no changes made'));
    }

    res.status(200).json({ message: 'User updated successfully' });
  } catch (err) {
    next(err);
  }
}

async function deleteUser(req, res, next) {
  try {
    const { id } = req.params;
    const [result] = await db.query('DELETE FROM User WHERE id = ?', [id]);

    if (result.affectedRows === 0) {
      return next(notFoundHandler('User not found'));
    }

    res.status(200).json({ message: 'User deleted successfully' });
  } catch (err) {
    next(err);
  }
}

module.exports = {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
};

```

#### MediaController
```js
const db = require('../db');
const { badRequestHandler, notFoundHandler } = require('../errorHandler');

async function getAllMedia(req, res, next) {
  try {
    const [media] = await db.query('SELECT * FROM Media');

    res.status(200).json({
        status: 'success', 
        data: media
      });
  } catch (err) {
    next(err);
  }
}

async function getMediaById(req, res, next) {
  try {
    const { id } = req.params;
    const [media] = await db.query('SELECT * FROM Media WHERE id = ?', [id]);

    if (media.length === 0) {
      return next(notFoundHandler('Media not found'));
    }

    res.status(200).json({
        status: 'succes',
        data: media[0]
      });
  } catch (err) {
    next(err);
  }
}

async function createMedia(req, res, next) {
  try {
    const { title, keywords, createdAt, updatedAt, User_id } = req.body;

    if (!title || !keywords || !User_id) {
      return next(badRequestHandler('Title, keywords, and User ID are required'));
    }

    const result = await db.query(
      'INSERT INTO Media (title, keywords, createdAt, updatedAt, User_id) VALUES (?, ?, ?, ?, ?)',
      [title, keywords, createdAt, updatedAt, User_id]
    );

    res.status(201).json({ message: 'Media created successfully', id: result[0].insertId });
  } catch (err) {
    next(err);
  }
}

async function updateMedia(req, res, next) {
  try {
    const { id } = req.params;
    const { title, keywords, createdAt, updatedAt, User_id } = req.body;

    if (!title || !keywords || !User_id) {
      return next(badRequestHandler('Title, keywords, and User ID are required'));
    }

    const [result] = await db.query(
      'UPDATE Media SET title = ?, keywords = ?, createdAt = ?, updatedAt = ?, User_id = ? WHERE id = ?',
      [title, keywords, createdAt, updatedAt, User_id, id]
    );

    if (result.affectedRows === 0) {
      return next(notFoundHandler('Media not found or no changes made'));
    }

    res.status(200).json({ message: 'Media updated successfully' });
  } catch (err) {
    next(err);
  }
}

async function deleteMedia(req, res, next) {
  try {
    const { id } = req.params;
    const [result] = await db.query('DELETE FROM Media WHERE id = ?', [id]);

    if (result.affectedRows === 0) {
      return next(notFoundHandler('Media not found'));
    }

    res.status(200).json({ message: 'Media deleted successfully' });
  } catch (err) {
    next(err);
  }
}

module.exports = {
  getAllMedia,
  getMediaById,
  createMedia,
  updateMedia,
  deleteMedia,
};

```

#### RoleController
```js
const db = require('../db');
const { badRequestHandler, notFoundHandler } = require('../errorHandler');

async function getAllRoles(req, res, next) {
  try {
    const [roles] = await db.query('SELECT * FROM Role');

    res.status(200).json({
        status: 'success',  
        data: roles
      });
  } catch (err) {
    next(err);
  }
}

async function getRoleById(req, res, next) {
  try {
    const { id } = req.params;
    const [roles] = await db.query('SELECT * FROM Role WHERE id = ?', [id]);

    if (roles.length === 0) {
      return next(notFoundHandler('Role not found'));
    }

    res.status(200).json({
        status: 'success',  
        data: roles[0]
      });
  } catch (err) {
    next(err);
  }
}

async function createRole(req, res, next) {
  try {
    const { Role, permission } = req.body;

    if (!Role || !permission) {
      return next(badRequestHandler('Role name and permission are required'));
    }

    const result = await db.query(
      'INSERT INTO Role (Role, permission) VALUES (?, ?)',
      [Role, permission]
    );

    res.status(201).json({ message: 'Role created successfully', id: result[0].insertId });
  } catch (err) {
    next(err);
  }
}

async function updateRole(req, res, next) {
  try {
    const { id } = req.params;
    const { Role: Role, permission } = req.body;

    if (!Role || !permission) {
      return next(badRequestHandler('Role name and permission are required'));
    }

    const [result] = await db.query(
      'UPDATE Role SET Role = ?, permission = ? WHERE id = ?',
      [Role, permission, id]
    );

    if (result.affectedRows === 0) {
      return next(notFoundHandler('Role not found or no changes made'));
    }

    res.status(200).json({ message: 'Role updated successfully' });
  } catch (err) {
    next(err);
  }
}

async function deleteRole(req, res, next) {
  try {
    const { id } = req.params;

    const [result] = await db.query('DELETE FROM Role WHERE id = ?', [id]);

    if (result.affectedRows === 0) {
      return next(notFoundHandler('Role not found'));
    }

    res.status(200).json({ message: 'Role deleted successfully' });
  } catch (err) {
    next(err);
  }
}

module.exports = {
  getAllRoles,
  getRoleById,
  createRole,
  updateRole,
  deleteRole,
};


```

### Маршрути додатка
#### UserRoute
```js
const express = require('express');
const {
  getAllUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
} = require('../controllers/userController');

const router = express.Router();

router.get('/', getAllUsers); 
router.get('/:id', getUserById); 
router.post('/', createUser); 
router.put('/:id', updateUser); 
router.delete('/:id', deleteUser); 

module.exports = router;

```

#### MediaRoute
```js
const express = require('express');
const {
  getAllMedia,
  getMediaById,
  createMedia,
  updateMedia,
  deleteMedia,
} = require('../controllers/mediaController');

const router = express.Router();

router.get('/', getAllMedia); 
router.get('/:id', getMediaById); 
router.post('/', createMedia); 
router.put('/:id', updateMedia); 
router.delete('/:id', deleteMedia); 

module.exports = router;

```

#### RoleRoute
```js
const express = require('express');
const {
  getAllRoles,
  getRoleById,
  createRole,
  updateRole,
  deleteRole,
} = require('../controllers/roleController');

const router = express.Router();

router.get('/', getAllRoles); 
router.get('/:id', getRoleById); 
router.post('/', createRole); 
router.put('/:id', updateRole); 
router.delete('/:id', deleteRole); 

module.exports = router;

```


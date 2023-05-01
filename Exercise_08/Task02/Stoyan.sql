CREATE DATABASE Test

USE Test

-- Users: уникален номер (id), email, парола, дата на регистрация.
CREATE TABLE Users(
    id INT PRIMARY KEY,
    email VARCHAR(50),
    password VARCHAR(50),
    reg_date DATETIME
)

-- Friends: двойки от номера на потребители, напр. ако 12 е приятел на 21, 25 и 40, ще има кортежи (12,21), (12,25), (12,40).
CREATE TABLE Friends(
    uid INT,
    friend_id INT,
    PRIMARY KEY(uid, friend_id),
    FOREIGN KEY(uid) REFERENCES Users(id),
    FOREIGN KEY(friend_id) REFERENCES Users(id)
);

-- Walls: номер на потребител, номер на потребител написал съобщението, текст на съобщението, дата.
CREATE TABLE Walls(
    uid INT,
    writer_id INT,
    message VARCHAR(100),
    date DATETIME,
    FOREIGN KEY(uid) REFERENCES Users(id),
    FOREIGN KEY(writer_id) REFERENCES Users(id)
);

-- Groups: уникален номер, име, описание (по подразбиране - празен низ).
CREATE TABLE Groups(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(100) DEFAULT ''
);

-- GroupMembers: двойки от вида номер на група - номер на потребител.
CREATE TABLE GroupMembers(
    group_id INT,
    uid INT,
    PRIMARY KEY(group_id, uid),
    FOREIGN KEY(group_id) REFERENCES Groups(id),
    FOREIGN KEY(uid) REFERENCES Users(id)
);

-- Изтрийте схемата, която сте създали в Задача 2.
DROP DATABASE Test

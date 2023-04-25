-- Нека създадем мини вариант на Facebook. Искаме да имаме следните релации (може да предложите и друг вариант):

-- Users: уникален номер (id), email, парола, дата на регистрация.
CREATE TABLE Users(
    id INT PRIMARY KEY,
    email VARCHAR(50),
    password VARCHAR(50),
    registration_date DATETIME
)

-- Friends: двойки от номера на потребители, напр. ако 12 е приятел на 21, 25 и 40, ще има кортежи (12,21), (12,25), (12,40).
CREATE TABLE Friends(
    user_id INT,
    friend_id INT,
    PRIMARY KEY(user_id, friend_id),
    FOREIGN KEY(user_id) REFERENCES Users(id),
    FOREIGN KEY(friend_id) REFERENCES Users(id)
)

-- Walls: номер на потребител, номер на потребител написал съобщението, текст на съобщението, дата.
CREATE TABLE Walls(
    user_id INT,
    writer_id INT,
    message VARCHAR(100),
    date DATETIME,
    FOREIGN KEY(user_id) REFERENCES Users(id),
    FOREIGN KEY(writer_id) REFERENCES Users(id)
)

-- Groups: уникален номер, име, описание (по подразбиране - празен низ).
CREATE TABLE Groups(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(100) DEFAULT ''
)

-- GroupMembers: двойки от вида номер на група - номер на потребител.
CREATE TABLE GroupMembers(
    group_id INT,
    user_id INT,
    PRIMARY KEY(group_id, user_id),
    FOREIGN KEY(group_id) REFERENCES Groups(id),
    FOREIGN KEY(user_id) REFERENCES Users(id)
)

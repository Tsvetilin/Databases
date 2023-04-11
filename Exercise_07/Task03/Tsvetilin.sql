--Извършете следните модификации в базата от данни Ships:
USE ships

--1. Два британски бойни кораба от класа Nelson - Nelson и Rodney - са били пуснати на вода
--едновременно през 1927 г. Имали са девет 16-инчови оръдия (bore) и водоизместимост от 34000
--тона (displacement). Добавете тези факти към базата от данни.
INSERT INTO SHIPS (NAME, CLASS, LAUNCHED) VALUES ('Nelson', 'Nelson', 1927), ('Rodney', 'Nelson', 1927)
INSERT INTO CLASSES (NUMGUNS, BORE, DISPLACEMENT, CLASS, TYPE, COUNTRY) VALUES (9, 16, 34000, 'Nelson', 'bb', 'Gt.Britain')

--2. Изтрийте от таблицата Ships всички кораби, които са потънали в битка.
DELETE FROM dbo.SHIPS WHERE dbo.SHIPS.NAME IN (SELECT dbo.OUTCOMES.SHIP FROM dbo.OUTCOMES WHERE dbo.OUTCOMES.RESULT='sunk')

--3. Променете данните в релацията Classes така, че калибърът (bore) да се измерва в сантиметри (в
--момента е в инчове, 1 инч ~ 2.5 см) и водоизместимостта да се измерва в метрични тонове (1 м.т. = 1.1 т.)
UPDATE dbo.CLASSES SET dbo.CLASSES.BORE=dbo.CLASSES.BORE*2.5, dbo.CLASSES.DISPLACEMENT=dbo.CLASSES.DISPLACEMENT*1.1
/* CUSTOMERS TABLOSUNDAN A HARF� �LE BA�LAYAN K���LER */
SELECT * FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%' 

/* CUSTOMERS TABLOSUNDAN ADI A HARF� �LE BA�LAYAN ERKEK M��TER�LER� �EK */
SELECT * FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%' AND GENDER = 'E' 

/* 1990 VE 1995 YILLARI ARASINDA DO�AN M��TER�LER� �EK�N�Z. 1990 VE 1995 YILLARI DAH�LD�R */

SELECT * FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '1990-01-01' AND  '1995-12-31' 

/* �STANBULDA YA�AYAN K���LER� JO�N KULLANARAK GET�R */

SELECT C.*, CT.CITIES FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID = CT.ID 
WHERE CT.CITIES = '�STANBUL'   


 /* �STANBULDA YA�AYAN K���LER� SUBQUERY KULLANARAK GET�R  */

 SELECT
 (SELECT CITIES FROM CITIES WHERE ID=C.CITYID),
 * FROM CUSTOMERS C  


 /* HANG� �EH�RDE KA� M��TER� VAR  */

SELECT CT.CITIES,COUNT(C.ID) FROM CUSTOMERS C 
RIGHT JOIN CITIES CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES 


/* 10 DAN FAZLA M��TER�M�Z OLAN �EH�RLER� M��TER� SAYISI �LE B�RL�KTE M��TER� SAYISINA G�RE
FAZLADAN AZA DO�RU SIRALA  */

SELECT CT.CITIES, COUNT(C.ID) AS CUSTOMERCOUNT FROM CUSTOMERS C
INNER JOIN CITIES  CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES
HAVING COUNT(C.ID) > 10
ORDER BY CUSTOMERCOUNT DESC 

/* HANG� �EH�RDE KA� ERKEK, KA� KADIN M��TER�M�Z�N OLDU�U B�LG�S�N� GET�R 

SELECT CT.CITIES,C.GENDER,COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
INNER JOIN CITIES CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES,C.GENDER
ORDER BY CT.CITIES,C.GENDER  */

SELECT CITIES AS SEHIRADI,
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID) AS MUSTERISAYISI,
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID AND GENDER = 'E') AS ERKEKSAYISI, 
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID AND GENDER = 'K') AS KADINSAYISI
FROM CITIES C 







 


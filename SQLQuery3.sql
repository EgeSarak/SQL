/* CUSTOMERS TABLOSUNDAN A HARFI ILE BA�LAYAN KI�ILER */
SELECT * FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%' 

/* CUSTOMERS TABLOSUNDAN ADI A HARFI ILE BA�LAYAN ERKEK MU�TERILERI �EK */
SELECT * FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%' AND GENDER = 'E' 

/* 1990 VE 1995 YILLARI ARASINDA DO�AN MU�TERILERI �EK�N�Z. 1990 VE 1995 YILLARI DAHILDIR */

SELECT * FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '1990-01-01' AND  '1995-12-31' 

/* ISTANBULDA YA�AYAN KI�ILERI JOIN KULLANARAK GETIR */

SELECT C.*, CT.CITIES FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID = CT.ID 
WHERE CT.CITIES = '�STANBUL'   


 /* ISTANBULDA YA�AYAN KI�ILERI SUBQUERY KULLANARAK GETIR  */

 SELECT
 (SELECT CITIES FROM CITIES WHERE ID=C.CITYID),
 * FROM CUSTOMERS C  


 /* HANGI �EHIRDE KA� MU�TERI VAR  */

SELECT CT.CITIES,COUNT(C.ID) FROM CUSTOMERS C 
RIGHT JOIN CITIES CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES 


/* 10 DAN FAZLA MU�TERIMIZ OLAN �EHIRLERI MU�TERI SAYISI ILE BIRLIKTE MU�TERI SAYISINA GORE
FAZLADAN AZA DOGRU SIRALA  */

SELECT CT.CITIES, COUNT(C.ID) AS CUSTOMERCOUNT FROM CUSTOMERS C
INNER JOIN CITIES  CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES
HAVING COUNT(C.ID) > 10
ORDER BY CUSTOMERCOUNT DESC 

/* HANGI �EHIRDE KA� ERKEK, KA� KADIN MU�TERIMIZIN OLDUGU BILGISINI GETIR 

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







 


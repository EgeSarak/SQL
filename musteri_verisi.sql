/* CUSTOMERS TABLOSUNDAN A HARFI ILE BASLAYAN KISILER */
SELECT * FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%' 

/* CUSTOMERS TABLOSUNDAN ADI A HARFI ILE BASLAYAN ERKEK MUSTERILERI CEK */
SELECT * FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%' AND GENDER = 'E' 

/* 1990 VE 1995 YILLARI ARASINDA DOGAN MUSTERILERI �EKINIZ. 1990 VE 1995 YILLARI DAHILDIR */

SELECT * FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '1990-01-01' AND  '1995-12-31' 

/* ISTANBULDA YASAYAN KISILERI JOIN KULLANARAK GETIR */

SELECT C.*, CT.CITIES FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID = CT.ID 
WHERE CT.CITIES = '�STANBUL'   


 /* ISTANBULDA YASAYAN KISILERI SUBQUERY KULLANARAK GETIR  */

 SELECT
 (SELECT CITIES FROM CITIES WHERE ID=C.CITYID),
 * FROM CUSTOMERS C  


 /* HANGI SEHIRDE KAC MUSTERI VAR  */

SELECT CT.CITIES,COUNT(C.ID) FROM CUSTOMERS C 
RIGHT JOIN CITIES CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES 


/* 10 DAN FAZLA MUSTERIMIZ OLAN SEHIRLERI MUSTERI SAYISI ILE BIRLIKTE MUSTERI SAYISINA GORE
FAZLADAN AZA DOGRU SIRALA  */

SELECT CT.CITIES, COUNT(C.ID) AS CUSTOMERCOUNT FROM CUSTOMERS C
INNER JOIN CITIES  CT ON CT.ID = C.CITYID
GROUP BY CT.CITIES
HAVING COUNT(C.ID) > 10
ORDER BY CUSTOMERCOUNT DESC 

/* HANGI SEHIRDE KA� ERKEK, KA� KADIN MUSTERIMIZIN OLDUGU BILGISINI GETIR 

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


/* CUSTOMERS TABLOSUNDA K� AGEGROUP ALANINI 20-35, 36-45, 46-55, 55-65
VE 65 YAS USTU OLARAK GUNCELLE  */

SELECT 
*,DATEDIFF(YEAR,BIRTHDATE,GETDATE()) FROM CUSTOMERS
UPDATE CUSTOMERS SET AGEGROUP='56-65 YAS'
WHERE DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 56 AND 65 

/* CUSTOMERS TABLOSUNDA MUSTER�N�N YASINA GORE HESAPLAYARAK SONUC GETIRIN 

SELECT AGEGROUP,COUNT(*) FROM CUSTOMERS
GROUP BY AGEGROUP
ORDER BY AGEGROUP */

SELECT 
CASE 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI' 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI' 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI' 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) > 65 THEN '65 YAS USTU' 
END AGEGROUP,
COUNT(*) CUSTOMERCOUNT
FROM CUSTOMERS
GROUP BY
CASE 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI' 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI' 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI' 
	WHEN DATEDIFF(YEAR,BIRTHDATE,GETDATE()) > 65 THEN '65 YAS USTU' 
END

ORDER BY AGEGROUP 

/* ISTANBULDA YASAYIP ILCESI KADIKOY DISINDA OLANLARI LISTELE */

SELECT * FROM CUSTOMERS C
INNER JOIN CITIES CT ON CT.ID =C.CITYID
INNER JOIN DISTRICTS D ON D.ID = C.DISTRICTID
WHERE CT.CITIES ='�STANBUL' AND D.DISTRICT ='KADIK�Y' 






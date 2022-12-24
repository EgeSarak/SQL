/* ARAC MARKALARINA GORE HER MARKADAN NE KADAR ARARC OLDUGU BILGISI */

SELECT BRAND, COUNT(*) AS COUNT_ FROM WEBOFFERS
GROUP BY BRAND
ORDER BY COUNT_ DESC  

/* ARAC MARKALRINA GORE HER MARKADAN NE KADAR ARAC OLDUGU VE YUZDESEL OLARAK 
TOPLAMIN NE KADARINA TEKABUL ETTIGI BILGISINI GETIR */

SELECT BRAND, COUNT(*) AS COUNT_, 
ROUND(
CONVERT(FLOAT,COUNT(*))/(SELECT COUNT(*) FROM WEBOFFERS)*100,2
) AS PERCENT_

FROM WEBOFFERS
GROUP BY BRAND
ORDER BY COUNT_ DESC  


/* HANGI SEHIRDE NE KADAR ARAC ILANI OLDUGU BILGISINI GETIREN SORGU */

SELECT C.CITY,COUNT(O.ID) AS COUNT_ FROM WEBOFFERS O
INNER JOIN USER_ U ON U.ID = O.USERID
INNER JOIN CITY C ON C.ID = O.CITYID
INNER JOIN TOWN T ON T.ID = O.TOWNID
INNER JOIN DISTRICT D ON D.ID = O.DISTRICTID
GROUP BY C.CITY
ORDER BY  COUNT_ DESC 

/* ISTANBULDA VOLKSWAGEN PASSAT MARKA BIR ARAC ARIYORUZ.
KRITERLERIMIZ SU SEKILDE
KIMDEN: SAHIBINDEN
MODEL: 2014-2018 ARASI
VITES: OTOMATIK
YAKIT: DIZEL
SIRALAMA: KILOMETRE VE FIYATA GORE */

SELECT U.NAMESURNAME, C.CITY, T.TOWN, D.DISTRICT,
O.TITLE, O.BRAND, O.MODEL,O.PRICE,O.YEAR_,O.KM, O.FUEL,O.SHIFTTYPE,O.COLOR,O.VARYANT

FROM WEBOFFERS O
INNER JOIN USER_ U ON U.ID = O.USERID
INNER JOIN CITY C ON C.ID = O.CITYID
INNER JOIN TOWN T ON T.ID = O.TOWNID
INNER JOIN DISTRICT D ON D.ID = O.DISTRICTID
WHERE C.CITY = '�STANBUL'
AND O.SHIFTTYPE IN ('Yar� Otomatik Vites','Otomatik Vites')
AND O.BRAND = 'Volkswagen' AND O.MODEL = 'Passat'
AND O.FUEL = 'Dizel' AND O.FROMWHO = 'Sahibinden'
AND O.YEAR_ BETWEEN 2014 AND 2018
ORDER BY KM,PRICE   

/* BMW MARKA ARACLARI ANKARA,ISTANBUL VE IZMIRDE LISTELETTIREN SORGU GETIR
BURADA ISIMLERI TEKERE TEKER DEGIL VIRGUL ILE BIRLESTIREREK GETIRCEM
ORN : 'ANKARA,ISTNABUL,IZMIR' */

SELECT U.NAMESURNAME, C.CITY, T.TOWN, D.DISTRICT,
O.TITLE, O.BRAND, O.MODEL,O.PRICE,O.YEAR_,O.KM, O.FUEL,O.SHIFTTYPE,O.COLOR,O.VARYANT

FROM WEBOFFERS O
INNER JOIN USER_ U ON U.ID = O.USERID
INNER JOIN CITY C ON C.ID = O.CITYID
INNER JOIN TOWN T ON T.ID = O.TOWNID
INNER JOIN DISTRICT D ON D.ID = O.DISTRICTID
WHERE O.BRAND = 'BMW'
AND C.CITY IN 
(SELECT value FROM string_split('ANKARA,�STANBUL,�ZM�R',','))
AND COLOR IN
(SELECT VALUE FROM string_split('Siyah,f�me,beyaz,gri',','))

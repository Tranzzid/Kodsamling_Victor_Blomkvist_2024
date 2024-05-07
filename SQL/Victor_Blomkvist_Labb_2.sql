-- Uppgift 1
SELECT * FROM kund

SELECT username, passwd, fnamn, enamn, yrke, regdatum, årslön FROM kund
ORDER by LOWER(enamn) ASC;

-- uppgift 2
SELECT username, passwd, fnamn, enamn, yrke, regdatum, årslön FROM kund
ORDER by LOWER(enamn) DESC;

-- uppgift 3
SELECT COUNT(*) FROM kund;

-- Uppgift 4
SELECT COUNT(årslön) FROM kund
WHERE årslön > 300000;

-- Uppgift 5
SELECT COUNT(årslön) FROM kund
WHERE årslön < 300000;

-- Uppgift 6
SELECT AVG(NVL(årslön,0)) as "Medellön"
FROM kund;

-- Uppgift 7
SELECT username, fnamn, enamn, NVL(årslön,0) as årslön
FROM kund
WHERE NVL(årslön,0) < (Select AVG(NVL(årslön,0)) FROM kund);

-- Uppgift 8
SELECT UPPER(fnamn) as fnamn, UPPER(enamn) as enamn
FROM kund 
WHERE UPPER(enamn) LIKE '%S%';

-- Uppgift 9
SELECT LOWER(fnamn) as fnamn, LOWER(enamn) as enamn, LOWER(NVL(yrke,'arbetsfri')) as yrke
FROM kund 
WHERE LOWER(fnamn) LIKE '%s';

-- Uppgift 10
SELECT INITCAP(NVL(yrke, 'arbetsfri')) as yrke, COUNT(*) as antal
from kund
GROUP BY INITCAP(NVL(yrke, 'arbetsfri'))
ORDER BY INITCAP(NVL(yrke, 'arbetsfri'));

-- Uppgift 11
SELECT INITCAP(fnamn)||' '|| INITCAP(enamn) as kundnamn
FROM kund;

-- Uppgift 12
SELECT COUNT(username) as "inloggad"
FROM kund
WHERE username = 'King25'
AND passwd = 'asdf1234';

-- Uppgift 13
SELECT COUNT(username) as "inloggad"
FROM kund
WHERE username = 'KING25'
AND passwd = 'ASDF1234';

-- Uppgift 14
SELECT username, passwd, TO_CHAR(regdatum, 'YYYY-MM-DD') as regdatum
FROM kund
WHERE TO_CHAR(regdatum, 'YYYY') < '2000';

-- Uppgift 15
SELECT username, passwd, TO_CHAR(regdatum, 'YYYY-MM-DD') as regdatum
FROM kund
WHERE regdatum BETWEEN TO_DATE('2001-01-01', 'YYYY-MM-DD') AND TO_DATE('2003-10-01', 'YYYY-MM-DD');

-- Uppgift 16
SELECT username, passwd, fnamn, enamn
FROM kund
WHERE LOWER(enamn) IN('nyberg', 'kvist')
AND LOWER(fnamn) <> 'roger';

-- Uppgift 17
SELECT fnamn, enamn, årslön
FROM kund
WHERE årslön = (SELECT MAX(årslön) FROM kund);

-- Uppgift 18
SELECT fnamn, enamn, årslön
FROM kund
WHERE årslön = (SELECT MIN(årslön) FROM kund);

-- Uppgift 19
SELECT fnamn, enamn
FROM kund
WHERE yrke IS NULL;
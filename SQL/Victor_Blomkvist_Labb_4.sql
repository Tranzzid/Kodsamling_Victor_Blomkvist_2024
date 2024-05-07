-- Uppgift 1
declare
v_regnr fordon.regnr%TYPE;
v_tillverkare fordon.tillverkare%TYPE;
v_modell fordon.modell%TYPE;

BEGIN
SELECT UPPER(regnr), tillverkare, modell 
INTO v_regnr,v_tillverkare, v_modell
FROM fordon
WHERE pnr = '19650823-7999';

DBMS_OUTPUT.PUT_LINE('Regnr: '||v_regnr);
DBMS_OUTPUT.PUT_LINE('Tillverkare: '||v_tillverkare);
DBMS_OUTPUT.PUT_LINE('Modell: '||v_Modell);
END;

-- Uppgift 2
declare
v_regnr fordon.regnr%TYPE;
v_tillverkare fordon.tillverkare%TYPE;
v_modell fordon.modell%TYPE;

BEGIN
SELECT UPPER(regnr), tillverkare, modell 
INTO v_regnr,v_tillverkare, v_modell
FROM fordon
WHERE pnr = '19540201-4428';

DBMS_OUTPUT.PUT_LINE('Regnr: '||v_regnr);
DBMS_OUTPUT.PUT_LINE('Tillverkare: '||v_tillverkare);
DBMS_OUTPUT.PUT_LINE('Modell: '||v_Modell);

EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Något blev fel!');
END;

-- Uppgift 3
declare
v_regnr fordon.regnr%TYPE;
v_tillverkare fordon.tillverkare%TYPE;
v_modell fordon.modell%TYPE;

BEGIN
SELECT UPPER(regnr), tillverkare, modell 
INTO v_regnr,v_tillverkare, v_modell
FROM fordon
WHERE pnr = '19540201-4428';

DBMS_OUTPUT.PUT_LINE('Regnr: '||v_regnr);
DBMS_OUTPUT.PUT_LINE('Tillverkare: '||v_tillverkare);
DBMS_OUTPUT.PUT_LINE('Modell: '||v_Modell);

EXCEPTION
WHEN OTHERS THEN

DBMS_OUTPUT.PUT_LINE('Något blev fel!');
DBMS_OUTPUT.PUT_LINE('Felkod: '||SQLCODE);
DBMS_OUTPUT.PUT_LINE('Felmeddelande: '||SQLERRM);
END;

-- Uppgift 4
DECLARE
v_fnamn bilägare.fnamn%TYPE
v_enamn bilägare.enamn%TYPE
v_ålder bilägare.pnr%TYPE

BEGIN
SELECT fnamn, enamn, TO_DATE(SUBSTR(pnr,1,8),'YYYY-MM-DD')
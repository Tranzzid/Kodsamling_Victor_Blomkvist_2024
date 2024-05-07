-- Uppgift 1
CREATE TABLE bankkund (
pnr VARCHAR2(11),
fnamn VARCHAR2(25) NOT NULL,
enamn VARCHAR2(25) NOT NULL,
passwd VARCHAR2(16) NOT NULL
);

ALTER TABLE bankkund
ADD CONSTRAINTS nakkund_pnr_pk PRIMARY KEY(pnr)
;

CREATE TABLE kontotyp(
ktnr NUMBER(6),
ktnamn VARCHAR2(20) NOT NULL,
ränta NUMBER(5,2) NOT NULL
);

ALTER TABLE kontotyp
ADD CONSTRAINTS kontotyp_ktnr_pk PRIMARY KEY(ktnr)
;

CREATE TABLE ränteändring(
rnr NUMBER(6),
ktnr NUMBER(6) NOT NULL,
ränta NUMBER(5,2) NOT NULL,
rnr_datum DATE NOT NULL
);

ALTER TABLE ränteändring
ADD CONSTRAINTS ränteändring_rnr_pk PRIMARY KEY(rnr)
ADD CONSTRAINTS ränteändring_ktnr_fk FOREIGN KEY(ktnr) REFERENCES kontotyp(ktnr)
;

CREATE TABLE konto(
knr NUMBER(8),
ktnr NUMBER(6) NOT NULL,
regdatum DATE NOT NULL,
saldo NUMBER(10,2)
);

ALTER TABLE konto
ADD CONSTRAINTS konto_knr_pk PRIMARY KEY(knr)
ADD CONSTRAINTS konto_ktnr_fk FOREIGN KEY(ktnr) REFERENCES kontotyp(ktnr)
;

CREATE TABLE kontoägare(
radnr NUMBER(9),
pnr VARCHAR2(11) NOT NULL,
knr NUMBER(8) NOT NULL
);

ALTER TABLE kontoägare
ADD CONSTRAINTS kontoägare_radnr_pk PRIMARY KEY(radnr)
ADD CONSTRAINTS kontoägare_pnr_fk FOREIGN KEY(pnr) REFERENCES bankkund(pnr)
ADD CONSTRAINTS kontoägare_knr_fk FOREIGN KEY(knr) REFERENCES konto(knr)
;

CREATE TABLE uttag(
radnr number(9),
pnr VARCHAR2(11) NOT NULL,
knr NUMBER(8) NOT NULL,
belopp number(10,2),
datum DATE NOT NULL
);

ALTER TABLE uttag
ADD CONSTRAINTS uttag_radnr_pk PRIMARY KEY(radnr)
ADD CONSTRAINTS uttag_pnr_fk FOREIGN KEY(pnr) REFERENCES bankkund(pnr)
ADD CONSTRAINTS uttag_knr_fk FOREIGN KEY(knr) REFERENCES konto(knr)
;

CREATE TABLE insättning(
radnr NUMBER(9),
pnr VARCHAR2(11) NOT NULL,
knr NUMBER(8) NOT NULL,
belopp number(10,2),
datum DATE NOT NULL
);

ALTER TABLE insättning
ADD CONSTRAINTS insättning_radnr_pk PRIMARY KEY(radnr)
ADD CONSTRAINTS insättning_pnr_fk FOREIGN KEY(pnr) REFERENCES bankkund(pnr)
ADD CONSTRAINTS insättning_knr_fk FOREIGN KEY(knr) REFERENCES konto(knr)
;

CREATE TABLE överföring(
radnr NUMBER(9),
pnr VARCHAR2(11) NOT NULL,
från_knr NUMBER(8) NOT NULL,
till_knr NUMBER(8) NOT NULL,
belopp number(10,2),
datum DATE NOT NULL
);

ALTER TABLE överföring
ADD CONSTRAINTS överföring_radnr_pk PRIMARY KEY(radnr)
ADD CONSTRAINTS överföring_pnr_fk FOREIGN KEY(pnr) REFERENCES bankkund(pnr)
ADD CONSTRAINTS överföring_från_knr_fk FOREIGN KEY(från_knr) REFERENCES konto(knr)
ADD CONSTRAINTS överföring_till_knr_fk FOREIGN KEY(till_knr) REFERENCES konto(knr)
;

-- Uppgift 3
CREATE OR REPLACE TRIGGER biufer_bankkund
BEFORE INSERT OR UPDATE
OF passwd
ON bankkund
FOR EACH ROW
BEGIN
	IF LENGTH(:NEW.passwd) <> 6 THEN
		RAISE_APPLICATION_ERROR(-20001, 'Lösenordet måste vara 6 tecken');
	END IF;
END;

-- Uppgift 4
CREATE OR REPLACE PROCEDURE do_bankkund(
p_pnr IN bankkund.pnr%TYPE,
p_fnamn IN bankkund.fnamn%TYPE,
p_enamn IN bankkund.enamn%TYPE,
p_passwd IN bankkund.passwd%TYPE
)
IS
BEGIN
	INSERT INTO bankkund(pnr,fnamn,enamn,passwd)
	VALUES (p_pnr,p_fnamn,p_enamn,p_passwd);
COMMIT;
END;

--Uppgift 5
EXEC do_bankkund('691124-4478','Leena','Kvist','qwe');
BEGIN
do_bankkund('540126-1111','Hans','Rosendahl','olle45');
do_bankkund('560126-1111','Hans','Rosengårdh','olle85');
do_bankkund('540126-1457','Lina','Karlsson','asdfgh');
do_bankkund('691124-4478','Leena','Kvist','qwerty');
COMMIT;
END;

-- Uppgift 6
CREATE SEQUENCE radnr_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO kontotyp(ktnr,ktnamn,ränta)
VALUES(1,'bondkonto',3.4);
INSERT INTO kontotyp(ktnr,ktnamn,ränta)
VALUES(2,'potatiskonto',4.4);
INSERT INTO kontotyp(ktnr,ktnamn,ränta)
VALUES(3,'griskonto',2.4);
COMMIT;
INSERT INTO konto(knr,ktnr,regdatum,saldo)
VALUES(123,1,SYSDATE - 321,0);
INSERT INTO konto(knr,ktnr,regdatum,saldo)
VALUES(5899,2,SYSDATE - 2546,0);
INSERT INTO konto(knr,ktnr,regdatum,saldo)
VALUES(5587,3,SYSDATE - 10,0);
INSERT INTO konto(knr,ktnr,regdatum,saldo)
VALUES(8896,1,SYSDATE - 45,0);
COMMIT;
INSERT INTO kontoägare(radnr,pnr,knr)
VALUES(radnr_seq.NEXTVAL,'540126-1111',123);
INSERT INTO kontoägare(radnr,pnr,knr)
VALUES(radnr_seq.NEXTVAL,'691124-4478',123);
INSERT INTO kontoägare(radnr,pnr,knr)
VALUES(radnr_seq.NEXTVAL,'540126-1111',5899);
INSERT INTO kontoägare(radnr,pnr,knr)
VALUES(radnr_seq.NEXTVAL,'691124-4478',8896);
COMMIT;

-- Uppgift 7
CREATE OR REPLACE FUNCTION logga_in(
p_pnr IN bankkund.pnr%TYPE,
p_passwd IN bankkund.passwd%TYPE
)
RETURN NUMBER
AS
v_login_resultat number(1);
BEGIN
	SELECT COUNT(pnr)
	INTO v_login_resultat
	FROM bankkund
	WHERE pnr = p_pnr
	AND passwd = p_passwd;
	RETURN v_login_resultat;
END;

-- Uppgift 8
CREATE OR REPLACE FUNCTION get_saldo(
p_knr konto.knr%TYPE
)
RETURN NUMBER
AS
v_saldo NUMBER(10,2);
BEGIN
	SELECT saldo
	INTO v_saldo
	FROM konto
	WHERE knr = p_knr;
	RETURN v_saldo;
END;

-- Uppgift 9
CREATE OR REPLACE FUNCTION get_behörighet(
p_pnr kontoägare.pnr%TYPE,
p_knr kontoägare.knr%TYPE
)
RETURN NUMBER
AS
v_behörig NUMBER(1);
BEGIN
	SELECT COUNT(pnr)
	INTO v_behörig
	FROM kontoägare
	WHERE pnr = p_pnr
	AND knr = p_knr;
	RETURN v_behörig;
END;

-- Uppgift 10
CREATE OR REPLACE TRIGGER aifer_insättning
AFTER INSERT
ON insättning
FOR EACH ROW
BEGIN
	UPDATE konto SET saldo = saldo + :NEW.belopp
	WHERE knr = :NEW.knr;
	COMMIT;
END;

-- Uppgift 11
CREATE OR REPLACE TRIGGER bifer_uttag
BEFORE INSERT
ON uttag
FOR EACH ROW
DECLARE
v_saldo konto.saldo%TYPE
BEGIN
	v_saldo := get_saldo(:NEW.knr);
	IF v_saldo - :NEW.belopp < 0 THEN
		RAISE_APPLICATION_ERROR(-20001,'För lite pengar på kontot');
	END IF;
END;

-- Uppgift 12
CREATE OR REPLACE TRIGGER aifer_uttag
AFTER INSERT
ON uttag
FOR EACH ROW
BEGIN
	UPDATE konto SET saldo = saldo - :NEW.belopp
	WHERE knr = :NEW.knr;
	COMMIT;
END;

-- Uppgift 13
CREATE OR REPLACE TRIGGER bifer_överföring
BEFORE INSERT
ON överföring
FOR EACH ROW
DECLARE
v_saldo konto.saldo%TYPE;
BEGIN
	v_saldo := get_saldo(:NEW.från_knr);
	IF v_saldo - :NEW.belopp < 0 THEN
		RAISE_APPLICATION_ERROR(-20001,'För lite pengar på överföringskontot');
	END IF;
END;

-- Uppgift 14
CREATE OR REPLACE TRIGGER aifer_överföring
AFTER INSERT
ON överföring
FOR EACH ROW
BEGIN
	UPDATE konto SET saldo = saldo - :NEW.belopp
	WHERE knr = :NEW.från_knr;
	UPDATE konto SET saldo = saldo + :NEW.belopp
	WHERE knr = :NEW.till_knr;
END;

-- Uppgift 15
CREATE OR REPLACE PROCEDURE do_insättning(
p_pnr insättning.pnr%TYPE,
p_knr insättning.knr%TYPE,
p_belopp insättning.belopp%TYPE,
)
AS
BEGIN
	INSERT INTO insättning(radnr, pnr, knr, belopp, datum)
	VALUES(radnr_seq.NEXTVAL, p_pnr,p_knr,p_belopp,SYSDATE);
COMMIT;
END;

-- Uppgift 16
--Kolla så att steg 15 fungerar

-- Uppgift 17
 CREATE OR REPLACE PROCEDURE do_uttag(
p_pnr uttag.pnr%TYPE,
p_knr uttag.knr%TYPE,
p_belopp uttag.belopp%TYPE,
)
AS
obehörig EXCEPTION;
BEGIN
	IF get_behörighet(p_pnr, p_knr) = 1 THEN
	INSERT INTO uttag(radnr, pnr, knr, belopp, datum)
	VALUES(radnr_seq.NEXTVAL, p_pnr,p_knr,p_belopp,SYSDATE);
	
	ELSIF RAISE obehörig
	
	END IF;

EXCEPTION
	WHEN obehörig THEN
	dbms_output.put_line('Obehörligt uttag!!')
END;

-- Uppgift 18 
-- Testa så att steg 17 fungerar

-- Uppgift 19
CREATE OR REPLACE PROCEDURE do_överföring(
p_pnr överföring.pnr%TYPE,
p_från_knr överföring.knr%TYPE,
p_till_knr överföring.knr%TYPE,
p_belopp överföring.belopp%TYPE,
)
AS
obehörig EXCEPTION;
BEGIN
	IF get_behörighet(p_pnr, p_från_knr) = 1 THEN
	INSERT INTO överföring(radnr, pnr, från_knr,till_knr, belopp, datum)
	VALUES(radnr_seq.NEXTVAL, p_pnr,p_från_knr,p_till_knr, p_belopp,SYSDATE);
	
	ELSIF RAISE obehörig
	
	END IF;

EXCEPTION
	WHEN obehörig THEN
	dbms_output.put_line('Obehörligt uttag!!')
END;
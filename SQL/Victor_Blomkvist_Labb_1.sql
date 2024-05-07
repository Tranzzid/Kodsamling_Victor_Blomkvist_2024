-- Skapar seq för löpnr--

CREATE SEQUENCE myseq
start with 1
increment by 1;

select myseq.nextval

-- Skapar alla tables och lägger till constraints--

-- Skapa tabell kund
CREATE TABLE kund(
persnr varchar2(11),
username varchar2(20) not null,
passwd varchar2(20) not null,
fnamn varchar2(50) not null,
enamn varchar2(50) not null,
kredittyp varchar2(5) CHECK,
telnr NUMBER(15)
);

--Lägg till Constraint
ALTER TABLE kund
ADD CONSTRAINT kund_persnr_pk PRIMARY KEY(persnr)
ADD CONSTRAINT kund_username_UQ UNIQUE(username)
ADD CONSTRAINT kund_kredittyp_CK CHECK(kredittyp IN ('hög', 'medel', 'låg'));

-- Skapa kundorder
CREATE TABLE kundorder(
ordnr NUMBER(10),
persnr VARCHAR2(11) NOT NULL,
datum DATE NOT NULL
);

--Lägg till Constraint
ALTER TABLE kundorder
ADD CONSTRAINT kundorder_ordnr_PK PRIMARY KEY(ordnr)
ADD CONSTRAINT kundorder_persnr_FK FOREIGN KEY(persnr) REFERENCES kund(persnr);

-- Skapa varugrupp
CREATE TABLE varugrupp(
vgnr NUMBER(4),
vgnamn VARCHAR2(30) NOT NULL
);

--Lägg till Constraint
ALTER TABLE varugrupp
ADD CONSTRAINT varugrupp_vgnr_PK PRIMARY KEY(vgnr);

-- Skapa artikel
CREATE TABLE artikel(
artnr NUMBER(5),
vgnr NUMBER(4) NOT NULL,
artnamn VARCHAR2(50) NOT NULL,
pris NUMBER(5) NOT NULL
);

--Lägg till Constraint
ALTER TABLE artikel
ADD CONSTRAINT artikel_artnr_PK PRIMARY KEY(artnr)
ADD CONSTRAINT artikel_vgnr_FK FOREIGN KEY(vgnr) REFERENCES varugrupp(vgnr);

-- Skapa Kundvagn
CREATE TABLE kundvagn(
radnr NUMBER(2),
ordnr NUMBER(10) NOT NULL,
artnr NUMBER(5) NOT NULL,
antal NUMBER(3) NOT NULL
);

--Lägg till Constraint
ALTER TABLE kundvagn
ADD CONSTRAINT kundvagn_radnr_PK PRIMARY KEY(radnr)
ADD CONSTRAINT kundvagn_ordnr_FK FOREIGN KEY(ordnr) REFERENCES kundorder(ordnr)
ADD CONSTRAINT kundvagn_artnr_FK FOREIGN KEY(artnr) REFERENCES artikel(artnr);

-- Skapa artikelbild
CREATE TABLE artikelbild(
bildnr NUMBER(4),
artnr NUMBER(5) NOT NULL,
filtyp VARCHAR2(5) NOT NULL,
width NUMBER(4) NOT NULL,
height NUMBER(4) NOT NULL,
path VARCHAR2(10) NOT NULL
);

--Lägg till Constraint
ALTER TABLE artikelbild
ADD CONSTRAINT artikelbild_bildnr_PK PRIMARY KEY(bildnr)
ADD CONSTRAINT artikelbild_artnr_FK FOREIGN KEY(artnr) REFERENCES artikel(artnr)
ADD CONSTRAINT artikelbild_filtyp_CK CHECK(filtyp IN ('gif', 'jpg'));

-- lägg in 3 rader data i kund--
INSERT INTO kund(persnr, username, passwd, fnamn, enamn, kredittyp, telnr)(
VALUES('980117-2694', 'Tranzzid','abc123', 'Victor', 'Blomkivist', 'hög', 0705381740 ),
VALUES('000101-5555', 'Zigma', 'def456', 'Victor', 'Blomkvist', 'låg'),
VALUES('010101-0101', 'Enari', 'password', 'Förnamn', 'Efternamn', 'medel'))
COMMIT;


--Lägg till två rader i tabellen varugrupp.--

INSERT INTO varugrupp(vgnr, vgnamn)(
VALUES('10', 'Mobil'),
VALUES('20', 'Dator'))
COMMIT;

--Lägg till tre rader i tabellen artikel.--

INSERT INTO artikel(artnr, vgnr, artnamn, pris)
VALUES('001', '10','Mobiltelefon', '10000');

INSERT INTO artikel(artnr, vgnr, artnamn, pris)
VALUES('002', '20', 'Komplett PC', '20000');

INSERT INTO artikel(artnr, vgnr, artnamn, pris)
VALUES('003', '10', 'Mobiltelefon Budget', '5000');
COMMIT;

-- Skapa en rad i kundorder
INSERT INTO kundorder(ordnr, persnr, datum)
VALUES(myseq.NEXTVAL, '980117-2694', SYSDATE);

COMMIT;


-- Lägg till 2 orderrader i kundvagn
INSERT INTO kundvagn(radnr, ordnr, artnr, antal)
VALUES(myseq.NEXTVAL, 2, 001, 5);


INSERT INTO kundvagn(radnr, ordnr, artnr, antal)
VALUES(myseq.NEXTVAL, 2, 002, 3);

COMMIT;




-- Uppdatera pris med 23%
UPDATE artikel
SET pris = (pris*1.23);

COMMit;


-- Ändra telnr på en kund
UPDATE kund
SET telnr = 070555555
WHERE persnr = '010101-0101';

COMMit;


-- Radera allt innehåll i Kundorder
DELETE
FROM kundorder
COMMIT;
-- ORA-02292: integrity constraint (SQL_VUSAXMVBRKCWAIBZGOVJLAQJF.KUNDVAGN_ORDNR_FK) violated - child record found ORA-06512: at "SYS.DBMS_SQL", line 1721
-- Felmeddelande för att tabbelen har en relation till kundvagn


-- Radera ALL data

DROP TABLE kundvagn;
DROP TABLE kundorder;
DROP TABLE artikelbild;
DROP TABLE artikel;
DROP TABLE varugrupp;
DROP TABLE kund;
DROP SEQUENCE mysec;
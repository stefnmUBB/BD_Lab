-- stocare

CREATE TABLE SpatiuDepozitare (
	IdDepozit INT PRIMARY KEY IDENTITY,
	Cladire   VARCHAR(20),
	Camera    INT,
	Raion     INT,
	Raft      INT
);

-- InregistrareNumismatica

CREATE TABLE NotaNumismatica (
	IdNotaNumismatica INT PRIMARY KEY IDENTITY,
	Valoare            FLOAT       NOT NULL,
	Valuta             VARCHAR(30) NOT NULL,
)

-- Monede

CREATE TABLE MateriePrimaMoneda (  -- fier, cupru, otel,...
	IdMateriePrima INT PRIMARY KEY IDENTITY,
	Denumire       VARCHAR(20)
);

CREATE TABLE MaterialMoneda ( -- inox, ...
	IdMaterialMoneda INT PRIMARY KEY IDENTITY,
	Denumire VARCHAR(20)
);

CREATE TABLE CompozitieMoneda ( -- otel Fe 80%; otel C 20%
	IdMaterialMoneda  INT FOREIGN KEY REFERENCES MaterialMoneda(IdMaterialMoneda),
	IdMateriePrima    INT FOREIGN KEY REFERENCES MateriePrimaMoneda(IdMateriePrima),
	ProcentCompozitie FLOAT CHECK (0<ProcentCompozitie AND ProcentCompozitie<=100)

	CONSTRAINT pk_CompozitieMoneda PRIMARY KEY (IdMaterialMoneda, IdMateriePrima)
);

CREATE TABLE TipMonede (
	IdTipMoneda       INT         PRIMARY KEY IDENTITY,
	IdNotaNumismatica INT FOREIGN KEY REFERENCES NotaNumismatica(IdNotaNumismatica),	
	Orientare         VARCHAR(20) NOT NULL CHECK (Orientare IN ('Moneda', 'Medalie')),		
	IdMaterialMoneda  INT FOREIGN KEY REFERENCES MaterialMoneda(IdMaterialMoneda)
);

CREATE TABLE ExemplarMonede (
	IdExemplarMoneda INT PRIMARY KEY IDENTITY,
	IdTipMoneda      INT FOREIGN KEY REFERENCES TipMonede(IdTipMoneda),
	StareConservare  INT CHECK (1<=StareConservare AND StareConservare<=10),
	IdDepozit        INT FOREIGN KEY REFERENCES SpatiuDepozitare(IdDepozit) 
);

-- Bancnote


CREATE TABLE MaterialBancnota (  -- hartie, plastic...
	IdMaterial INT PRIMARY KEY IDENTITY,
	Denumire       VARCHAR(20)
);

CREATE TABLE TipBancnota (
	IdTipBancnota      INT         PRIMARY KEY IDENTITY,
	IdNotaNumismatica  INT         FOREIGN KEY REFERENCES NotaNumismatica(IdNotaNumismatica),	
	IdMaterialBancnota INT         FOREIGN KEY REFERENCES MaterialBancnota(IdMaterial)
);

CREATE TABLE ExemplarBancnote (
	IdExemplarBancnota  INT PRIMARY KEY IDENTITY,
	IdTipBacncnota      INT FOREIGN KEY REFERENCES TipBancnota(IdTipBancnota),
	StareConservare     INT CHECK (1<=StareConservare AND StareConservare<=10),
	IdDepozit           INT FOREIGN KEY REFERENCES SpatiuDepozitare(IdDepozit) 
);
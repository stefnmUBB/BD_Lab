--- Selecteaza materialele monedelor si compozitiile lor
SELECT M.IdMaterialMoneda, MP.Denumire, C.ProcentCompozitie FROM MaterialMoneda M 
	JOIN CompozitieMoneda C ON C.IdMaterialMoneda = M.IdMaterialMoneda 
	JOIN MateriePrimaMoneda MP ON C.IdMateriePrima = MP.IdMateriePrima;

--- Selecteaza toate tipurile de monede emise inainte de 2000
SELECT TM.IdTipMoneda, NN.Valoare, NN.Valuta, TM.Orientare, NN.Tara, TM.An FROM TipMonede TM 
	JOIN NotaNumismatica NN ON NN.IdNotaNumismatica = TM.IdNotaNumismatica
	WHERE AN<2000;

--- note numismatice pentru fiecare tara
SELECT DISTINCT Valuta, Tara FROM NotaNumismatica ORDER BY Tara;


SELECT TM.IdTipMoneda, NN.Valoare, NN.Valuta, TM.Orientare, NN.Tara, TM.An FROM TipMonede TM 
	JOIN NotaNumismatica NN ON NN.IdNotaNumismatica = TM.IdNotaNumismatica
	WHERE AN<2000;


--- numarul de titluri lansate in fiecare an pentru consolele mai vechi de 2006,
--- pentru anii in care am cel putin 2 titluri in colectie
SELECT COUNT(V.Nume) Titluri, YEAR(V.DataLansare) An FROM TitluJocVideo V
	INNER JOIN TipConsola C ON C.IdTipConsola = V.Platforma
	WHERE YEAR(C.DataLansare)<2006
	GROUP BY YEAR(V.DataLansare) 
	HAVING COUNT(V.Nume)>1

--- numarul companiilor de la care am cel putin 2 titluri de jocuri
SELECT COUNT(V.Nume), C.Nume FROM TitluJocVideo V JOIN Companie c ON V.IdCompanie = C.IdCompanie
GROUP BY C.Nume HAVING COUNT(V.Nume)>2;

--- anul mediu de lansare a titlurilor pentru fiecare plaforma, daca acesta este >=2000
SELECT AVG(YEAR(V.DataLansare)) AnMediu, T.Nume, C.Nume FROM TitluJocVideo V 
	JOIN TipConsola T ON T.IdTipConsola = V.Platforma
	JOIN Companie C ON T.IdCompanie = C.IdCompanie
	GROUP BY T.Nume, C.Nume 
	HAVING AVG(YEAR(V.DataLansare))>=2000
	ORDER BY AVG(YEAR(V.DataLansare))
	
SELECT * FROM TitluJocVideo

--- exemplare de jocuri lansate dupa 1995 + depozitul in care se afla, ordonate dupa stadiul de conservare
SELECT EJ.IdExemplarJocVideo, TJ.Nume, TC.Nume, EJ.StareConservare, YEAR(TJ.DataLansare) AnLansare, SD.Cladire, SD.Camera, SD.Raion, SD.Raft FROM ExemplarJocVideo EJ 
	INNER JOIN TitluJocVideo TJ ON EJ.IdTitluJocVideo = TJ.IdTitluJocVideo
	INNER JOIN SpatiuDepozitare SD ON EJ.IdDepozit = SD.IdDepozit
	INNER JOIN TipConsola TC ON TJ.Platforma = TC.IdTipConsola
	WHERE YEAR(TJ.DataLansare)>=1995
	ORDER BY EJ.StareConservare DESC, TJ.Nume


--- monedele din aluminiu pur stocate la Alpha
SELECT EM.IdExemplarMoneda, Valoare, NN.Valuta, TM.An, EM.StareConservare FROM ExemplarMonede EM
	INNER JOIN TipMonede TM ON EM.IdTipMoneda = TM.IdTipMoneda
	INNER JOIN NotaNumismatica NN ON NN.IdNotaNumismatica = TM.IdNotaNumismatica
	INNER JOIN SpatiuDepozitare SD ON EM.IdDepozit = SD.IdDepozit
	FULL JOIN MaterialMoneda MM ON MM.IdMaterialMoneda = TM.IdMaterialMoneda
	FULL JOIN CompozitieMoneda CM ON CM.IdMaterialMoneda = MM.IdMaterialMoneda		
	WHERE MM.Denumire='Aluminiu' AND CM.ProcentCompozitie=100

--- numarul exemplarelor din fiecare tip de moneda
SELECT Valoare, NN.Valuta, TM.An, COUNT(EM.IdExemplarMoneda) Cantitate FROM ExemplarMonede EM
	INNER JOIN TipMonede TM ON EM.IdTipMoneda = TM.IdTipMoneda
	INNER JOIN NotaNumismatica NN ON NN.IdNotaNumismatica = TM.IdNotaNumismatica	
	FULL JOIN MaterialMoneda MM ON MM.IdMaterialMoneda = TM.IdMaterialMoneda
	FULL JOIN CompozitieMoneda CM ON CM.IdMaterialMoneda = MM.IdMaterialMoneda			
	GROUP BY Valoare, NN.Valuta, TM.An


# RecOut!

Egy edzéskövető app, ami nem több, mint amit a neve mond. Semmi követés vagy adathalászat, ellenben letisztult kinézet, és működés!

Rögzítsd egyszerűen az edzéseket, amiket csináltál, mindenféle nehézség nélkül, egy egyszerű kattintással!

Egy edzésnek meg lehet adni:

- a típusát
- a dátumát
- az időtartamát

Edzések kilistázása, hogy megtekinthessük a korábbi tevékenységeket.

Edzések szerkesztése, mert bárkivel megesik, hogy valamit félrenyom.

## Roadmap

### 1. Prototípus és tervezés

Ez az első része, ami készen van a projeknek, egy Figma terv alapján indult ki, ami itt található:

[RecOut! Figma terv](https://www.figma.com/proto/Bu77I6qwoL1bFLdfl4BUYQ/RecOut!?node-id=33-2&p=f&t=QMPY2sy5KQN4jBRe-0&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=33%3A2&show-proto-sidebar=1)

Ez alapján már írható volt egy specifikáció is. Tudom, ez így egy visszafele folyamat, de ez a prototípus picit olyan, mint az ötletelés, hogy addig próbálkozom, amíg jó nem lesz, és utána tudok olyan döntéseket meghozni az architektúráról, amik majd az egész projektet befolyásolják. Nem akarok vakul dönteni, arra ott volt a három prog tárgy.

[RecOut! specifikáció](https://github.com/T0liver/recout/blob/main/docs/SpecMe.md)

// TODO: specifikációt megírni

### 2. Projekt inicializálása

Ez az a rész, hogy beállítom a környezetet, megnézem mi is az a Firebase meg ilyenek, meg hogy melyik IDE lenne a legjobb a fejlesztésre.

Meg ide lehet venni azt is, hogy most létrehoztam ezt a projektet (`flutter create recout` hűűű), és ezeket az init commitokat írom.

~~// TODO: firebase acc létrehozása~~

### 3. UI implementáció

Ezek után pedig elkezdek widgeteket készíteni, amikből felépülhet majd az app.

Ezek még nem lesznek működőképes gombok meg történetek, inkább csak az a lényeg, hogy legyen egy prototípushoz hasonló dolog, vagyis, hogy a prototípust lebontsam építőelemekre, amiket implementálok, hogy azokból tudjam felépíteni majd az alkalmazást.

Elkészítendő widgetek listája

#### User workflow

- [ ] főképernyő
	- [ ] felső üdv felirat
	- [ ] Edzés gyors hozzáadása panel
		- [ ] normál állapot
		- [ ] hozzáadás állapot
	- [ ] Korábbi edzések panel
		- [ ] Korábbi edzések felirat
		- [ ] Edzés elem panel
		- [ ] hirdetés panel
	- [ ] edzés hozzáadása "+" gomb
- [ ] első belépési oldal
	- [ ] üdv szöveg panel + ikon felette
	- [ ] nyelv beállítása gomb
	- [ ] bejelentés gomb
	- [ ] regisztráció gomb
- [ ] bejelentkeztető oldal
	- [ ] vissza gomb
	- [ ] főcím + ikon panel
	- [ ] felhasználónév beírás
	- [ ] jelszó beírás
	- [ ] bejelentés gomb
- [ ] regisztrációs oldal
	- [ ] vissza gomb
	- [ ] főcím + ikon panel
	- [ ] felhasználónév beírás
	- [ ] e-mail cím beírás
	- [ ] jelszó beírás
	- [ ] regisztráció gomb
- [ ] új aktivitás oldal
	- [ ] vissza gomb
	- [ ] főcím
    - [ ] ikon panel
    - [ ] edzés neve doboz
    - [ ] edzés időpontja választó
    - [ ] edzés időtartama választó
    - [ ] edzés helyszíne választó
    - [ ] mentés gomb
- [ ] részletes aktivitás oldal
	- [ ] vissza gomb
	- [ ] ikon panel + cím
	- [ ] edzés neve
    - [ ] edzés időpontja
    - [ ] edzés időtartama
    - [ ] edzés helyszíne
	- [ ] törlés gomb
	- [ ] törlés dialógus
		- [ ] főszöveg
		- [ ] szöveg
		- [ ] igen gomb
		- [ ] nem gomb
- [ ] aktivitás szerkesztése oldal
	- [ ] vissza gomb
	- [ ] főcím
    - [ ] ikon panel
    - [ ] edzés neve doboz
    - [ ] edzés időpontja választó
    - [ ] edzés időtartama választó
    - [ ] edzés helyszíne választó
    - [ ] mentés gomb
- [ ] beállítások oldal
	- [ ] vissza gomb
	- [ ] főcím
	- [ ] nyelv cím
	- [ ] téma módosítása cím
	- [ ] felhasználói fiók cím
	- [ ] hiba bejelentése cím
	- [ ] alsó szöveg
- [ ] nyelv választása cím
	- [ ] vissza gomb
	- [ ] főcím
	- [ ] nyelvek listázása
	- [ ] fordítása hozzájárulás szöveg
- [ ] téma választása oldal
	- [ ] vissza gomb
	- [ ] főcím
	- [ ] témák listázása
	- [ ] téma hozzáadása szöveg
- [ ] hiba bejelentése oldal
	- [ ] vissza gomb
	- [ ] főcím
	- [ ] főszöveg
	- [ ] alsó szöveg
- [ ] fiók oldal
	- [ ] vissza gomb
	- [ ] főcím
	- [ ] fiókkép ikon
	- [ ] felhasználónév
	- [ ] vezetéknév, keresztnév
	- [ ] születési idő
	- [ ] e-mail cím
	- [ ] adatok módosítása gomb
	- [ ] fiók törlése gomb
	- [ ] fiók törlése dialógus
		- [ ] főszöveg
		- [ ] szöveg
		- [ ] igen gomb
		- [ ] nem gomb
- [ ] fiók módosítása oldal
	- [ ] vissza gomb
	- [ ] főcím
	- [ ] fiókkép ikon
	- [ ] felhasználónév
	- [ ] vezetéknév, keresztnév módosítása
	- [ ] születési idő módosítása
	- [ ] e-mail cím 
	- [ ] rendben gomb
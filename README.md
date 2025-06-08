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

<details>
	<summary>Főképernyő</summary>

- [x] főképernyő oldal
	- [x] felső üdv felirat
	- [x] Edzés gyors hozzáadása panel
		- [x] normál állapot
		- [x] hozzáadás állapot
	- [x] Korábbi edzések panel
		- [x] Korábbi edzések felirat
		- [x] Edzés elem panel
		- [ ] hirdetés panel

</details>

<details>
	<summary>Első belépés</summary>

- [x] első belépési oldal
	- [x] üdv szöveg panel + ikon felette
	- [x] nyelv beállítása gomb
	- [x] bejelentés gomb
	- [x] regisztráció gomb
	
</details>

<details>
	<summary>Bejelentkezés</summary>

- [x] bejelentkeztető oldal
	- [x] vissza gomb
	- [x] főcím + ikon panel
	- [x] felhasználónév beírás
	- [x] jelszó beírás
	- [x] bejelentés gomb

</details>

<details>
	<summary>Regisztráció</summary>

- [x] regisztrációs oldal
	- [x] vissza gomb
	- [x] főcím + ikon panel
	- [x] felhasználónév beírás
	- [x] e-mail cím beírás
	- [x] jelszó beírás
	- [x] regisztráció gomb

</details>

<details>
	<summary>Új aktivitás</summary>

- [x] új aktivitás oldal
	- [x] vissza gomb
	- [x] főcím
    - [x] ikon panel
    - [x] edzés neve doboz
    - [x] edzés időpontja választó
    - [x] edzés időtartama választó
    - [x] edzés helyszíne választó
    - [x] mentés gomb

</details>

<details>
	<summary>Részletes aktivitás</summary>

- [x] részletes aktivitás oldal
	- [x] vissza gomb
	- [x] ikon panel + cím
	- [x] edzés neve
    - [x] edzés időpontja
    - [x] edzés időtartama
    - [x] edzés helyszíne
	- [x] törlés gomb
	- [x] törlés dialógus
		- [x] főszöveg
		- [x] szöveg
		- [x] igen gomb
		- [x] nem gomb

</details>

<details>
	<summary>Aktivitás szerkesztése</summary>

- [x] aktivitás szerkesztése oldal
	- [x] vissza gomb
	- [x] főcím
    - [x] ikon panel
    - [x] edzés neve doboz
    - [x] edzés időpontja választó
    - [x] edzés időtartama választó
    - [x] edzés helyszíne választó
    - [x] mentés gomb

</details>

<details>
	<summary>Beállítások</summary>

- [x] beállítások oldal
	- [x] vissza gomb
	- [x] főcím
	- [x] nyelv cím
	- [x] téma módosítása cím
	- [x] felhasználói fiók cím
	- [x] hiba bejelentése cím
	- [x] alsó szöveg

</details>

<details>
	<summary>Nyelv választó</summary>

- [x] nyelv választása cím
	- [x] vissza gomb
	- [x] főcím
	- [x] nyelvek listázása
	- [x] fordítása hozzájárulás szöveg

</details>

<details>
	<summary>Téma választó</summary>

- [x] téma választása oldal
	- [x] vissza gomb
	- [x] főcím
	- [x] témák listázása
	- [x] téma hozzáadása szöveg

</details>

<details>
	<summary>Hiba bejelentése</summary>

- [x] hiba bejelentése oldal
	- [x] vissza gomb
	- [x] főcím
	- [x] főszöveg
	- [x] alsó szöveg

</details>

<details>
	<summary>Fiók</summary>

- [x] fiók oldal
	- [x] vissza gomb
	- [x] főcím
	- [x] fiókkép ikon
	- [x] felhasználónév
	- [x] vezetéknév, keresztnév
	- [x] születési idő
	- [x] e-mail cím
	- [x] adatok módosítása gomb
	- [x] fiók törlése gomb
	- [x] fiók törlése dialógus
		- [x] főszöveg
		- [x] szöveg
		- [x] igen gomb
		- [x] nem gomb

</details>

<details>
	<summary>Fiók módosítása</summary>

- [x] fiók módosítása oldal
	- [x] vissza gomb
	- [x] főcím
	- [x] fiókkép ikon
	- [x] felhasználónév
	- [x] vezetéknév, keresztnév módosítása
	- [x] születési idő módosítása
	- [x] e-mail cím 
	- [x] rendben gomb

</details>

... és még egy csomó firebase-es dolog, amit nem volt időm dokumentálni, de most kész az alkalmazás, és működik, ahogy elterveztem! ([többnyire.](#fejlesztés-todo-lista))

## Fejlesztés TODO lista

Összeszedett lista, hogy mika azok a dolog, amiket az 1.0 verzió kiadása óta feljegyeztem, hogy javítani kell, és pipálva azok, amik készek, a végére jöbbek az újak.

Még kellene egy prioritás jelző rendszer is, hogy az adott funkció / bug mennyire fontos. Pl. egy gomb kinézete nem olyan fontos, mint pl. ha a firebase nem működik vagy hasonló.

Legyen 5 osztály, a 0 a nagyon fontos, a 4 a ráér, és egy új funkció / javításkor a sor végére zárójelben felvesszük a prioritását a feladatnak, de ez nem lesz kötelező, mivel ha egy javítást már pl. issue-ból máris implementálunk, akkor nem kell felvenni prioritást, mivel már kész.

Na, ebben a szellemben kezdjük is ez a funkciókat!

- [x] androidon több helyet adni a tetején, mert a vissza gomb a navigációs sáv alatt van (3)
- [x] üres edzéslistánál a szövegben benne van egy "\n", mivel így akartam megoldani a sortörést. Erre vagy legyen egy másik megoldás, vagy ne legyen sortörés (4)
- [x] ugyanez a szöveg sötét témában fekete marad, nem látható (4)
- [x] bejelentkezés, regisztrációs, illetve egyéb nagyobb gombokban a szövegük valami margón túlcsordulhat, és levágja a száras betűk alját (3)
- [x] regisztrációnál nem kap megerősítő emailt a felhasználó (1)
- [x] androidon új edzéskor a név beírásánál a billentyűzet nem automatikusan nagybetűsen kezdődik
- [x] elfelejtett jelszó funkció (0) (első regisztrált fióknak elfelejtettem a jelszavát lmao)
- [x] web-en a bejelentkezést megkönnyíteni, azaz enter = bejelentkezés gomb, felhasználónév helyes felismerése (1)
- [x] felhasználó profil frissítése után a vissza gomb navigáció sem a BackBtn-el, sem a navigációs visszagombbal nem működik (2)
- [x] regisztráció ne lehessen lehetséges olyan felhasználónévvel, amit már használtak vagy bejelentkezés e-mail cím alapján legyen (0)
- [x] privacy policy oldal (/privacy) (0)
- [x] alkalmazás nevének megváltoztatása androidon és ios-en (recout -> RecOut! legyen az ikon alatti kis címke)
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
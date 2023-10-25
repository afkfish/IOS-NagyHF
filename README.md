# Házi feladat specifikáció
## IOS alapú szoftverfejlesztés
### 2023.10.25.
### CinemaDB
### Kis Benedek Márton - (JOYAXJ)
### school@afkfish.com

## Bemutatás

Ez az alkalmazás egy mozi és-vagy film kereső. Egy adatbázisból egy REST-apin keresztül letölti a most 
játszott filmeket magyarországon és ez alapján lehet mozit keresni a közelben. Az ötlet az IMDB-ről jött,
ahol már van egy ilyen funkció de sajnos nem elérhető Magyarországon. A célközönség azok, akik szeretnének
moziba menni, de nem tudják, hogy milyen filmeket játszanak a közelben.

## Főbb funkciók

Filmek keresése egy előre lekérdezett adatbázisból ami a perzistens tároróban van. Az adatok REST apin keresztül kérhetőek le. A filmeket egy TableView-ben jelenítem meg, amiket egy keresővel lehet szűrni. A filmekre kattintva
megjelenik egy részletes nézet, ahol a film plakátja, címe, leírása, stb. látható.

Mozi keresése a közelben. A mozikat MapKit-tel jelenítem meg. A mozikat is REST apin keresztül érem el. Mozikat is lehet egy TableViewben nézni és keresni köztük.

A filmekre jegy foglalására is van lehetőség a film adatlapján. A film azonosítója alapján egy új böngésző ablakban megnyílik a Cinema City oldala, ahol a jegyeket lehet megvásárolni.

## Választott technológiák:

- CoreData
- MapKit
- hálózati kommunikáció
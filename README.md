# L-Systeme in 3D

## Zum belesen
Bevor man L-Systeme implementiert sollte man sich zuerst einmal belesen. Hierzu ist dieses 
[Dokument](https://www.yumpu.com/de/document/read/18849596/l-systeme-und-andere-kunstliche-pflanzen) sehr zu empfehlen.

## Frontend
Das Frontend ist nach dem Ausfuehren und ausprobieren des Programms relativ selbst erklaerend.

## Backend
Hier werden die wesentlichen Strukturen des Backend beschrieben.

### Grammatik-Struktur (TGrammatik)
Diese Klasse speichert unsere definition der Grammatik, welche folgendermassen aufgebaut ist:

    record: Grammatik
      axiom: String;
      regeln: TFPGMap<Char,String>;

Noch zu ergaenzen:
  - wenn man Zufaelligkeiten reinbringen will, muss man den Datentyp des Wertes umdefinieren
    - eine Liste aus Wahrscheinlichkeit und Produktion waere denkbar

### Turtle-Stuktur (TTurtle)
// Alle Parameter hier duerfen von dem Nutzer geaendert werden
Die Turtle-Klasse ist dafuer verantwortlich das L-System ueberhaupt zu Zeichnen. Diese wird mit einer Grammatik 
und mehreren "zeichen Parametern" initialisiert. Die Grammatik ist waerend der Lebenszeit der Turtle nicht 
veraenderbar, die "zeichen Parameter" jedoch schon. Grober aufbau der zeichen Parameter:

    record: ZeichenParameter
      winkel: Real;
      Rekursions-Tiefe: (unsigned) Cardinal;
      startPunkt: TPunk3D;
      Zeichenart: TZeichenart; // wird erst spaeter eingefuegt

Die Turtle-Klasse sieht fuer grob folgendermassen aus:

    class: Turtle
      Feld: Grammatik (read only);
      Feld: ZeichenParameter (read und write (mit getter Funktionen));
      Feld: StringEntwickler (zustaendig fuer das erstellen der strings);
      constructor: Create;
        Parameter 1: Grammatik;
        Parameter 2: Zeichenparameter;
      procedure: zeichnen;

Noch zu ergaenzen:
  - verschiedene "Zeichenstile" moeglich machen (verschiedene Farben...)

### Entwickeln der Strings (TStringEntwickler)
Das entwickeln der Strings wird von dem "StringEndwickler" gehandhabt. Diese wird mit einer Grammatik initialisiert, 
welche waehrend der Laufzeit der initialisierten Instanz nicht geaendert werden kann. Beim Entwickeln des Strings kann man 
als Parameter die Rekursions Tiefe angeben:

    class: StringEntwickler
      Feld: Grammatik (read only);
      Feld: String (Endwickelter String);
      constructor: Create;
        Parameter 1: Grammatik;
      entwickeln: entwickeln;
        Parameter 1: Cardinal (rekursionsTiefe);

Noch zu ergaenzen:
  - Zufaelligkeit
    - Ueberlegung: Bewaeltigen mit dem bilden der Praefixsummen von Wahrscheinlichkeitswerten. Diese werden kann mit binaerer Suche Abgefragt.
  - (vllt) Optimierungen
    - der Algorithmus kann mit dynamischer Programmierung optimiert werden
    - Ueberlegung: Unter Verwendung von bit-Magie und dynamischer Programmierung koennte eventuell sogar eine logarithmische Laufzeit erzielen. (Ist eine Ueberlegung wert)

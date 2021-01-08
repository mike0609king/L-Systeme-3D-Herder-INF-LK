# ProjektDateien

## Backend
// Das ist eine Datenstruktur in der Klasse, die nicht von 
// dem Nutzer angefasst werden darf
record: Grammatik
  // - Alphabet: array [0..25] of boolean;
  - Axiom: String;
  - Regeln: TFGLDictionary;
      - key: char;
      - value: TList<char,TRegel>

// Alle Parameter hier duerfen von dem Nutzer geaendert werden
record: Zeichnen
  - Zeichenart: TZeichenart; // wird erst spaeter eingefuegt
  - Winkel: Real;
  - Rekursions-Tiefe: (unsigned) Cardinal;
  ? Zufaelligkeiten (wenn man viele gleiche Baeume zeichnen will,
  koennte man vielleicht noch eine extra Zeichenfunktion einfuehren
  oder die schon vorhandene mehrmals aufrufen): Real;

class: Turtle
  - Feld: Grammatik (read only)
  - Feld: Zeichnen (read und write (mit getter Funktionen))
  - constructor: Create
    - Parameter 1: Grammatik record
    - Parameter 2: Zeichnen
  - procedure: draw (Klammern mit Rekursion loesen)

Hard coden von Symbolen!!

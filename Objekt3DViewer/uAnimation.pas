unit uAnimation;

{$MODE Delphi}

{Bisher noch eine riesengroße Baustelle. Wer darf wen bewegen????
 Bsp. Bewegt sich die Kamera im EigenKOS durch die programmierte Animation oder
 ausschließlich interaktiv durch die Steuerung des Anwenders?! Beides gleichzeitig
 ist schlecht möglich!!!!,}
interface

procedure ozeichnen;

implementation

uses uTurtle, uGrammatik, uBeleuchtung, uZeichnerInit, uTurtleManager, uZeichnerBase,
sysUtils; // testing
VAR o: TTurtleManager;
    turtle,turtle1: TTurtle;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;
    zeichnerInit: TZeichnerInit;
    manager: TTurtleManager;

procedure ozeichnen;
begin
   //LichtAn(FALSE);
   o.zeichnen;
end;

begin
    o := TTurtleManager.Create;
    zeichnerInit := TZeichnerInit.Create;

    // So wird die Grammatik erstellt
    gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
    gram.axiom := 'F';                                  // axiom einstellen
    gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);   // 18%ige Chance fuer diese Einsetzung
    gram.addRegel('F','B',2.01);                        // 2.01%ige Chance fuer diese Einsetzung
    gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',79.99);  // 79.99%ige Chance fuer diese Einsetzung
    //gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F');      // 100%ige Chance fuer diese Einsetzung
    gram.addRegel('G', 'GGF--[]');                      // 100%ige Chance fuer diese Einsetzung

    // einistellen vom winkel und der rekursionsTiefe
    zeichenPara.winkel := 47.5;
    zeichenPara.rekursionsTiefe := 5;

    // erster Baum (index 0)
    // zeichenPara.setzeStartPunkt(0,0,0);
    turtle := TTurtle.Create(gram, TZeichnerBase.Create(zeichenPara));
    o.addTurtle(turtle);
    o.setzeSichtbarkeit(0,false);  // setzten der Sichtbarkeit der Turtle

    // zweiter Baum (index 1)
    zeichenPara.setzeStartPunkt(2,0,0);
    turtle := TTurtle.Create(gram, zeichnerInit.initialisiere('ZeichnerGruenesBlatt',zeichenPara));
    o.addTurtle(turtle);
    o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

    // dritter Baum (index 2)
    zeichenPara.setzeStartPunkt(5,0,0);
    turtle := TTurtle.Create(gram, zeichnerInit.initialisiere(
        zeichnerInit.gibZeichnerListe[0],zeichenPara));
    o.addTurtle(turtle);
    o.setzeSichtbarkeit(2,false);  // setzten der Sichtbarkeit der Turtle

    // vierter Baum (index 3)
    o.gibTurtle(1, turtle);
    o.setzeSichtbarkeit(1,true);  // setzten der Sichtbarkeit der Turtle
    turtle1 := turtle.copy;
    turtle1.setzeStartPunkt(-4,0,0);
    o.addTurtle(turtle1);
    o.setzeSichtbarkeit(3,true);  // setzten der Sichtbarkeit der Turtle

    // die Strings sind wirklich gleich
    if o.turtleListe[1].zuZeichnenderString = o.turtleListe[3].zuZeichnenderString then
    begin
        o.setzeSichtbarkeit(2,true);  // setzten der Sichtbarkeit der Turtle
    end;
    

    // beides das gleiche (entfernt beide die Turtle an index 2)
    // o.entferneTurtle(turtle);
    // o.entferneTurtleAn(2);

    // aendern der maximalenStringLaenge, damit die turtle mit Rekursionstiefe
    // 6 gezeichnet werden kann
    turtle.maximaleStringLaenge := turtle.maximaleStringLaenge*2;
    manager := o.copy;
    o := manager.copy;
end.

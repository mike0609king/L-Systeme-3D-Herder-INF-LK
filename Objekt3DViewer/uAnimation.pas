unit uAnimation;
 //Testbereich
{$MODE Delphi}

{Bisher noch eine riesengroße Baustelle. Wer darf wen bewegen????
 Bsp. Bewegt sich die Kamera im EigenKOS durch die programmierte Animation oder
 ausschließlich interaktiv durch die Steuerung des Anwenders?! Beides gleichzeitig
 ist schlecht möglich!!!!,}
interface

procedure ozeichnen;

implementation

uses uTurtle, uGrammatik, uBeleuchtung, uZeichnerInit, uTurtleManager, uZeichnerBase,uForm,
sysUtils,Classes; // testing
(*
VAR o: TTurtleManager;
    turtle,turtle1: TTurtle;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;
    zeichnerInit: TZeichnerInit;
    manager: TTurtleManager;
    para: TStringList;*)

procedure ozeichnen;
begin
   //LichtAn(FALSE);
   Hauptform.o.zeichnen;
end;

begin
  (*
    //befindet sich jetzt in uForm.standardturtel

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
    //o.setzeSichtbarkeit(0,false);  // setzten der Sichtbarkeit der Turtle

    // zweiter Baum (index 1)
    zeichenPara.setzeStartPunkt(2,0,0);
    turtle := TTurtle.Create(gram, zeichnerInit.initialisiere('ZeichnerGruenesBlatt',zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

    // dritter Baum (index 2)
    zeichenPara.setzeStartPunkt(-2,0,0);
    turtle := TTurtle.Create(gram, zeichnerInit.initialisiere(
        zeichnerInit.gibZeichnerListe[0],zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(2,false);  // setzten der Sichtbarkeit der Turtle

    // beides das gleiche (entfernt beide die Turtle an index 2)
    // o.entferneTurtle(turtle);
    // o.entferneTurtleAn(2);

    // modifizieren der rekursions Tiefe und Winkel der Turtle an index 0
    o.gibTurtle(0, turtle);
    turtle.rekursionsTiefe := 6;
    turtle.winkel := 15;

    // aendern der maximalenStringLaenge, damit die turtle mit Rekursionstiefe
    // 6 gezeichnet werden kann
    turtle.maximaleStringLaenge := turtle.maximaleStringLaenge*2;

    turtle.setzeZeichnerName(zeichnerInit.gibZeichnerListe[1]);
    turtle.speichern(GetCurrentDir+'\test.json');

    // laden und modifizieren der hochgeladenen Turtle
    turtle := TTurtle.Create(GetCurrentDir+'\test.json');
    turtle.rekursionsTiefe := 5;
    turtle.setzeStartPunkt(2,0,2);
    o.addTurtle(turtle);
  o := TTurtleManager.Create;
  zeichnerInit := TZeichnerInit.Create;

  // So wird die Grammatik erstellt
  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(2)';                                  // axiom einstellen
  //gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);   // 18%ige Chance fuer diese Einsetzung
  //gram.addRegel('F','B',2.01);                        // 2.01%ige Chance fuer diese Einsetzung
  //gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',79.99);  // 79.99%ige Chance fuer diese Einsetzung
  //gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F');      // 100%ige Chance fuer diese Einsetzung
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung

  // einistellen vom winkel und der rekursionsTiefe
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 3;

  // erster Baum (index 0)
  // zeichenPara.setzeStartPunkt(0,0,0);
  turtle := TTurtle.Create(
    gram, 
    zeichnerInit.initialisiere('ZeichnerSchrittlaenge',zeichenPara)
  );
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(0,false);  // setzten der Sichtbarkeit der Turtle

  // gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  // gram.axiom := 'F(7)';                                  // axiom einstellen
  // gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  // zweiter Baum (index 1)
  // zeichenPara.setzeStartPunkt(2,0,0);
  // turtle := TTurtle.Create(
  //  gram, 
  //  zeichnerInit.initialisiere('ZeichnerFarben',zeichenPara)
  // );
  // o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(1;2)&[+F(2)&&F(3)F(4)]&&F(5)[-^^/^-F(0)F(7)]F(8)';                                  // axiom einstellen
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  gram.addRegel('F(c;l)','F(c;l)&[+F(c;l)&&F(c;l)F(c;l)]&&F(c;l)[-^^/^-F(c;l)F(c;l)]F(c;l)');      // 100%ige Chance fuer diese Einsetzung
  zeichenPara.setzeStartPunkt(2,0,0);
  turtle := TTurtle.Create(
    gram, 
    zeichnerInit.initialisiere('ZeichnerFarbenUndSchrittlaenge',zeichenPara)
  );
  para := TStringList.Create;
  para.add('14'); para.add('14');
  para.add('14'); para.add('14');
  para.add('14'); para.add('14');
  para.add('14'); para.add('14'); para.add('14');
  turtle.aendereParameter(para);
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(1)&[+F(2)&&F(3)F(4)]&&F(5)[-^^/^-F(0)F(7)]F(8)';                                  // axiom einstellen
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  zeichenPara.setzeStartPunkt(-2,0,0);
  turtle := TTurtle.Create(
    gram, 
    zeichnerInit.initialisiere('ZeichnerFarben',zeichenPara)
  );
  para := TStringList.Create;
  //para.add('14'); para.add('14'); para.add('14'); para.add('14'); 
  //para.add('14'); para.add('14'); para.add('14'); para.add('14'); 
  turtle.aendereParameter(para);
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(14)&[+F(14)&&F(14)F(14)]&&F(14)[-^^/^-F(14)F(14)]F(14)';                                  // axiom einstellen
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  zeichenPara.setzeStartPunkt(-4,0,0);
  turtle := TTurtle.Create(
    gram, 
    zeichnerInit.initialisiere('ZeichnerFarben',zeichenPara)
  );
  o.gibTurtle(2, turtle1);
  turtle.aendereParameter(turtle1.gibParameter);
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle


  // dritter Baum (index 2)
  // zeichenPara.setzeStartPunkt(5,0,0);
  // turtle := TTurtle.Create(gram, zeichnerInit.initialisiere(
  // zeichnerInit.gibZeichnerListe[1],zeichenPara));
  // o.addTurtle(turtle);

  // vierter Baum (index 3)
  // o.gibTurtle(1, turtle);
  // o.setzeSichtbarkeit(1,true);  // setzten der Sichtbarkeit der Turtle
  // turtle1 := turtle.copy;
  // turtle1.setzeStartPunkt(-4,0,0);
  // o.addTurtle(turtle1);
  // o.setzeSichtbarkeit(3,true);  // setzten der Sichtbarkeit der Turtle

  // turtle.speichern('h.json');   *)
end.

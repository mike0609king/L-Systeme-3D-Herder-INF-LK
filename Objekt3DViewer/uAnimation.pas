unit uAnimation;

{$MODE Delphi}

{Bisher noch eine riesengroße Baustelle. Wer darf wen bewegen????
 Bsp. Bewegt sich die Kamera im EigenKOS durch die programmierte Animation oder
 ausschließlich interaktiv durch die Steuerung des Anwenders?! Beides gleichzeitig
 ist schlecht möglich!!!!}
interface

procedure ozeichnen;

implementation

uses uTurtle, uGrammatik, uBeleuchtung, uZeichnerBase, uZeichnerGruenesBlatt, uTurtleManager;
VAR o: TTurtleManager;
    turtle: TTurtle;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;

procedure ozeichnen;
begin
   //LichtAn(FALSE);
   o.zeichnen;
end;

begin
    o := TTurtleManager.Create;

    gram := TGrammatik.Create;
    gram.axiom := 'F';
    gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);
    gram.addRegel('F','B',2);
    gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',80);
    zeichenPara.winkel := 47.5;
    zeichenPara.rekursionsTiefe := 5;

    zeichenPara.setzeStartPunkt(0,0,0);
    turtle := TTurtle.Create(gram, TZeichnerBase.Create(zeichenPara));
    o.addTurtle(turtle);

    zeichenPara.setzeStartPunkt(2,0,0);
    turtle := TTurtle.Create(gram, TZeichnerGruenesBlatt.Create(zeichenPara));
    o.addTurtle(turtle);

    zeichenPara.setzeStartPunkt(-2,0,0);
    turtle := TTurtle.Create(gram, TZeichnerGruenesBlatt.Create(zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(1,false);
end.


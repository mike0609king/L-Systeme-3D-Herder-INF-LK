unit uAnimation;

{$MODE Delphi}

{Bisher noch eine riesengroße Baustelle. Wer darf wen bewegen????
 Bsp. Bewegt sich die Kamera im EigenKOS durch die programmierte Animation oder
 ausschließlich interaktiv durch die Steuerung des Anwenders?! Beides gleichzeitig
 ist schlecht möglich!!!!}
interface

procedure ozeichnen;

implementation

uses uTurtle, uGrammatik, uBeleuchtung;
VAR o: TTurtle;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;

procedure ozeichnen;
begin
   //LichtAn(FALSE);
   o.zeichnen;
end;

begin
    //Standard Turtel
    gram.axiom := 'F';
    gram.regeln := TRegelDictionary.Create;
    gram.regeln.add('F','F&[+F&&FB]&&F[-^^/^-FB]F');
    zeichenPara.winkel := 47.5;
    zeichenPara.rekursionsTiefe := 4;
    zeichenPara.setzeStartPunkt(0,0,0);
    o := TTurtle.create(gram, zeichenPara);
end.


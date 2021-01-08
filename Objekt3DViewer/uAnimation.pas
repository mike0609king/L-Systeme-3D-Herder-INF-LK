unit uAnimation;

{$MODE Delphi}

{Bisher noch eine riesengroße Baustelle. Wer darf wen bewegen????
 Bsp. Bewegt sich die Kamera im EigenKOS durch die programmierte Animation oder
 ausschließlich interaktiv durch die Steuerung des Anwenders?! Beides gleichzeitig
 ist schlecht möglich!!!!}
interface

procedure ozeichnen;

implementation

uses uturtle,uBeleuchtung;
VAR o:TObjekt;

procedure ozeichnen;
begin
   //LichtAn(FALSE);
   o.zeichnen;
end;

begin
   o:=TObjekt.create;
end.


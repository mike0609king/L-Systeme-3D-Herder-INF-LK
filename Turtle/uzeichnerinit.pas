unit uZeichnerInit;

{$mode delphi}

interface

uses
  Classes, SysUtils, fgl,
  uZeichnerbase, uZeichnerGruenesBlatt;

type TErbteZeichnerBase = class of TZeichnerBase;
type TVersandTabelleZeichner = TFPGMap<String, TErbteZeichnerBase>;
{ Aufgabe: Diese Klasse soll den Konstruktor einer Zeichen-Klasse aufrufen, wobei
  die Konstruktoren den Strings zugeordnet sind. }
type TZeichnerInit = class
    private
        FVersandTabelleZeichner: TVersandTabelleZeichner;
    public
        constructor Create;
        function initialisiere(zeichnerArt: String; zeichenPara: TZeichenParameter) : TZeichnerBase;
end;

implementation

constructor TZeichnerInit.Create;
begin
    FVersandTabelleZeichner := TVersandTabelleZeichner.Create;
    FVersandTabelleZeichner.add('ZeichnerBase',TZeichnerBase);
    FVersandTabelleZeichner.add('ZeichnerGruenesBlatt',TZeichnerGruenesBlatt);
end;

function TZeichnerInit.initialisiere(zeichnerArt: String; zeichenpara: TZeichenParameter) : TZeichnerBase;
var t: TErbteZeichnerBase;
begin
    if FVersandTabelleZeichner.tryGetData(zeichnerArt,t) then result := t.Create(zeichenPara)
    else result := TZeichnerBase.Create(zeichenPara);
end;

end.


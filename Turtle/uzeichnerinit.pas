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

        function gibZeichnerListe : TStringList;
end;

implementation

constructor TZeichnerInit.Create;
// Der Zeichenparameter wird lediglich dafuer genutzt um den Namen zu extrahieren
var zeichenPara: TZeichenParameter;
begin
    // default
    zeichenPara.winkel := 0;
    zeichenPara.rekursionsTiefe := 0;
    zeichenPara.setzeStartPunkt(0,0,0);

    FVersandTabelleZeichner := TVersandTabelleZeichner.Create;
    FVersandTabelleZeichner.add((TZeichnerBase.Create(zeichenPara)).name,TZeichnerBase);
    FVersandTabelleZeichner.add(
        (TZeichnerGruenesBlatt.Create(zeichenPara)).name,
        TZeichnerGruenesBlatt
    );
end;

function TZeichnerInit.initialisiere(zeichnerArt: String; zeichenpara: TZeichenParameter) : TZeichnerBase;
var t: TErbteZeichnerBase;
begin
    if FVersandTabelleZeichner.tryGetData(zeichnerArt,t) then result := t.Create(zeichenPara)
    else result := TZeichnerBase.Create(zeichenPara);
end;

function TZeichnerInit.gibZeichnerListe : TStringList;
var stringListe: TStringList;
    i: Cardinal;
begin
    stringListe := TStringList.Create;
    for i := 0 to FVersandTabelleZeichner.Count - 1 do
    begin
        stringListe.add(FVersandTabelleZeichner.keys[i]);
    end;
    result := stringListe;
end;

end.


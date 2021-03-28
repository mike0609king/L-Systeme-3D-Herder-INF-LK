unit uFarben;
{$mode delphi}

interface

uses
  Classes, SysUtils;

type TFarbe = record
  r,g,b: Real;
end;

type TFarben = record
  private
    FIdxZuFarbe: array[1..25] of TFarbe;
  public
    { Aufgabe: Weist die Farben richtig zu. }
    procedure initColor;

    // getter-Funktionen (public)
    function gibFarbe(idx: Cardinal) : TFarbe;
end;

implementation

procedure TFarben.initColor;
begin
  FIdxZuFarbe[1].r := 0.7; FIdxZuFarbe[1].g := 0.4; FIdxZuFarbe[1].b := 0.1;
  FIdxZuFarbe[2].r := 0.5; FIdxZuFarbe[2].g := 0.5; FIdxZuFarbe[2].b := 0.1;
  FIdxZuFarbe[3].r := 0.5; FIdxZuFarbe[3].g := 0.7; FIdxZuFarbe[3].b := 0.3;
  FIdxZuFarbe[4].r := 0.6; FIdxZuFarbe[4].g := 0.1; FIdxZuFarbe[4].b := 0;
  FIdxZuFarbe[5].r := 0.4; FIdxZuFarbe[5].g := 0.9; FIdxZuFarbe[5].b := 0.6;
  FIdxZuFarbe[6].r := 0.4; FIdxZuFarbe[6].g := 0.3; FIdxZuFarbe[6].b := 0.1;
  FIdxZuFarbe[7].r := 0.6; FIdxZuFarbe[7].g := 0.1; FIdxZuFarbe[7].b := 0.4;
  FIdxZuFarbe[8].r := 0.7; FIdxZuFarbe[8].g := 0; FIdxZuFarbe[8].b := 0.1;
  FIdxZuFarbe[9].r := 0.9; FIdxZuFarbe[9].g := 0.5; FIdxZuFarbe[9].b := 0.1;
  FIdxZuFarbe[10].r := 0.8; FIdxZuFarbe[10].g := 0.1; FIdxZuFarbe[10].b := 1;
  FIdxZuFarbe[11].r := 0.3; FIdxZuFarbe[11].g := 0.2; FIdxZuFarbe[11].b := 0.6;
  FIdxZuFarbe[12].r := 1; FIdxZuFarbe[12].g := 0.9; FIdxZuFarbe[12].b := 0.3;
  FIdxZuFarbe[13].r := 1; FIdxZuFarbe[13].g := 0.8; FIdxZuFarbe[13].b := 0;
  FIdxZuFarbe[14].r := 1; FIdxZuFarbe[14].g := 1; FIdxZuFarbe[14].b := 1;
  FIdxZuFarbe[15].r := 0; FIdxZuFarbe[15].g := 1; FIdxZuFarbe[15].b := 0;

  //autumn palette
  FIdxZuFarbe[16].r := 0.933; FIdxZuFarbe[16].g := 0.69; FIdxZuFarbe[16].b := 0.388;
  FIdxZuFarbe[17].r := 0.949; FIdxZuFarbe[17].g := 0.855; FIdxZuFarbe[17].b := 0.58;
  FIdxZuFarbe[18].r := 0.886; FIdxZuFarbe[18].g := 0.553; FIdxZuFarbe[18].b := 0.471;
  FIdxZuFarbe[19].r := 0.78; FIdxZuFarbe[19].g := 0.271; FIdxZuFarbe[19].b := 0.208;
  FIdxZuFarbe[20].r := 0.549; FIdxZuFarbe[20].g := 0.165; FIdxZuFarbe[20].b := 0.153;

  //sakura palette
  FIdxZuFarbe[21].r := 0.337; FIdxZuFarbe[21].g := 0.129; FIdxZuFarbe[21].b := 0.208;
  FIdxZuFarbe[22].r := 0.765; FIdxZuFarbe[22].g:= 0.51; FIdxZuFarbe[22].b := 0.62;
  FIdxZuFarbe[23].r := 0.914; FIdxZuFarbe[23].g := 0.694; FIdxZuFarbe[23].b := 0.804;
  FIdxZuFarbe[24].r := 1; FIdxZuFarbe[24].g := 0.906; FIdxZuFarbe[24].b := 0.871;
  FIdxZuFarbe[25].r := 0.988; FIdxZuFarbe[25].g := 0.82; FIdxZuFarbe[25].b := 0.843;
end;

function TFarben.gibFarbe(idx: Cardinal) : TFarbe;
begin
  if (idx = 0) or (idx > high(FIdxZuFarbe)) then idx := 14;
  result := FIdxZuFarbe[idx];
end;

end.


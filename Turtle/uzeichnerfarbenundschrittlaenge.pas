unit uzeichnerfarbenundschrittlaenge;
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, uZeichnerBase;

type TZeichnerFarbenUndSchrittlaenge = class(TZeichnerBase)
  private
    FIdxZuFarbe: array[1..14,0..2] of Real;
    procedure aktionSchrittMtLinie(list: TStringList);
  public
    constructor Create(zeichenPara: TZeichenParameter); override;
    destructor Destroy; override;
end;

implementation
uses uMatrizen,dglOpenGL;

procedure schritt(l:Real;Spur:BOOLEAN;r:Real;g:Real;b:Real);
begin
  if Spur then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(r,g,b);
    glLineWidth(0.01);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure TZeichnerFarbenUndSchrittlaenge.aktionSchrittMtLinie(list: TStringList);
var m: Cardinal;
    colorIdx: Cardinal;
    procedure aux_SchrittUndFarbeUmsetzen;
    begin
      if (colorIdx > high(FIdxZuFarbe)) then colorIdx := 0;
      schritt(1/m,true,FIdxZuFarbe[colorIdx][0],
                       FIdxZuFarbe[colorIdx][1],
                       FIdxZuFarbe[colorIdx][2]); 
    end;
begin
  if (list.Count = 2) then
  begin
    colorIdx := StrToInt(list[0]); m := StrToInt(list[1]); 
  end
  else if (list.Count = 1) then
  begin
    colorIdx := StrToInt(list[0]); m := 50;
  end
  else if (list.Count = 0) then 
  begin
    colorIdx := 14; m := 50
  end;
  aux_SchrittUndFarbeUmsetzen;
end;

constructor TZeichnerFarbenUndSchrittlaenge.Create(zeichenPara: TZeichenParameter);
begin
  inherited;
  FName := 'ZeichnerFarbenUndSchrittlaenge';

  FIdxZuFarbe[1,0] := 0.7; FIdxZuFarbe[1,1] := 0.4; FIdxZuFarbe[1,2] := 0.1;
  FIdxZuFarbe[1,0] := 0.5; FIdxZuFarbe[1,1] := 0.5; FIdxZuFarbe[1,2] := 0.1;
  FIdxZuFarbe[3,0] := 0.5; FIdxZuFarbe[3,1] := 0.7; FIdxZuFarbe[3,2] := 0.3;
  FIdxZuFarbe[4,0] := 0.6; FIdxZuFarbe[4,1] := 0.1; FIdxZuFarbe[4,2] := 0;
  FIdxZuFarbe[5,0] := 0.4; FIdxZuFarbe[5,1] := 0.9; FIdxZuFarbe[5,2] := 0.6;
  FIdxZuFarbe[6,0] := 0.4; FIdxZuFarbe[6,1] := 0.3; FIdxZuFarbe[6,2] := 0.1;
  FIdxZuFarbe[7,0] := 0.6; FIdxZuFarbe[7,1] := 0.1; FIdxZuFarbe[7,2] := 0.4;
  FIdxZuFarbe[8,0] := 0.7; FIdxZuFarbe[8,1] := 0; FIdxZuFarbe[8,2] := 0.1;
  FIdxZuFarbe[9,0] := 0.9; FIdxZuFarbe[9,1] := 0.5; FIdxZuFarbe[9,2] := 0.1;
  FIdxZuFarbe[10,0] := 0.8; FIdxZuFarbe[10,1] := 1; FIdxZuFarbe[10,2] := 1;
  FIdxZuFarbe[11,0] := 0.3; FIdxZuFarbe[11,1] := 0.2; FIdxZuFarbe[11,2] := 0.6;
  FIdxZuFarbe[12,0] := 1; FIdxZuFarbe[12,1] := 0.9; FIdxZuFarbe[12,2] := 0.3;
  FIdxZuFarbe[13,0] := 1; FIdxZuFarbe[13,1] := 0.8; FIdxZuFarbe[13,2] := 0;
  FIdxZuFarbe[14,0] := 1; FIdxZuFarbe[14,1] := 1; FIdxZuFarbe[14,2] := 1;

  FVersandTabelle.AddOrSetData('F',aktionSchrittMtLinie);
end;

destructor TZeichnerFarbenUndSchrittlaenge.Destroy;
begin
  FreeAndNil(FName);
  inherited;
end;
end.


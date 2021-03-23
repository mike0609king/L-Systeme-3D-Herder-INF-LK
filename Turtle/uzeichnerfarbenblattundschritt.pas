unit uZeichnerFarbenBlattUndSchritt;
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, uZeichnerBase;

type TZeichnerFarbenBlattUndSchritt = class(TZeichnerBase)
  private
    FIdxZuFarbe: array[1..15,0..2] of Real;
    procedure aktionSchrittMtLinie(list: TStringList);
		procedure aktionBlatt(list: TStringList);
  public
    constructor Create(zeichenPara: TZeichenParameter); override;
    destructor Destroy; override;
end;

implementation
uses uMatrizen,dglOpenGL;

procedure Blatt(l:Real;Spur:BOOLEAN;r:Real;g:Real;b:Real);
begin
  IF Spur Then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(r,g,b);
    glLineWidth(10);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure TZeichnerFarbenBlattUndSchritt.aktionBlatt(list: TStringList);
var m,colorIdx: Cardinal;
begin
  if list.Count = 0 then colorIdx := 15
  else colorIdx := StrToInt(list[0]);
  if (colorIdx = 0) or (colorIdx > high(FIdxZuFarbe)) then colorIdx := 14;
  m := 50; Blatt(1/m,true,FIdxZuFarbe[colorIdx][0],
                          FIdxZuFarbe[colorIdx][1],
                          FIdxZuFarbe[colorIdx][2]);
end;

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

procedure TZeichnerFarbenBlattUndSchritt.aktionSchrittMtLinie(list: TStringList);
var m,colorIdx: Cardinal;
  procedure aux_SchrittUndFarbeUmsetzen;
  begin
    if (colorIdx = 0) or (colorIdx > high(FIdxZuFarbe)) then colorIdx := 14;
    schritt(1/m,true,FIdxZuFarbe[colorIdx][0],
                     FIdxZuFarbe[colorIdx][1],
                     FIdxZuFarbe[colorIdx][2]); 
  end;
begin
  if (list.Count >= 1) then
  begin
    colorIdx := StrToInt(list[0]); m := 50;
  end
  else 
  begin
    colorIdx := 14; m := 50;
  end;
  aux_SchrittUndFarbeUmsetzen;
end;

constructor TZeichnerFarbenBlattUndSchritt.Create(zeichenPara: TZeichenParameter);
begin
  inherited;
  FName := 'ZeichnerFarbenBlattUndSchritt';

  FIdxZuFarbe[1,0] := 0.7; FIdxZuFarbe[1,1] := 0.4; FIdxZuFarbe[1,2] := 0.1;
  FIdxZuFarbe[2,0] := 0.5; FIdxZuFarbe[2,1] := 0.5; FIdxZuFarbe[2,2] := 0.1;
  FIdxZuFarbe[3,0] := 0.5; FIdxZuFarbe[3,1] := 0.7; FIdxZuFarbe[3,2] := 0.3;
  FIdxZuFarbe[4,0] := 0.6; FIdxZuFarbe[4,1] := 0.1; FIdxZuFarbe[4,2] := 0;
  FIdxZuFarbe[5,0] := 0.4; FIdxZuFarbe[5,1] := 0.9; FIdxZuFarbe[5,2] := 0.6;
  FIdxZuFarbe[6,0] := 0.4; FIdxZuFarbe[6,1] := 0.3; FIdxZuFarbe[6,2] := 0.1;
  FIdxZuFarbe[7,0] := 0.6; FIdxZuFarbe[7,1] := 0.1; FIdxZuFarbe[7,2] := 0.4;
  FIdxZuFarbe[8,0] := 0.7; FIdxZuFarbe[8,1] := 0; FIdxZuFarbe[8,2] := 0.1;
  FIdxZuFarbe[9,0] := 0.9; FIdxZuFarbe[9,1] := 0.5; FIdxZuFarbe[9,2] := 0.1;
  FIdxZuFarbe[10,0] := 0.8; FIdxZuFarbe[10,1] := 0.1; FIdxZuFarbe[10,2] := 1;
  FIdxZuFarbe[11,0] := 0.3; FIdxZuFarbe[11,1] := 0.2; FIdxZuFarbe[11,2] := 0.6;
  FIdxZuFarbe[12,0] := 1; FIdxZuFarbe[12,1] := 0.9; FIdxZuFarbe[12,2] := 0.3;
  FIdxZuFarbe[13,0] := 1; FIdxZuFarbe[13,1] := 0.8; FIdxZuFarbe[13,2] := 0;
  FIdxZuFarbe[14,0] := 1; FIdxZuFarbe[14,1] := 1; FIdxZuFarbe[14,2] := 1;
  FIdxZuFarbe[15,0] := 0; FIdxZuFarbe[15,1] := 1; FIdxZuFarbe[15,2] := 0;

  FVersandTabelle.AddOrSetData('F',aktionSchrittMtLinie);
  FVersandTabelle.AddOrSetData('B',aktionBlatt);
end;

destructor TZeichnerFarbenBlattUndSchritt.Destroy;
begin
  FreeAndNil(FName);
  inherited;
end;
end.

unit uZeichnerFarbenBlattUndSchritt;
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, uZeichnerBase, uFarben;

type TZeichnerFarbenBlattUndSchritt = class(TZeichnerBase)
  private
    farben: TFarben;
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
var m,colorIdx: Cardinal; farbe: TFarbe;
begin
  if list.Count = 0 then colorIdx := 15
  else colorIdx := StrToInt(list[0]);
  farbe := farben.gibFarbe(colorIdx);
  m := 50; Blatt(1/m,true,farbe.r,farbe.g,farbe.b);
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
var m,colorIdx: Cardinal; farbe: TFarbe;
  procedure aux_SchrittUndFarbeUmsetzen;
  begin
    farbe := farben.gibFarbe(colorIdx);
    schritt(1/m,true,farbe.r,farbe.g,farbe.b);
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
  farben.initColor;

  FVersandTabelle.AddOrSetData('F',aktionSchrittMtLinie);
  FVersandTabelle.AddOrSetData('B',aktionBlatt);
end;

destructor TZeichnerFarbenBlattUndSchritt.Destroy;
begin
  FreeAndNil(FName);
  inherited;
end;
end.

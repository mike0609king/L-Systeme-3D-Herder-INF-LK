unit uzeichnerSchrittlaenge;
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, uZeichnerBase, fgl;

type TZeichnerSchrittlaenge = class(TZeichnerBase)
  private
    FIdxZuFarbe: array[1..14,0..2] of Real;
    procedure aktionSchrittMtLinie(list: TStringList);
  public
    constructor Create(zeichenPara: TZeichenParameter); override;
    destructor Destroy; override;
end;

implementation
uses uMatrizen,dglOpenGL;

procedure schritt(l:Real;Spur:BOOLEAN);
begin
  if Spur then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(1,1,1);
    glLineWidth(0.01);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure TZeichnerSchrittlaenge.aktionSchrittMtLinie(list: TStringList);
var m: Cardinal;
    colorIdx: Cardinal;
begin
    m := StrToInt(list[0]); 
    if (colorIdx > high(FIdxZuFarbe)) then colorIdx := 0;
    schritt(1/m,true); 
end;

constructor TZeichnerSchrittlaenge.Create(zeichenPara: TZeichenParameter);
begin
  inherited;
  FName := 'ZeichnerSchrittlaenge';
  FVersandTabelle.AddOrSetData('F',aktionSchrittMtLinie);
end;

destructor TZeichnerSchrittlaenge.Destroy;
begin
  FreeAndNil(FName);
  inherited;
end;
end.


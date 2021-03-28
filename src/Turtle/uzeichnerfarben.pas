unit uZeichnerFarben;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, uZeichnerBase, fgl, uFarben;

type TZeichnerFarben = class(TZeichnerBase)
  private
    FFarben: TFarben;

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

procedure TZeichnerFarben.aktionSchrittMtLinie(list: TStringList);
var m,colorIdx: Cardinal; farbe: TFarbe;
begin
    colorIdx := StrToInt(list[0]); m := 50; 
    farbe := FFarben.gibFarbe(colorIdx);
    schritt(1/m,true,farbe.r,farbe.g,farbe.b);
end;

constructor TZeichnerFarben.Create(zeichenPara: TZeichenParameter);
begin
  inherited;
  FName := 'ZeichnerFarben';
  FFarben.initColor;

  FVersandTabelle.AddOrSetData('F',aktionSchrittMtLinie);
end;

destructor TZeichnerFarben.Destroy;
begin
  FreeAndNil(FName);
  inherited;
end;
end.

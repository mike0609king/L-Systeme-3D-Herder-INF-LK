unit uZeichnerGruenesBlatt;

{$mode delphi}

interface

uses
  Classes, SysUtils, uZeichnerBase;

type TZeichnerGruenesBlatt = class(TZeichnerBase)
    private
        procedure aktionBlatt;
    public
        constructor Create(zeichenPara: TZeichenParameter); override;
        destructor Destroy; override;
end;

implementation
uses uMatrizen,dglOpenGL;

procedure Blatt(l:Real;Spur:BOOLEAN);
begin
  IF Spur Then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(0,1,0);
    glLineWidth(10);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure TZeichnerGruenesBlatt.aktionBlatt;
var m: Cardinal;
begin
    m := 50;
    Blatt(1/m,true);
end;

constructor TZeichnerGruenesBlatt.Create(zeichenPara: TZeichenParameter);
begin
    inherited;
    FName := 'ZeichnerGruenesBlatt';
    FVersandTabelle.AddOrSetData('B',aktionBlatt);
end;

//?
destructor TZeichnerGruenesBlatt.Destroy;
begin
  FreeAndNil(FName);
  inherited;
end;

end.


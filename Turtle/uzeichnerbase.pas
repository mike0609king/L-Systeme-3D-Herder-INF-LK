unit uZeichnerBase;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl;


type TPunkt3D = record
    x,y,z:Real;
end;

type TZeichenParameter = record
     winkel: Real;
     rekursionsTiefe: Cardinal;
     startPunkt: TPunkt3D;
     procedure setzeStartPunkt(x,y,z: Real);
end;

type TProc = procedure of object;
type TVersandTabelle = {specialize} TFPGMap<char, TProc>;
type TZeichnerBase = class
    private
        FVersandTabelle: TVersandTabelle;
        FZeichenParameter: TZeichenParameter;

        // Bewegungen
        procedure aktionSchrittMitLinie;
        procedure aktionSchrittOhneLinie;
        procedure aktionPlus;
        procedure aktionMinus;
        procedure aktionUnd;
        procedure aktionDach;
        procedure aktionFSlash;
        procedure aktionBSlash;
        procedure aktionPush;
        procedure aktionPop;

        procedure aktionBlatt;

        // setter-funktionen
        procedure setzeWinkel(const phi: Real);
        procedure setzeRekursionsTiefe(const tiefe: Cardinal);
    public
        constructor Create(zeichenPara: TZeichenParameter); virtual;
        procedure zeichneBuchstabe(c: char); virtual;

        procedure setzeStartPunkt(x,y,z: Real);

        // properties
        //// FZeichenParameter
        property winkel: Real read FZeichenParameter.winkel write setzeWinkel;
        property rekursionsTiefe: Cardinal read FZeichenParameter.rekursionsTiefe write setzeRekursionsTiefe;
        property startPunkt: TPunkt3D read FZeichenParameter.startPunkt;
end;

implementation
uses uMatrizen,dglOpenGL;

procedure TZeichenParameter.setzeStartPunkt(x,y,z: Real);
begin
    startPunkt.x := x;
    startPunkt.y := y;
    startPunkt.z := z;
end;

procedure TZeichnerBase.setzeWinkel(const phi: Real);
begin
    FZeichenParameter.winkel := phi;
end;

procedure TZeichnerBase.setzeRekursionsTiefe(const tiefe: Cardinal);
begin
    FZeichenParameter.rekursionsTiefe := tiefe;
end;

procedure TZeichnerBase.setzeStartPunkt(x,y,z: Real);
begin
    FZeichenParameter.setzeStartPunkt(x,y,z);
end;

procedure TZeichnerBase.zeichneBuchstabe(c: char);
var tmp: TProc;
begin
    if FVersandTabelle.tryGetData(c,tmp) then tmp;
end;

//////////////////////////////////////////////////////////
// Bewegung der Turtle
//////////////////////////////////////////////////////////

//// hilfs proceduren
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

procedure X_Rot(a:Real);
begin
  ObjUmEigenKOSDrehen(a,0,0,0,1,0,0);
end;

procedure Y_Rot(a:Real);
begin
  ObjUmEigenKOSDrehen(a,0,0,0,0,1,0)
end;

procedure Z_Rot(a:Real);
begin
  ObjUmEigenKOSDrehen(a,0,0,0,0,0,1)
end;

{
procedure TZeichnerBase.kehrt;
begin
  ObjUmEigenKOSDrehen(180,0,0,0,0,0,1)
end;
}

//// feste Aktionen der Versandtabelle
procedure TZeichnerBase.aktionSchrittMitLinie;
var m: Cardinal;
begin
    m := 50; // spaeter parametrisieren
    schritt(1/m,true);
end;

procedure TZeichnerBase.aktionSchrittOhneLinie;
var m: Cardinal;
begin
    m := 50; // spaeter parametrisieren
    schritt(1/m,false);
end;

procedure TZeichnerBase.aktionPlus;
begin
    Z_Rot(FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionMinus;
begin
    Z_Rot(-FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionUnd;
begin
    Y_Rot(FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionDach;
begin
    Y_Rot(-FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionFSlash;
begin
    X_Rot(FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionBSlash;
begin
    X_Rot(-FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionPush;
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glLoadMatrixf(@OMatrix.o);
  glPushMatrix;
end;

procedure TZeichnerBase.aktionPop;
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glPopMatrix;
  glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
end;

// soll danach raus (mit abstraktion loesen...)
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

procedure TZeichnerBase.aktionBlatt;
begin
    Blatt(1/50,true);
end;

constructor TZeichnerBase.Create(zeichenPara: TZeichenParameter);
begin
    FZeichenParameter := zeichenPara;
    FVersandTabelle := TVersandTabelle.Create;
    FVersandTabelle.add('F',aktionSchrittMitLinie);
    FVersandTabelle.add('f',aktionSchrittOhneLinie);
    FVersandTabelle.add('+',aktionPlus);
    FVersandTabelle.add('-',aktionMinus);
    FVersandTabelle.add('&',aktionUnd);
    FVersandTabelle.add('^',aktionDach);
    FVersandTabelle.add('/',aktionFSlash);
    FVersandTabelle.add('\',aktionBSlash);
    FVersandTabelle.add('[',aktionPush);
    FVersandTabelle.add(']',aktionPop);

    FVersandTabelle.add('B',aktionBlatt);
end;

end.


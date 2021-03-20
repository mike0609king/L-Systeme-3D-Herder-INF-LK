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
     function copy : TZeichenParameter;
end;

type TProc = procedure(list: TStringList) of object;
type TVersandTabelle = TFPGMap<char, TProc>;
type TZeichnerBase = class
  protected
    FName: String;
    FVersandTabelle: TVersandTabelle;
    FZeichenParameter: TZeichenParameter;
  private
    // Bewegungen
    procedure aktionSchrittMitLinie(list: TStringList);
    procedure aktionSchrittOhneLinie(list: TStringList);
    procedure aktionPlus(list: TStringList);
    procedure aktionMinus(list: TStringList);
    procedure aktionUnd(list: TStringList);
    procedure aktionDach(list: TStringList);
    procedure aktionFSlash(list: TStringList);
    procedure aktionBSlash(list: TStringList);
    procedure aktionPush(list: TStringList);
    procedure aktionPop(list: TStringList);

    // setter-funktionen
    procedure setzeWinkel(const phi: Real);
    procedure setzeRekursionsTiefe(const tiefe: Cardinal);
  public
    constructor Create(zeichenPara: TZeichenParameter); virtual;
    destructor Destroy; override;

    procedure zeichneBuchstabe(c: char; list: TStringList); virtual;
    function copy : TZeichnerBase;

    procedure setzeStartPunkt(x,y,z: Real);
    function gibZeichenParameter : TZeichenParameter;

    // properties
    //// FZeichenParameter
    property winkel: Real read FZeichenParameter.winkel write setzeWinkel;
    property rekursionsTiefe: Cardinal read FZeichenParameter.rekursionsTiefe write setzeRekursionsTiefe;
    property startPunkt: TPunkt3D read FZeichenParameter.startPunkt;
    property name: String read FName;
end;

implementation
uses uMatrizen,dglOpenGL,uZeichnerInit;

procedure TZeichenParameter.setzeStartPunkt(x,y,z: Real);
begin
  startPunkt.x := x;
  startPunkt.y := y;
  startPunkt.z := z;
end;

function TZeichenParameter.copy : TZeichenParameter;
var zeichenPara: TZeichenParameter;
begin
  zeichenPara.winkel := winkel;
  zeichenPara.rekursionsTiefe := rekursionsTiefe;
  zeichenPara.setzeStartPunkt(startPunkt.x, startPunkt.y, startPunkt.z);
  result := zeichenPara;
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

function TZeichnerBase.gibZeichenParameter : TZeichenParameter;
begin
  result := FZeichenParameter;
end;

procedure TZeichnerBase.zeichneBuchstabe(c: char; list: TStringList);
var tmp: TProc;
begin
  if FVersandTabelle.tryGetData(c,tmp) then tmp(list);
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
procedure TZeichnerBase.aktionSchrittMitLinie(list: TStringList);
var m: Cardinal;
begin
  m := 50; // spaeter parametrisieren
  schritt(1/m,true);
end;

procedure TZeichnerBase.aktionSchrittOhneLinie(list: TStringList);
var m: Cardinal;
begin
  m := 50; // spaeter parametrisieren
  schritt(1/m,false);
end;

procedure TZeichnerBase.aktionPlus(list: TStringList);
begin
  Z_Rot(FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionMinus(list: TStringList);
begin
  Z_Rot(-FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionUnd(list: TStringList);
begin
  Y_Rot(FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionDach(list: TStringList);
begin
  Y_Rot(-FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionFSlash(list: TStringList);
begin
  X_Rot(FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionBSlash(list: TStringList);
begin
  X_Rot(-FZeichenParameter.winkel);
end;

procedure TZeichnerBase.aktionPush(list: TStringList);
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glLoadMatrixf(@OMatrix.o);
  glPushMatrix;
end;

procedure TZeichnerBase.aktionPop(list: TStringList);
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glPopMatrix;
  glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
end;

function TZeichnerBase.copy : TZeichnerBase;
var zeichnerInit: TZeichnerInit;
begin
  zeichnerInit := TZeichnerInit.Create;
  result := zeichnerinit.initialisiere(FName, FZeichenParameter.copy);
end;

constructor TZeichnerBase.Create(zeichenPara: TZeichenParameter);
begin
  FName := 'ZeichnerBase';
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
end;

destructor TZeichnerBase.Destroy;
begin
  FreeAndNil(FName);
  FreeAndNil(FZeichenParameter);
  FreeAndNil(FVersandTabelle)
end;

end.


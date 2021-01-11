unit uTurtle;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl, uGrammatik, uStringEntwickler, uZeichnerBase;

type TObjekte = (kw,gw,p,kq,gq,d);

// Die Entitaet, die sich auf dem Bildschirm herumbewegt,
// um den L-Baum zu zeichnen
type TTurtle = class
    private
        FGrammatik: TGrammatik;
        FZeichner: TZeichnerBase; // poly...
        FStringEntwickler: TStringEntwickler;

        // setter-Funktionen
        procedure setzeWinkel(const phi: Real);
        procedure setzeRekursionsTiefe(const tiefe: Cardinal);
    public
        constructor Create(gram: TGrammatik; zeichner: TZeichnerBase);
        destructor Destroy; override;

        // properties
        //// FGrammatik
        property axiom: String read FGrammatik.axiom;
        property regeln: TRegelDictionary read FGrammatik.regeln;
        //// FZeichenParameter
        //property winkel: Real read FZeichner.winkel write setzeWinkel;
        //property rekursionsTiefe: Cardinal read FZeichner.rekursionsTiefe write setzeRekursionsTiefe;
        //property startPunkt: TPunkt3D read FZeichner.startPunkt;

        // setter-Funktionen
        procedure setzeStartPunkt(const x,y,z: Real);

        procedure zeichnen;
end;

VAR ersetzung: String;
    objekt: TObjekte;

implementation

uses uMatrizen,dglOpenGL;

constructor TTurtle.Create(gram: TGrammatik; zeichner: TZeichnerBase);
begin
    FGrammatik := gram;
    FZeichner := zeichner;
    FStringEntwickler := TStringEntwickler.Create(gram);
end;

destructor TTurtle.Destroy;
begin
    // to be done
end;

//////////////////////////////////////////////////////////
// setter-Funktionen
//////////////////////////////////////////////////////////
procedure TTurtle.setzeWinkel(const phi: Real);
begin
    FZeichner.winkel := phi;
end;

procedure TTurtle.setzeRekursionsTiefe(const tiefe: Cardinal);
begin
    FZeichner.rekursionsTiefe := tiefe;
end;

procedure TTurtle.setzeStartPunkt(const x,y,z: Real);
begin
    FZeichner.setzeStartPunkt(x,y,z);
end;

// Parameter: Startpunkt der Turtle
procedure init (sx,sy,sz:Real);
begin
  glMatrixMode(GL_ModelView);
  glClearColor (0,0,0,0);
  ObjKOSInitialisieren;
  ObjInEigenKOSVerschieben(sx,sy,sz);
end;

{
//////////////////////////////////////////////////////////
// Bewegung der Turtle
//////////////////////////////////////////////////////////

procedure Schritt(l:Real;Spur:BOOLEAN);
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

procedure kehrt;
begin
  ObjUmEigenKOSDrehen(180,0,0,0,0,0,1)
end;

procedure Push;
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glLoadMatrixf(@OMatrix.o);
  glPushMatrix;
end;

procedure Pop;
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glPopMatrix;
  glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
end;

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
}

procedure TTurtle.zeichnen;
VAR i: Cardinal;
{
   // m: Laenge der Linien
   // n: Anzahl der uebrigen Rekursionen
   procedure rekErsetzung (m,n:CARDINAL;s:String);
   begin
      WHILE s<>'' DO
      begin
        CASE s[1] of
          'F': schritt (1/m,TRUE);
          'f':schritt (1/m,FALSE);
          '+':Z_Rot (FZeichenParameter.winkel);
          '-':Z_Rot (-FZeichenParameter.winkel);
          '&':Y_Rot (FZeichenParameter.winkel);
          '^':Y_Rot (-FZeichenParameter.winkel);
          '/':X_Rot (FZeichenParameter.winkel);
          '\':X_Rot (-FZeichenParameter.winkel);
          '[':Push;
          ']':Pop;
          'B':Blatt(1/m,True);
        end;
        delete(s,1,1);
      end;
   end;
}
begin
  init(FZeichner.startPunkt.x,FZeichner.startPunkt.y,FZeichner.startPunkt.z);
  FStringEntwickler.entwickeln(FZeichner.rekursionsTiefe);
  //rekErsetzung(50,FZeichenParameter.rekursionsTiefe,FStringEntwickler.entwickelterString);
  for i := 1 to length(FStringEntwickler.entwickelterString) do
  begin
      FZeichner.zeichneBuchstabe(FStringEntwickler.entwickelterString[i]);
  end;
end;

end.


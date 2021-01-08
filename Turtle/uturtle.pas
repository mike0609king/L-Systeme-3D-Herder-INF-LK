unit uTurtle;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl;

type TObjekte = (kw,gw,p,kq,gq,d);

type TRegelDictionary = TFPGMap<Char,String>;

type TPunkt3D = record
    sx,sy,sz:Real
end;

type TZeichenParameter = record
     //zeichenart:TZeichenart;
     winkel: Real;
     rekursionsTiefe: Cardinal;
     //startPunkt: TPunkt3D;
     //zufaelligkeiten: Real;
end;

type TGrammatik = record
    axiom: String;
    //regeln: TRegelDictionary;

    regeln: String; //testing
end;

// Die Entitaet, die sich auf dem Bildschirm herumbewegt,
// um den L-Baum zu zeichnen
type TTurtle = class
    private
        FGrammatik: TGrammatik;
        FZeichenParameter: TZeichenParameter;

        // setter-Funktionen
        procedure setzeWinkel(const phi: Real);
        procedure setzeRekursionsTiefe(const tiefe: Cardinal);
    public
        constructor Create(gram: TGrammatik; zeichenPara: TZeichenParameter);

        property axiom: String read FGrammatik.axiom;
        property regeln: String read FGrammatik.regeln
        property winkel: Real read FZeichenParameter.winkel write setzeWinkel;
        property rekursionsTiefe: Cardinal read FZeichenParameter.rekursionsTiefe write setzeRekursionsTiefe;

        procedure zeichnen;
end;

VAR ersetzung: String;
    objekt: TObjekte;

{
procedure init (sx,sy,sz,bx,by,bz:Real);
procedure Schritt (l:Real;Spur:BOOLEAN);
procedure X_Rot (a:Real);
procedure Y_Rot (a:Real);
procedure Z_Rot (a:Real);
procedure kehrt;
procedure Push;
procedure Pop;
}

implementation

uses uMatrizen,dglOpenGL;

constructor TTurtle.Create(gram: TGrammatik; zeichenPara: TZeichenParameter);
begin
    FGrammatik := gram;
    FZeichenParameter := zeichenPara;
end;

// setter-Funktionen
procedure TTurtle.setzeWinkel(const phi: Real);
begin
    FZeichenParameter.winkel := phi;
end;

procedure TTurtle.setzeRekursionsTiefe(const tiefe: Cardinal);
begin
    FZeichenParameter.rekursionsTiefe := tiefe;
end;


// Parameter: Startpunkt der Turtle und (Bufferwert?)
procedure init (sx,sy,sz,bx,by,bz:Real);
begin
  glMatrixMode(GL_ModelView);
  glClearColor (0,0,0,0);
  ObjKOSInitialisieren;
  ObjInEigenKOSVerschieben(sx,sy,sz);
end;

procedure Schritt (l:Real;Spur:BOOLEAN);
begin
  if Spur then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(1,1,1);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure X_Rot (a:Real);
begin
  ObjUmEigenKOSDrehen(a,0,0,0,1,0,0);
end;

procedure Y_Rot (a:Real);
begin
  ObjUmEigenKOSDrehen (a,0,0,0,0,1,0)
end;

procedure Z_Rot (a:Real);
begin
  ObjUmEigenKOSDrehen (a,0,0,0,0,0,1)
end;

procedure kehrt;
begin
  ObjUmEigenKOSDrehen (180,0,0,0,0,0,1)
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

procedure Blatt (l:Real;Spur:BOOLEAN);
begin
  IF Spur Then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(0,1,0);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;


procedure TTurtle.zeichnen;
VAR hs:String;
   // m: Anzahl der zeichenbaren Buchstaben
   // n: Anzahl der uebrigen Rekursionen
   procedure rekErsetzung (m,n:CARDINAL;s:String);
   begin
      WHILE s<>'' DO
      begin
        CASE s[1] of
          'F':IF n=0 THEN schritt (1/m,TRUE)
              ELSE
              BEGIN
                 //delete (hs,1,1);
                 //Push;
                 rekErsetzung(m,n-1,ersetzung);
                 //Pop
              end;
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
        delete (s,1,1);
      end;
   end;
begin
  hs:=FGrammatik.axiom;
  ersetzung := FGrammatik.regeln;
  init (0,0,0,0,0,0);
  rekErsetzung (20,FZeichenParameter.rekursionsTiefe,hs);
end;

// testing
begin
  {
  hs:='F';
  ersetzung:='F&[+F&&FB]&&F[-^^/^-FB]F';
  phi:=47.5;
  }
end.


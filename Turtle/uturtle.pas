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

        FVisible: Boolean;

        // setter-Funktionen
        procedure setzeWinkel(const phi: Real);
        procedure setzeRekursionsTiefe(const tiefe: Cardinal);
        procedure setzeVisible(const vis: Boolean);

        // getter-Funktionen (die normale read Routine funktioniert hier nicht)
        function gibRekursionsTiefe : Cardinal;
        function gibWinkel : Real;
        function gibStartPunkt : TPunkt3D;
    public
        constructor Create(gram: TGrammatik; zeichner: TZeichnerBase);
        destructor Destroy; override;

        // properties
        //// FGrammatik
        property axiom: String read FGrammatik.axiom;
        property regeln: TRegelDictionary read FGrammatik.regeln;
        //// FZeichner
        property winkel: Real read gibWinkel write setzeWinkel;
        property rekursionsTiefe: Cardinal read gibRekursionsTiefe write setzeRekursionsTiefe;
        property startPunkt: TPunkt3D read gibStartPunkt;
        //// 
        property visible: Boolean read FVisible write setzeVisible;

        // setter-Funktionen (public)
        procedure setzeStartPunkt(const x,y,z: Real);

        procedure zeichnen;
end;

VAR objekt: TObjekte;

implementation

uses uMatrizen,dglOpenGL;

constructor TTurtle.Create(gram: TGrammatik; zeichner: TZeichnerBase);
begin
    FGrammatik := gram;
    FZeichner := zeichner;
    FStringEntwickler := TStringEntwickler.Create(gram);
    FStringEntwickler.entwickeln(FZeichner.rekursionsTiefe);
    FVisible := true;
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
    FStringEntwickler.entwickeln(FZeichner.rekursionsTiefe);
end;

procedure TTurtle.setzeStartPunkt(const x,y,z: Real);
begin
    FZeichner.setzeStartPunkt(x,y,z);
end;

procedure TTurtle.setzeVisible(const vis: Boolean);
begin
    FVisible := vis;
end;

// Parameter: Startpunkt der Turtle
procedure init(sx,sy,sz:Real);
begin
  glMatrixMode(GL_ModelView);
  //glClearColor(0,0,0,0) 
  ObjKOSInitialisieren;
  ObjInEigenKOSVerschieben(sx,sy,sz);
end;

//////////////////////////////////////////////////////////
// getter-Funktionen
//////////////////////////////////////////////////////////
function TTurtle.gibRekursionsTiefe : Cardinal;
begin
    result := FZeichner.rekursionsTiefe;
end;

function TTurtle.gibWinkel : Real;
begin
    result := FZeichner.winkel;
end;

function TTurtle.gibStartPunkt : TPunkt3D;
begin
    result := FZeichner.startPunkt;
end;


// zeichner
procedure TTurtle.zeichnen;
VAR i: Cardinal;
begin
  init(FZeichner.startPunkt.x,FZeichner.startPunkt.y,FZeichner.startPunkt.z);
  for i := 1 to length(FStringEntwickler.entwickelterString) do
  begin
      FZeichner.zeichneBuchstabe(FStringEntwickler.entwickelterString[i]);
  end;
end;

end.


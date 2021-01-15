unit uTurtle;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl, uGrammatik, uStringEntwickler, uZeichnerBase, fpjson, jsonparser, jsonConf;

type TObjekte = (kw,gw,p,kq,gq,d);

// Die Entitaet, die sich auf dem Bildschirm herumbewegt,
// um den L-Baum zu zeichnen
type TTurtle = class
    private
        FGrammatik: TGrammatik;
        FZeichner: TZeichnerBase; // poly...
        FStringEntwickler: TStringEntwickler;

        FName: String;
        FVisible: Boolean;

        // setter-Funktionen
        procedure setzeWinkel(const phi: Real);
        procedure setzeRekursionsTiefe(const tiefe: Cardinal);
        procedure setzeVisible(const vis: Boolean);
        procedure setzeName(const name: String);

        // getter-Funktionen (die normale read Routine funktioniert hier nicht)
        function gibRekursionsTiefe : Cardinal;
        function gibWinkel : Real;
        function gibStartPunkt : TPunkt3D;
    public
        constructor Create(gram: TGrammatik; zeichner: TZeichnerBase);// overload;
        //constructor Create(datei: String); overload;
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
        property name: String read FName write setzeName;

        // setter-Funktionen (public)
        procedure setzeStartPunkt(const x,y,z: Real);

        procedure zeichnen;
        procedure speichern(datei: String);
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
{
constructor TTurtle.Create(datei: String);
var
  conf: TJSONConfig;
begin
  c:= TJSONConfig.Create(Nil);
  try
    c.Filename:= GetCurrentDir+'\test.json';
    writeLn(c.GetValue('test', test));
    writeLn(c.GetValue('test4', s));
    writeLn(c.GetValue('testK', test));
    writeLn(c.GetValue('testD', test));
  finally
    c.Free;
  end;
end;
}
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

procedure TTurtle.setzeName(const name: String);
begin
    FName := name;
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


// speichern
procedure TTurtle.speichern(datei: String);
var regelIdx, produktionIdx: Cardinal;
    conf: TJSONConfig;
    tmp_path: String;
begin
  conf:= TJSONConfig.Create(Nil);
    try
        DeleteFile(datei);
        conf.Filename:= datei;

        conf.SetValue('Grammatik/axiom', FGrammatik.axiom);
        
        for regelIdx := 0 to FGrammatik.regeln.Count - 1 do
        begin
            tmp_path := 'Grammatik/regeln/' + FGrammatik.regeln.keys[regelIdx] + '/Regel ';
            for produktionIdx := 0 to (FGrammatik.regeln.data[regelIdx]).Count - 1 do
            begin
                conf.SetValue(
                    tmp_path + IntToStr(produktionIdx+1) + '/produktion',
                    FGrammatik.regeln.data[regelIdx][produktionIdx].produktion
                );

                conf.SetValue(
                    tmp_path + IntToStr(produktionIdx+1) + '/zufaelligkeit',
                    FGrammatik.regeln.data[regelIdx][produktionIdx].zufaelligkeit
                );
            end;
        end;
    finally
        conf.Free;
  end;
end;

end.

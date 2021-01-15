unit uTurtle;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl, uGrammatik, uStringEntwickler, uZeichnerBase, 
  fpjson, jsonparser, jsonConf,
  uZeichnerInit;

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
        constructor Create(gram: TGrammatik; zeichner: TZeichnerBase); overload;
        constructor Create(datei: String); overload;
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
    FName := '';
    FVisible := true;
end;

constructor TTurtle.Create(datei: String);
var conf: TJSONConfig;
    tmp_pfad, tmp_produktion: String;
    tmp_zufaelligkeit: Real;
    regelnLinkeSeite, regelnRechteSeite: TStringList;
    regelnLinkeSeiteIdx, regelnRechteSeiteIdx: Cardinal;
    zeichenPara: TZeichenParameter;
    zeichnerInit: TZeichnerInit;
    zeichenArt: String;
begin
    FGrammatik := TGrammatik.Create;
    conf:= TJSONConfig.Create(nil);
    regelnRechteSeite := TStringList.Create;
    regelnLinkeSeite := TStringList.Create;
    try
        conf.filename:= datei;
        FName := AnsiString(conf.getValue('name', ''));
        FVisible := conf.getValue('visible', true);

        zeichenArt := AnsiString(conf.getValue('Zeichen Art', ''));

        zeichenPara.winkel := conf.getValue(
            'Zeichen Parameter/winkel', 45
        );
        zeichenPara.rekursionsTiefe := conf.getValue(
            'Zeichen Parameter/rekursions Tiefe', 0
        );
        zeichenPara.setzeStartPunkt(
            conf.getValue('Zeichen Parameter/startPunkt/x', 0),
            conf.getValue('Zeichen Parameter/startPunkt/y', 0),
            conf.getValue('Zeichen Parameter/startPunkt/z', 0)
        );

        FGrammatik.axiom := AnsiString(conf.getValue('Grammatik/axiom', ''));
        // if axiom = '' then // exception

        conf.EnumSubKeys(UnicodeString('Grammatik/regeln/'),regelnLinkeSeite);
        for regelnLinkeSeiteIdx := 0 to regelnLinkeSeite.Count - 1 do
        begin
            tmp_pfad := 'Grammatik/regeln/' + regelnLinkeSeite[regelnLinkeSeiteIdx];
            conf.EnumSubKeys(UnicodeString(tmp_pfad), regelnRechteSeite);
            for regelnRechteSeiteIdx := 0 to regelnRechteSeite.Count - 1 do
            begin
                tmp_produktion := AnsiString(conf.getValue(
                    UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/produktion'), 
                    ''
                ));
                tmp_zufaelligkeit := conf.getValue(
                    UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/zufaelligkeit'), 
                    0.0
                );
                FGrammatik.addRegel(
                    regelnLinkeSeite[regelnLinkeSeiteIdx][1], // es wird nur ein Buchstabe akzeptiert
                    tmp_produktion,
                    tmp_zufaelligkeit
                );
            end;
        end;
    finally
        conf.Free;
    end;
    FStringEntwickler := TStringEntwickler.Create(FGrammatik);
    zeichnerinit := TZeichnerInit.Create;
    FZeichner := zeichnerinit.initialisiere(zeichenArt, zeichenPara);
    FStringEntwickler.entwickeln(FZeichner.rekursionsTiefe);
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

        conf.setValue('name', UnicodeString(FName));
        conf.setValue('visible', FVisible);
        
        conf.setValue('Zeichen Art', FZeichner.name);

        conf.setValue('Zeichen Parameter/winkel', FZeichner.winkel);
        conf.setValue('Zeichen Parameter/rekursions Tiefe', FZeichner.rekursionsTiefe);
        conf.setValue('Zeichen Parameter/startPunkt/x', FZeichner.startPunkt.x);
        conf.setValue('Zeichen Parameter/startPunkt/y', FZeichner.startPunkt.y);
        conf.setValue('Zeichen Parameter/startPunkt/z', FZeichner.startPunkt.z);
        
        conf.setValue('Grammatik/axiom', UnicodeString(FGrammatik.axiom));
        for regelIdx := 0 to FGrammatik.regeln.Count - 1 do
        begin
            tmp_path := 'Grammatik/regeln/' + FGrammatik.regeln.keys[regelIdx] + '/Regel ';
            for produktionIdx := 0 to (FGrammatik.regeln.data[regelIdx]).Count - 1 do
            begin
                conf.setValue(
                    UnicodeString(tmp_path + IntToStr(produktionIdx+1) + '/produktion'),
                    UnicodeString(FGrammatik.regeln.data[regelIdx][produktionIdx].produktion)
                );

                conf.setValue(
                    UnicodeString(tmp_path + IntToStr(produktionIdx+1) + '/zufaelligkeit'),
                    FGrammatik.regeln.data[regelIdx][produktionIdx].zufaelligkeit
                );
            end;
        end;
    finally
        conf.Free;
  end;
end;

end.

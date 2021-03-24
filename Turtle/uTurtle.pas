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
    FMaximaleStringLaenge: Int64;

    // setter-Funktionen
    procedure setzeWinkel(const phi: Real);
    procedure setzeRekursionsTiefe(const tiefe: Cardinal);
    procedure setzeVisible(const vis: Boolean);
    procedure setzeName(const name: String);
    procedure setzeMaximaleStringLaenge(const mxStringLaenge: Int64);

    // getter-Funktionen (die normale read Routine funktioniert hier nicht)
    function gibRekursionsTiefe : Cardinal;
    function gibWinkel : Real;
    function gibStartPunkt : TPunkt3D;
    function gibZeichnerName : String;
    function gibEntwickelterString : String;
    function gibAxiom : String;
  public
    constructor Create(gram: TGrammatik; zeichner: TZeichnerBase; maximaleStringLaenge: Int64=100000); overload;
    constructor Create(gram: TGrammatik; zeichner: TZeichnerBase; stringEntwickler: TStringEntwickler; 
                       maximaleStringLaenge: Int64=100000); overload;
    constructor Create(datei: String); overload;
    destructor Destroy; override;

    // properties
    //// FGrammatik
    property axiom: String read gibAxiom;
    property regeln: TRegelDictionary read FGrammatik.regeln;
    //// FZeichner
    property zeichnerName: String read gibZeichnerName; 
    property winkel: Real read gibWinkel write setzeWinkel;
    property rekursionsTiefe: Cardinal read gibRekursionsTiefe write setzeRekursionsTiefe;
    property startPunkt: TPunkt3D read gibStartPunkt;
    //// 
    property visible: Boolean read FVisible write setzeVisible;
    property name: String read FName write setzeName;
    property maximaleStringLaenge: Int64 read FMaximaleStringLaenge write setzeMaximaleStringLaenge;

    property zuZeichnenderString: String read gibEntwickelterString;

    // setter-Funktionen (public)
    procedure setzeStartPunkt(const x,y,z: Real);
    procedure setzeZeichnerName(const neuerName: String);
    procedure aendereParameter(para: TStringList);

    // getter-Fuinktionen (public)
    function gibParameter : TStringList;

    { Aufgabe: Zeichenen des Strings, der in dem Stringentwickler ist. Sollte der String eine bestimmte laenge
      ueberschritten haben, so wird dieser String nicht gezeichnet.
      Rueckgabe: Wenn der String gezeichet wurde, so wird wahr zurueckgegeben. Wenn der String nicht gezeichnet
      wurde, so wird falsch zurueckgegeben. }
    function zeichnen : Boolean;
    procedure speichern(datei: String);
    function copy : TTurtle; 
end;

VAR objekt: TObjekte;

implementation

uses uMatrizen,dglOpenGL;

constructor TTurtle.Create(gram: TGrammatik; 
                           zeichner: TZeichnerBase; 
                           maximaleStringLaenge: Int64 = 100000);
begin
  FGrammatik := gram;
  FZeichner := zeichner;
  FStringEntwickler := TStringEntwickler.Create(gram);
  FStringEntwickler.entwickeln(FZeichner.rekursionsTiefe);
  FMaximaleStringLaenge := 100000;
  FName := '';
  FVisible := true;
end;

constructor TTurtle.Create(gram: TGrammatik; 
                   zeichner: TZeichnerBase; 
                   stringEntwickler: TStringEntwickler;
                   maximaleStringLaenge:Int64 = 100000);
begin
  FGrammatik := gram;
  FZeichner := zeichner;
  FStringEntwickler := stringEntwickler;
  FMaximaleStringLaenge := 100000;
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
    FMaximaleStringLaenge := conf.getValue('Maximale Stringlaenge',0);

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
  FreeAndNil(FVisible);
  FreeAndNil(FMaximaleStringLaenge);
  FreeAndNil(FName);
  FreeAndNil(FGrammatik);
  FreeAndNil(FZeichner);
  FreeAndNil(FStringEntwickler);
  inherited;
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

procedure TTurtle.setzeZeichnerName(const neuerName: String);
var zeichnerInit: TZeichnerInit;
begin
  zeichnerInit := TZeichnerInit.Create;
  FZeichner := zeichnerInit.initialisiere(neuerName, FZeichner.gibZeichenParameter);
end;

procedure TTurtle.aendereParameter(para: TStringList);
begin
  FGrammatik.aendereParameter(para);
  FStringEntwickler.aendereParameter(para);
end;

procedure TTurtle.setzeVisible(const vis: Boolean);
begin
  FVisible := vis;
end;

procedure TTurtle.setzeName(const name: String);
begin
  FName := name;
end;

procedure TTurtle.setzeMaximaleStringLaenge(const mxStringLaenge: Int64);
begin
  FMaximaleStringLaenge := mxStringLaenge;
end;

// Parameter: Startpunkt der Turtle
procedure init(sx,sy,sz:Real);
begin
  glMatrixMode(GL_ModelView);
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

function TTurtle.gibZeichnerName : String;
begin
    result := FZeichner.name;
end;

function TTurtle.gibEntwickelterString : String;
begin
  result := FStringEntwickler.entwickelterString;
end;

function TTurtle.gibAxiom : String;
begin
  result := FGrammatik.axiom;
end;

function TTurtle.gibParameter : TStringList;
begin
  result := FGrammatik.gibParameter;
end;

// zeichner
function TTurtle.zeichnen : Boolean;
VAR i: Cardinal; paraList : TStringList; 
    zuZeichnenderBuchstabe: Char; tmp_string: String;
begin
  if length(FStringEntwickler.zuZeichnenderString) > FMaximaleStringLaenge then exit(false);
  init(FZeichner.startPunkt.x,FZeichner.startPunkt.y,FZeichner.startPunkt.z);
  paralist:=TStringList.Create;
  i := 1; 
  while (i <= length(FStringEntwickler.zuZeichnenderString)) do
  begin
    FreeAndNil(paraList); // damit es keine leaks gibt
    paraList := TStringList.Create;
    zuZeichnenderBuchstabe := FStringEntwickler.zuZeichnenderString[i];
    if (i <> length(FStringEntwickler.zuZeichnenderString) - 1) and 
    (FStringEntwickler.zuZeichnenderString[i+1] = '(') then
    begin
      inc(i); 
      while (true) do
      begin
        if (FStringEntwickler.zuZeichnenderString[i] = ';') then 
        begin
          paraList.add(tmp_string); 
          tmp_string := ''; inc(i); continue;
        end
        else if (FStringEntwickler.zuZeichnenderString[i] = ')') then 
        begin
          paraList.add(tmp_string); tmp_string := ''; break;
        end
        else if (FStringEntwickler.zuZeichnenderString[i] = '(') then 
        begin
          tmp_string := ''; inc(i); continue;
        end;
        tmp_string += FStringEntwickler.zuZeichnenderString[i]; 
        inc(i);
      end;
    end;
    FZeichner.zeichneBuchstabe(zuZeichnenderBuchstabe,paraList);
    inc(i);
  end;
  FreeAndNil(paraList);
  result := true;
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
    conf.setValue('Maximale Stringlaenge', FMaximaleStringLaenge);
    
    conf.setValue('Zeichen Art', UnicodeString(FZeichner.name));

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

function TTurtle.copy : TTurtle;
var turtle: TTurtle;
    gram: TGrammatik;
    zeichner: TZeichnerBase;
    entwickler:TStringEntwickler;
begin
  gram := FGrammatik.copy;
  zeichner := FZeichner.copy;
  entwickler := FStringEntwickler.copy;
  turtle := TTurtle.Create(gram,zeichner,entwickler);
  turtle.name := FName;
  turtle.visible := FVisible;
  turtle.maximaleStringLaenge := FMaximaleStringLaenge;
  result := turtle;
end;

end.

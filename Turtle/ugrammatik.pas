unit uGrammatik; 
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils,fgl, fpjson, jsonparser, jsonConf;

type TRegelProduktionsseite = class
    produktion: String;
    zufaelligkeit: Real;
    constructor Create;
    destructor Destroy; override;
end;

type TRegelProduktionsseitenListe = TFPGList<TRegelProduktionsseite>;

type TRegelDictionary = TFPGMap<String,TRegelProduktionsseitenListe>;

type TVariableZuWert = TFPGMap<String,String>;

type TGrammatik = class
  private
    { Aufgabe: Speichert das Axiom mit den Zahlenwerten als Einsetzung. }
    FRawAxiom: String;
    { Aufgabe: Speichert das Axiom mit Platzhaltervariablen. }
    FAxiom: String;

    // setter-Funktionen fuer properties
    procedure setzeAxiom(axiom:String);
  public
    { Aufgabe: Speichert den Wert einer Platzhaltervariable. }
    variableZuWert: TVariableZuWert;
    { Aufgaben: Speichert die Regel genau so, wie die eingegeben 
      wurde ohne diese weiter zu verarbeiten. }
    rawRegeln: TRegelDictionary;
    { Aufgabe: Speichert die Regeln, wobei diese durch alternative
      Variablen ersetzt wurden. Diese Varieblen machen Ersetzugen 
      einfacher. }
    regeln: TRegelDictionary;

    constructor Create;
    destructor Destroy; override;

    property axiom: String read FRawAxiom write setzeAxiom;
    property ersetztesAxiom: String read FAxiom;

    { -- Bezieht sich auf Funktionen in diesem Block --
      Aufgabe: Fuegt Regeln zur Grammatik hinzu. Einsetzung der 
      Platzhalter in "regeln".
    }
    procedure addRegel(links: String; rechts: String; zufaelligkeit: Real); overload;
    procedure addRegel(links: String; rechts: String); overload;
    function RegelTauschLinks(links: String) : String;
    function RegelTauschRechts(links: String; rechts: String) : String;

    procedure aendereParameter(para: TStringList);

    // getter-Funktion (public)
    function gibParameter : TStringList;

    { Aufgabe: Dies wird als statische Variable genutzt. Mit der 
      Funktion (im Gegensatz zur Variable) wird sichergestellt, 
      dass sie auch wirklich readonly ist.
      -> innerhalb, wie auch ausserhalb der Funktion 
      Die tokenLaenge ist die Laenge der ersetzten Variablennamen 
      in FAxiom. }
    class function tokenLaenge : Cardinal; static;

    function copy : TGrammatik;
end;

implementation

constructor TRegelProduktionsseite.Create;
begin
  produktion := '';
  zufaelligkeit := 100;
end;

destructor TRegelProduktionsseite.Destroy;
begin
  FreeAndNil(produktion);
  FreeAndNil(zufaelligkeit);
end;

constructor TGrammatik.Create;
begin
  FAxiom := '';
  FRawAxiom := '';
  regeln := TRegelDictionary.Create;
  rawRegeln := TRegelDictionary.Create;
end;

destructor TGrammatik.Destroy;
begin
  FreeAndNil(variableZuWert);
  FreeAndNil(FAxiom);
  FreeAndNil(FRawAxiom);
  FreeAndNil(regeln);
  FreeAndNil(rawRegeln);
end;

procedure TGrammatik.setzeAxiom(axiom:String);
var parameterCount: Cardinal;
    insertLetter,axiomOutput: String;
    letter: Char;
begin
  parameterCount := 1;
  FAxiom := '';
  FRawAxiom := axiom;
  axiomOutput:='';
  variableZuWert:=TVariableZuWert.Create;
  for letter in axiom do
  begin
    if (ord(letter) <= 47) or (ord(letter) > 57) then
    begin
      if (letter <> ';') and (letter <> ')') then
      begin
        FAxiom := FAxiom + letter;
      end
      else
      begin
        insertLetter:= IntToStr(parameterCount)+'ax';
        while length(insertLetter) < tokenLaenge do insertLetter:='0'+insertLetter;
        variableZuWert.add(insertLetter,axiomOutput);
        FAxiom := FAxiom + insertLetter+letter;
        axiomOutput:='';
        inc(parameterCount);
      end;
    end
    else axiomOutput := axiomOutput + letter;
  end;
end;

procedure TGrammatik.addRegel(links: String; rechts: String; zufaelligkeit: Real);
var tmp_links: String;
    procedure zuRegelHinzufuegen(var regelDict: TRegelDictionary);
    var tmp_regel: TRegelProduktionsseite;
        data: TRegelProduktionsseitenListe;
    begin
      tmp_regel := TRegelProduktionsseite.Create;
      tmp_regel.produktion := rechts;
      tmp_regel.zufaelligkeit := zufaelligkeit;
      if regelDict.TryGetData(links,data) then regelDict[links].add(tmp_regel)
      else
      begin
          regelDict[links] := TRegelProduktionsseitenListe.Create;
          regelDict[links].add(tmp_regel);
      end;
    end;
begin
  zuRegelHinzufuegen(rawRegeln);
  if (links[2] = '(') then
  begin
    tmp_links := links;
    links := RegelTauschLinks(links);
    rechts := RegelTauschRechts(tmp_links,rechts);
  end;
  zuRegelHinzufuegen(regeln);
end;

procedure TGrammatik.addRegel(links: String; rechts: String);
begin
    addRegel(links,rechts,100);
end;


function TGrammatik.RegelTauschLinks(links: string) : String;
var parameterCount,letterAsc:INTEGER;
    pter:CARDINAL;
    letter,smlLetter:string;
begin
  result := ''; 
  result += links[1]; result += links[2];
  pter:=3;
  letterAsc:=Ord(links[1]);
  letterAsc:=letterAsc+32;
  smlLetter:=Chr(letterAsc);
  for parameterCount:=1 to 27 do
  begin
    letter := IntToStr(parameterCount)+smlLetter;
    while length(letter) < tokenLaenge do letter:='0'+letter;
    result := result + letter;
    if links[pter+1]=';' then
    begin
      result := result + ';';
      pter:=pter+2;
    end
    else
    begin
      result := result + ')';
      break;
    end
  end;
end;

function TGrammatik.RegelTauschRechts(links: String; rechts: String) : String;
var parameterCount,letterAsc:INTEGER;
    pter:CARDINAL;
    toReplace,letter,smlLetter:string;
    { Grund: Wenn man genau den kleinen Buchstaben als Variable hat, so
      koennten bei der Ersetzung fehler auftreten, da der Platzhalter
      ebenfalls diesen Buchstaben enthalten. 
      Aufgabe: Ersetzung des kleinen Buchstaben mit aktuellem Platzhalter, 
      ohne "falsch" zu ersetzen. }
    function ersetzeSmlLetter : String;
    var i: Cardinal; tmp_string: String; letzterBuchstabe: Char;
    begin
      result := ''; letzterBuchstabe := ')';
      for i := 1 to length(rechts) do
      begin
        if ((letzterBuchstabe = '(') or (letzterBuchstabe = ';'))
        and (rechts[i] = smlLetter) then result += letter
        else result += rechts[i];
        letzterBuchstabe := rechts[i];
      end;
    end;
begin
  pter:=3;
  letterAsc:=Ord(links[1]);
  letterAsc:=letterAsc+32;
  smlLetter:=Chr(letterAsc);
  for parameterCount:=1 to 27 do
  begin
    letter := IntToStr(parameterCount) + smlLetter;
    while length(letter) < tokenLaenge do letter:='0'+letter;
    if links[pter] = smlLetter then rechts := ersetzeSmlLetter
    else rechts := StringReplace(rechts,links[pter],letter,[rfReplaceAll]);
    if links[pter+1]=';' then pter:=pter+2
    else break;
  end;
  result := rechts;
end;

procedure TGrammatik.aendereParameter(para: TStringList);
var paraCnt: Cardinal; varName: String;
begin
  FRawAxiom := FAxiom;
  if para.Count <> variableZuWert.Count then exit;
  for paraCnt := 1 to para.Count do
  begin
    varName := IntToStr(paraCnt)+'ax';
    while length(varName) < tokenLaenge do varName:='0'+varName;

    variableZuWert.AddOrSetData(varName,para[paraCnt - 1]);
    FRawAxiom := StringReplace(FRawAxiom,varName,para[paraCnt - 1],[rfReplaceAll]);
  end;
end;

function TGrammatik.gibParameter : TStringList;
var paraCnt: Cardinal; varName: String;
begin
  result := TStringList.Create;
  for paraCnt := 1 to variableZuWert.Count do
  begin
    varName := IntToStr(paraCnt)+'ax';
    while length(varName) < tokenLaenge do varName:='0'+varName;
    result.add(variableZuWert[varName]);
  end;
end;

class function TGrammatik.tokenLaenge : Cardinal;
begin
  result := 4;
end;

function TGrammatik.copy : TGrammatik;
var regelIdx, produktionIdx: Cardinal;
var gram: TGrammatik;
begin
  gram := TGrammatik.Create;
  gram.axiom := FRawAxiom;
  for regelIdx := 0 to rawRegeln.Count - 1 do
  begin
    for produktionIdx := 0 to (rawRegeln.data[regelIdx]).Count - 1 do
    begin
      gram.addRegel(
            rawRegeln.keys[regelIdx],
            rawRegeln.data[regelIdx][produktionIdx].produktion,
            rawRegeln.data[regelIdx][produktionIdx].zufaelligkeit
          );
    end;
  end;
  result := gram;
end;

end.


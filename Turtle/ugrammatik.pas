unit uGrammatik; 
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils,fgl, fpjson, jsonparser, jsonConf;

// zu einem record machen (wegen operator error nicht moeglich) !!!!!!
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
      FAxiom: String;
    public
        variableZuWert: TVariableZuWert;
        regeln: TRegelDictionary;

        constructor Create;
        destructor Destroy; override;

        procedure addRegel(links: String; rechts: String; zufaelligkeit: Real); overload;
        procedure addRegel(links: String; rechts: String); overload;

        function RegelTauschLinks(links: String) : String; overload;
        function RegelTauschRechts(links: String; rechts: String) : String; overload;

        procedure setzeAxiom(Axiom:String); overload;

        property axiom: String read FAxiom write setzeAxiom;

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
    regeln := TRegelDictionary.Create;
end;

destructor TGrammatik.Destroy;
begin
    FreeAndNil(FAxiom);
    FreeAndNil(regeln);
end;

procedure TGrammatik.setzeAxiom(axiom:String);
var parameterCount: Cardinal;
    insertLetter,axiomOutput: String;
    letter: Char;
begin
  parameterCount := 1;
  FAxiom := '';
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
        while length(insertLetter)<4 do insertLetter:='0'+insertLetter;
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
var tmp_regel: TRegelProduktionsseite;
    data: TRegelProduktionsseitenListe;
    tmp_links: String;
begin
    if links[2] = '(' then
    begin
        tmp_links := links;
        links := RegelTauschLinks(links);
        rechts := RegelTauschRechts(tmp_links,rechts);
    end;
    tmp_regel := TRegelProduktionsseite.Create;
    tmp_regel.produktion := rechts;
    tmp_regel.zufaelligkeit := zufaelligkeit;
    if regeln.TryGetData(links,data) then regeln[links].add(tmp_regel)
    else
    begin
        regeln[links] := TRegelProduktionsseitenListe.Create;
        regeln[links].add(tmp_regel);
    end;
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
        while length(letter)<4 do letter:='0'+letter;
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
begin
    pter:=3;
    letterAsc:=Ord(links[1]);
    letterAsc:=letterAsc+32;
    smlLetter:=Chr(letterAsc);
    for parameterCount:=1 to 27 do
    begin
        letter := IntToStr(parameterCount) + smlLetter;
        while length(letter)<4 do letter:='0'+letter;
        rechts := StringReplace(rechts,links[pter],letter,[rfReplaceAll]);
        if links[pter+1]=';' then pter:=pter+2
        else break;
    end;
    result := rechts;
end;

procedure TGrammatik.addRegel(links: String; rechts: String);
begin
        addRegel(links,rechts,100);
end;

function TGrammatik.copy : TGrammatik;
var regelIdx, produktionIdx: Cardinal;
var gram: TGrammatik;
begin
    gram := TGrammatik.Create;
    gram.axiom := FAxiom;
    for regelIdx := 0 to regeln.Count - 1 do
    begin
        for produktionIdx := 0 to (regeln.data[regelIdx]).Count - 1 do
        begin
            gram.addRegel(
                    regeln.keys[regelIdx],
                    regeln.data[regelIdx][produktionIdx].produktion,
                    regeln.data[regelIdx][produktionIdx].zufaelligkeit
                );
        end;
    end;
    result := gram;
end;

end.


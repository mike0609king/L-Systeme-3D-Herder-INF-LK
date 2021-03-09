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

type TGrammatik = class
    public
        axiom: String;
        regeln: TRegelDictionary;

        constructor Create;
        destructor Destroy; override;
        procedure addRegel(links: String; rechts: String; zufaelligkeit: Real); overload;
        procedure addRegel(links: String; rechts: String); overload;
        function RegelTauschLinks(links: String) : String; overload;
        function RegelTauschRechts(links: String; rechts: String) : String; overload;
        //function setzeAxiom() : String overload;
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
    axiom := '';
    regeln := TRegelDictionary.Create;
end;

// review !!!!!!!!!!!!!!!!!!!!!!!!!!
destructor TGrammatik.Destroy;
begin
    FreeAndNil(axiom);
    FreeAndNil(regeln);
end;

procedure TGrammatik.addRegel(links: String; rechts: String; zufaelligkeit: Real);
var tmp_regel: TRegelProduktionsseite;
    data: TRegelProduktionsseitenListe;
    tmp_links: String;
begin
    if links[2] = '(' then
    begin
        tmp_links := links;
        writeLn(links);
        writeLn(rechts);
        links := RegelTauschLinks(links);
        rechts := RegelTauschRechts(tmp_links,rechts);
        writeLn(links);
        writeLn(rechts);
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

function TGrammatik.setzeAxiom() : String;
var
begin

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
        while len(letter)<4 do letter:='0'+letter;
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
    gram.axiom := axiom;
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


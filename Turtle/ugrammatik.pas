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

type TRegelDictionary = TFPGMap<Char,TRegelProduktionsseitenListe>;

type TGrammatik = class
    public
        axiom: String;
        regeln: TRegelDictionary;

        constructor Create;
        destructor Destroy; override;
        procedure addRegel(rechts: char; links: String; zufaelligkeit: Real); overload;
        procedure addRegel(rechts: char; links: String); overload;
        procedure RegelTauschLinks(links: string); overload;
        procedure RegelTauschRechts(rechts:char); overload;
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

procedure TGrammatik.addRegel(rechts: char; links: String; zufaelligkeit: Real);
var tmp_regel: TRegelProduktionsseite;
    data: TRegelProduktionsseitenListe;
begin
    if links[2] = '(' then
    begin
        RegelTauschLinks(links);
        RegelTauschRechts(rechts);
        
    end;
    tmp_regel := TRegelProduktionsseite.Create;
    tmp_regel.produktion := links;
    tmp_regel.zufaelligkeit := zufaelligkeit;
    if regeln.TryGetData(rechts,data) then regeln[rechts].add(tmp_regel)
    else
    begin
        regeln[rechts] := TRegelProduktionsseitenListe.Create;
        regeln[rechts].add(tmp_regel);
    end;
end;

procedure TGrammatik.RegelTauschLinks(links: string);
var parameterCount,letterAsc:INTEGER;
    pter:CARDINAL;
    letter,smlLetter:string;
begin
    procedure stringtausch;
    begin
        letter:=IntToString(parameterCount)+smlLetter;
        links[pter]:=letter;
    end;

    letter:=''
    pter:=3;
    letterAsc:=Ord(links[1]);
    letterAsc:=letterAsc+32;
    smlLetter:=Chr(letterAsc);
    for parameterCount:=1 to 26 do
    begin
        stringtausch(parameterCount, letter);
        pter:=pter+2;
        if links[pter]=';' then pter:=pter+1
        else break;
    end;
end;

procedure TGrammatik.RegelTauschRechts(rechts:char);
var ind,letterAsc:INTEGER;
    pter:CARDINAL;
    letter,element:string;
    list:= array[1..27] of string;
begin
    pter:=4;
    letterAsc:=Ord(rechts[1]);
    letterAsc:=letterAsc+32;
    letter:=Chr(letterAsc);
    list[1]:=rechts[3];
    for ind:=2 to 27 do
    begin
        if rechts[pter]=';' then list[ind]:=rechts[pter+1];
        else break;
        pter:=pter+2;
    end;

    for element in list do 
    begin
        while pos(element,list)>0 do rechts[pos(element,list)]=IntToString(index(element))+letter;
    end;
end;

procedure TGrammatik.addRegel(rechts: char; links: String);
begin
    addRegel(rechts,links,100);
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


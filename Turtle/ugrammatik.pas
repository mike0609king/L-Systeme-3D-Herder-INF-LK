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
        procedure RegelTausch(links: string; rechts:char); overload;
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
        RegelTausch(links,rechts)
        
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

procedure TGrammatik.RegelTausch(links: string; rechts:char);
var letterAsc:INTEGER;
    letter:string;
begin
    procedure stringtausch(parameterCount);
    begin
        letter:=IntToString(parameterCount)+Chr(letterAsc);
        links[pter]:=letter;
    end;

    procedure tauschLinks;
    var parameterCount:INTEGER;
        pter:CARDINAL;
    begin
        pter:=3;
        letterAsc:=Ord(links[1]);
        letterAsc:=letterAsc+32;
    for parameterCount:=1 to 26 do
    begin
        stringtausch(parameterCount);
        pter:=pter+2;
        if links[pter]=';' then pter:=pter+1
        else break;
    end;

    procedure tauschRechts;
    var parameterCount:INTEGER;
        pter:CARDINAL;
    begin

    end;

    tauschLinks;
    tauschRechts;
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


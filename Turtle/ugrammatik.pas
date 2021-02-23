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

destructor TGrammatik.Destroy;
begin
    FreeAndNil(axiom);
    FreeAndNil(regeln);
end;

procedure TGrammatik.addRegel(links: String; rechts: String; zufaelligkeit: Real);
var tmp_regel: TRegelProduktionsseite;
    data: TRegelProduktionsseitenListe;
begin
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


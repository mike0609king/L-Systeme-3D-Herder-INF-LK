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

procedure TGrammatik.addRegel(rechts: char; links: String);
begin
    addRegel(rechts,links,100);
end;

end.


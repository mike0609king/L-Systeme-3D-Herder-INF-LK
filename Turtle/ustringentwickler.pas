unit uStringEntwickler;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl, uGrammatik;

type TStringEntwickler = class
    private
        FGrammatik: TGrammatik;
        FEntwickelterString: String;

        // Dieser Wert MUSS ein vielfaches von 10 sein.
        // Dieser Wert geteilt durch 100 bestimme die Anzahl der Nachkommastellen, die
        // beim zufaelligen bestimmen des Strings beruecksichtigt werden
        maximalerZufallsraum: Cardinal; 

        { Rueckgabe: Gibt zurueck, ob dieser Buchstabe ueberhaupt existiert und dem nach ersetzt
          werden kann. Wenn false zurueckgegeben wurde, so kann dieser string ueberhaupt nicht
          ersetze werden. Demnach steht auch kein sinvoller wert in der Variable ret.}
        function gibEinzusetzendenString(c: char; var ret: String) : Boolean;

        { Aufgabe: Die Zufaelligkeitsraeume werden als Cardinal gespeichert. Hierbei wird
          der Fliesskommawert ab dem log_10(maximalerZufallsraum)-2 ten Wert verworfen. Wir nehmen 
          also nicht mehr bei der Zufaelligkeit ruecksicht darauf. }
        function convertiereRealZuCardinal(wert: Real) : Cardinal;
    public
        property axiom: String read FGrammatik.axiom;
        property regeln: TRegelDictionary read FGrammatik.regeln;
        property entwickelterString: String read FEntwickelterString;

        constructor Create(gram: TGrammatik);
        //destructor Destroy; override;

        { Aufgabe: Entwickelt den String gemaess der gegebenen Grammatik bis zur
          rekursions Tiefe, die angegeben wurde.}
        procedure entwickeln(rekursionsTiefe: Cardinal);
end;

implementation

constructor TStringEntwickler.Create(gram: TGrammatik);
begin
    randomize;
    FGrammatik := gram;
    FEntwickelterString := '';
    // es werden vier stellen nach dem Komma beruecksichtigt
    maximalerZufallsraum := 100 * 10000; 
end;

function TStringEntwickler.convertiereRealZuCardinal(wert: Real) : Cardinal;
begin
    result := trunc(wert * (maximalerZufallsraum div 100));
end;

function TStringEntwickler.gibEinzusetzendenString(c: char; var ret: String) : Boolean;
var data: TRegelProduktionsseitenListe;
    prefix: TFPGList<Cardinal>;
    i: Cardinal;
    zufaelligerWert: Cardinal;
    function upper_bound(gesucht: Cardinal) : Cardinal;
    var a, b, m: Cardinal;
    begin
        a := 0; b := prefix.Count-1;
        while a <= b do
        begin
            m := (a+b) div 2;
            if prefix[m] = gesucht then exit(m);
            if prefix[m] < gesucht then a := m+1
            else b := m-1;
        end;
        // wir koennen uns sicher sein, dass der Index von b gueltig ist, 
        // da wir nur Werte suchen werden, die nicht groesser, als der groesste
        // Wert ist
        result := b;
    end;
begin
    if FGrammatik.regeln.TryGetData(c,data) then
    begin
        prefix := TFPGList<Cardinal>.Create;
        prefix.add(0);
        for i := 1 to data.Count do
        begin
            prefix.add(prefix[i-1]+convertiereRealZuCardinal(data[i-1].zufaelligkeit));
        end;
        zufaelligerWert := random(maximalerZufallsraum);
        ret := data[upper_bound(zufaelligerWert)].produktion;
        exit(true);
    end;
    result := false;
end;

procedure TStringEntwickler.entwickeln(rekursionsTiefe: Cardinal);
    procedure entw(tiefe: Cardinal; s: String);
    var i: Cardinal;
        data: String;
    begin
        for i := 1 to length(s) do
        begin
            if (tiefe <> 0) and (gibEinzusetzendenString(s[i],data)) then
            begin
                entw(tiefe-1, data);
            end
            else
            begin
                FEntwickelterString += s[i];
            end;
        end;
    end;
begin
    FEntwickelterString := '';
    entw(rekursionsTiefe,FGrammatik.axiom);
end;

end.


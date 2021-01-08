unit uStringEntwickler;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, uGrammatik;

type TStringEntwickler = class
    private
        FGrammatik: TGrammatik;
        FEntwickelterString: String;
    public
        property axiom: String read FGrammatik.axiom;
        property regeln: TRegelDictionary read FGrammatik.regeln;
        property entwickelterString: String read FEntwickelterString;

        constructor Create(gram: TGrammatik);

        procedure entwickeln(rekursionsTiefe: Cardinal);
end;

implementation

constructor TStringEntwickler.Create(gram: TGrammatik);
begin
    FGrammatik := gram;
    FEntwickelterString := '';
end;

// spaeter mit dp optimieren
procedure TStringEntwickler.entwickeln(rekursionsTiefe: Cardinal);
    procedure entw(tiefe: Cardinal; s: String);
    var i: Cardinal;
        data: String;
    begin
        for i := 1 to length(s) do
        begin
            if (tiefe <> 0) and (FGrammatik.regeln.TryGetData(s[i],data)) then
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


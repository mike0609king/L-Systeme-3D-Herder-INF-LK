unit uGrammatik;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils,fgl;

{type TRegelProduktionsseite = record
end;}

type TRegelDictionary = TFPGMap<Char,String>;

type TGrammatik = record
    axiom: String;
    regeln: TRegelDictionary;
    // regeln: String; //testing
end;      

implementation

end.


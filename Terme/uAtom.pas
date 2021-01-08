unit uAtom;

interface

TYPE TAtom = class
        Constructor create                              ;virtual;abstract;
        Procedure   lesen (str:ShortString;VAR akt:Byte);virtual;abstract;
        FUNCTION    gelesen (str:ShortString; akt:Byte):BOOLEAN ;virtual;abstract;
        Function    kopieren : TAtom                    ;virtual;abstract;
        Procedure   leeren                              ;virtual;abstract;
        Procedure   setzen (w:TObject)                  ;virtual;abstract;
        Function    istUnwert : BOOLEAN                 ;virtual;abstract;
        Function    Unwert    : TAtom                   ;virtual;abstract;
     end;
     TAssoziativitaet=(links,rechts);
     TOperationen = class
        operation : TObject;
        Constructor create                              ;virtual;abstract;
        Function    lesen (str:ShortString;VAR akt:Byte):
                                        TAssoziativitaet;virtual;abstract;
        Function    gelesen (str:ShortString; akt:Byte; stufe:Byte):BOOLEAN
                                                   ;overload  ;virtual;abstract;
        Function    gelesen (str:ShortString; akt:Byte;
                             stufe:Byte; a :TAssoziativitaet):BOOLEAN;
                                                 overload    ;virtual;abstract;
        Function    kopieren : TOperationen             ;virtual;abstract;
        Procedure   leeren                              ;virtual;abstract;
        Function    stufe : Byte                        ;virtual;abstract;
        Function    Assoziativitaet: TAssoziativitaet   ;virtual;abstract;
        Function    ausfuehren (w1,w2:TAtom):TAtom      ;virtual;abstract;
        FUNCTION    MaxStufe :BYTE                      ;virtual;abstract;
     END;
     TFunktionen = class
        funktion : TObject;
        Constructor create                            ;virtual;abstract;
        Procedure lesen (str:ShortString;Var akt:Byte);virtual;abstract;
        Function gelesen (str:ShortString;akt:Byte):BOOLEAN;virtual;abstract;
        Function kopieren : TFunktionen               ;virtual;abstract;
        Procedure leeren                              ;virtual;abstract;
        Function ausfuehren (w : TAtom):TAtom         ;virtual;abstract;
     end;

(* ********************************************************************** *)     
implementation

end.

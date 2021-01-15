unit uVariable;

interface
uses uAtom;

TYPE TVariable = class
        variable : TObject;
        constructor create (a:TAtom);
        procedure   leeren;
        Function    wert : TAtom;
        Function    kopieren : TVariable;
        Procedure   setzen ( w:TAtom);
     end;
implementation
TYPE TVar = class
         ka     : TAtom;
     END;

constructor TVariable.create (a:TAtom);
begin
   variable := TVar.Create ;
   TVar (variable).ka:=a.create;
END;

procedure   TVariable.leeren;
begin
   TVar (variable).ka.leeren;
END;

Function    TVariable.wert : TAtom;
VAR a : TAtom;
begin
//   a := TVar (variable).ka.kopieren;
   a := TVar (variable).ka.kopieren;
   result := a
END;

Function    Tvariable.kopieren : TVariable;
VAR a:TAtom; v:TVariable;
BEGIN
   v:=TVariable.create(TVar (variable).ka);
   TVar (v.variable).ka := TVar (variable).ka.kopieren;
   result := v
END;

Procedure   TVariable.setzen ( w:TAtom);
begin
   TVar (variable).ka := w.kopieren
END;

end.

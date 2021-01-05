unit uTerme;

interface
uses uAtom, uVariablen;

TYPE TTerme = class
        private
          term : TObject;
        public
          constructor create(a:TAtom;o:TOperationen;f:TFunktionen);
          Procedure VariablenZuordnen (vf:TVariablen);
          Function parsen (str:ShortString):Byte;
          Procedure leeren;
          Function ermitteln: TAtom;
          Function baum : ShortString;
     end;

implementation
uses uVariable;

Type Knotentyp = (variablenK,wertK,operationsK,funktionsK);
     TTermBaum = ^Knoten;
     Knoten = record
              Case typ:Knotentyp OF
                  variablenK : (variable:TVariable);
                  wertK      : (wert    :TAtom);
                  operationsK: (links,rechts:TTermBaum;
                                operation:TOperationen);
                  funktionsK : (argument:TTermbaum;
                                fkt:TFunktionen);
              END;
     Tterm = class
        str   : ShortString;
        fehler: Byte;
        vf    : TVariablen;
        baum  : TTermBaum;
        ka    : TAtom;
        ko    : TOperationen;
        kf    : TFunktionen;

     end;

CONSTRUCTOR TTerme.create (a:TAtom;o:TOperationen;f:TFunktionen) ;
BEGIN
   TTerm (term) := TTerm.Create;
   TTerm (term).str:='';
   TTerm (term).fehler:=0;
   TTerm (term).vf:=NIL;
   TTerm (term).baum:=NIL;
   TTerm (term).ka :=a.kopieren ;
   TTerm (term).ko :=o.kopieren ;
   TTerm (term).kf :=f.kopieren ;
END;

Procedure TTerme.VariablenZuordnen (vf:TVariablen);
BEGIN
   TTerm (term).vf :=vf
END;

PROCEDURE BaumLeeren (VAR b:TTermBaum);
BEGIN
   IF b<>NIL THEN
   BEGIN
      CASE b^.typ OF
          wertK: BEGIN
                  b^.wert.leeren;
                  b^.wert.Destroy;
                 END;
          operationsK: BEGIN
                         baumLeeren (b^.links);
                         baumLeeren (b^.rechts);
                         b^.operation.leeren;
                         b^.operation.Destroy;
                       END;
          funktionsK : BEGIN
                         baumLeeren (b^.argument);
                         b^.fkt.leeren;
                         b^.fkt.destroy;
                       END;
      END;
      DISPOSE (b);
      b:=NIL;
   END;
END;

PROCEDURE TTerme.leeren;
BEGIN
   BaumLeeren (TTerm(term).baum);
   TTerm (term).str:='';
   TTerm (term).fehler:=0;
END;


FUNCTION TTerme.ermitteln : TAtom;
  FUNCTION BaumWert (b:TTermBaum):TAtom;
  VAR a1,a2:TAtom;
  BEGIN
   a1 := TTerm (term).ka.kopieren; a2 := TTerm (term).ka.kopieren;
   IF b<>NIL THEN
   BEGIN
      CASE b^.typ OF
          wertK      : a1 :=b^.wert.kopieren;
          operationsK: BEGIN
                         a1 := BaumWert (b^.links);
                         a2 := BaumWert (b^.rechts);
                         a1 :=b^.operation.ausfuehren (a1,a2);
                       END;
          funktionsK : BEGIN
                         a1 := BaumWert (b^.argument).kopieren;
                         a1 := b^.fkt.ausfuehren(a1).kopieren;
                       END;
          variablenK : a1 :=b^.variable.wert;
      END;
      result := a1;
   END;
  END;
BEGIN
   IF TTerm (term).fehler >0 THEN TTerm (term).ka := TTerm (term).ka.Unwert ELSE
   TTerm(term).ka      := baumwert (TTerm(term).baum);
   result  := TTerm (term).ka;
END;


FUNCTION TTerme.parsen(str:ShortString):Byte;
  FUNCTION BaumBau (str:ShortString;vf:TVariablen;VAR b:TTermBaum): BYTE;
  VAR akt :BYTE;
    fehler:BYTE;
        FUNCTION amEnde :BOOLEAN;
        BEGIN
           result:= (akt>length (str)) OR (fehler>0)
        END;
        FUNCTION OBauen (op:TOperationen;lb,rb:TTermBaum):TTermBaum;
        VAR b:TTermBaum;
        BEGIN
           NEW (b);
           b^.typ    :=OperationsK;
           b^.links  :=lb;
           b^.rechts :=rb;
           b^.operation:=op.kopieren;
           result := b
        END;
        FUNCTION WBauen (wert:TAtom) : TTermBaum;
        VAR b:TTermBaum;
        BEGIN
           NEW (b);
           b^.typ    := WertK;
           b^.wert   := TTerm(term).ka.kopieren;
           b^.wert   := wert.kopieren;
           result := b
        END;
        FUNCTION VBauen (variable:TVariable):TTermBaum;
        VAR b:TTermBaum;
        BEGIN
           NEW (b);
           b^.typ     := VariablenK;
           b^.variable:= variable;
           result := b;
        END;
        FUNCTION FBauen (fkt:TFunktionen; arg:TTermbaum):TTermBaum;
        VAR b:TTermBaum;
        BEGIN
           NEW (b);
           b^.typ := FunktionsK;
           b^.fkt := TTerm (term).kf.kopieren;
           b^.fkt := fkt.kopieren;
           b^.argument := arg;
           result := b
        end;
    FUNCTION term (i:Byte): TTermBaum;
       FUNCTION funktion :TTermBaum;
          FUNCTION argument :TTermBaum;
          VAR v:TVariable; w:TAtom; b:TTermBaum;
          BEGIN
             b:=NIL;
             IF NOT amEnde THEN
             BEGIN
                IF str[akt]='(' THEN
                BEGIN
                   INC (akt);
                   IF NOT amEnde THEN b:=term(1)
                   ELSE BEGIN b:=NIL;fehler:=akt END;
                   IF (NOT amEnde) AND (str[akt]=')') THEN
                       INC(akt)
                   ELSE
                   BEGIN
                      fehler:=akt;
                      baumleeren (b);
                   END;
                   result:=b;
                END
                ELSE
                   IF vf.gelesen (str,akt) THEN
                   BEGIN
                      v:=TVariable.create(TTerm (self.term).ka.kopieren);
                      v:=vf.lesen(str,akt);
                      result:=VBauen(v);
                   END
                   ELSE
                   BEGIN
                      w:=TTerm (self.term).ka.kopieren;
                      IF w.gelesen(str,akt) THEN
                      BEGIN
                         w.lesen(str,akt);
                         result:=WBauen(w);
                         w.leeren;
                         w.Destroy ;
                      END
                      ELSE
                      Begin
                         w.Destroy;
                         fehler:=akt;
                         result :=NIL;
                      END;
                   END;
             END;
          END;
       VAR fkt:TFunktionen;
       BEGIN
          IF NOT amEnde THEN
          BEGIN
             fkt:=TTerm (self.term).kf.kopieren;
             IF fkt.gelesen(str,akt) THEN
             BEGIN
                fkt.lesen(str,akt);
                IF NOT amEnde THEN result:=FBauen (fkt,funktion)
                ELSE
                BEGIN
                   fehler:=akt;
                   result:=NIL
                END;
             END
             ELSE result:=argument;
             fkt.leeren;
             fkt.Destroy;
          END;
       END;
    VAR b:TTermBaum; op:TOperationen;
    BEGIN
       op:=TTerm (self.term).ko.kopieren;
       IF NOT amEnde THEN
       BEGIN
          IF i>op.MaxStufe THEN result := funktion
          ELSE
          BEGIN
             b:= term (i+1);
             WHILE NOT amEnde AND op.gelesen(str,akt,i,links) DO
             BEGIN
                op.lesen(str,akt);
                IF NOT amEnde THEN b:=OBauen (op,b,term(i+1))
                ELSE fehler:=akt;
             END;
             IF NOT amEnde AND op.gelesen(str,akt,i,rechts) THEN
             BEGIN
                op.lesen(str,akt);
                IF NOT amEnde THEN b:=OBauen (op,b,term(i))
                ELSE fehler:=akt;
             END;
             result:=b;
          END;
       END;
       op.leeren;
       op.destroy
    END;
  BEGIN
     BaumLeeren (b);
     fehler := 0;
     akt    := 1;
     b:= term(1);
     IF (fehler>0) OR (NOT amEnde) THEN
     BEGIN
        BaumLeeren (b);
        fehler := akt;
     END;
     result:=fehler;
  END;
BEGIN
   TTerm (term).str:=str;
   TTerm (term).baum:=NIL;
   TTerm (term).fehler:=BaumBau (str,TTerm (term).vf,TTerm (term).baum);
   IF TTerm (term).fehler>0 THEN BaumLeeren (TTerm (term).baum);
   result := TTerm (term).fehler;
END;

   FUNCTION baumausgeben (b:TTermBaum):ShortString;
   BEGIN
      IF b=NIL THEN BEGIN result:='NIL';EXIT END;
      IF b^.typ = VariablenK THEN result := 'v';
      IF b^.typ = wertK THEN result := 'w';
      IF b^.typ = funktionsK THEN result := 'f '+baumausgeben (b^.argument);
      IF b^.typ = operationsK THEN
          result :=baumausgeben (b^.links)+' o '+baumausgeben(b^.rechts);
   END;

FUNCTION TTerme.baum : ShortString;
BEGIN
   result := baumausgeben (TTerm (term).baum);
END;


end.

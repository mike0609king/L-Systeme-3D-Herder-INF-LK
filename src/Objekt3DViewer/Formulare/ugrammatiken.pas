unit UGrammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,uturtlemanager,
  ExtCtrls, CheckLst, uAnimation,ugrammatik, uTurtle,fpjson,LCLType,jsonparser, jsonConf, uStack, fgl;

type TMapStringToReal = TFPGMap<String,Real>;
type

  { TuGrammatiken }

  TuGrammatiken = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckListBox1: TCheckListBox;
    Edit1: TEdit;
    Anzahl: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure AnzahlClick(Sender: TObject);
    { Aufgabe:
      - Axiom pruefen:
        - Syntax: <Grossbuchstabe>(a;...)
          -> Getrennt mit jeweil Semikolons
        - Ein Axiom kann nur ein Grossbuchstabe sein!
        - Wohlgeformte Klammern '()' (diese duerfen nicht verschachtelt sein) und '[]'
        - Parameter muessen Zahlen sein
        - Parameter muessen mit einem ';' getrennt werden
      - Regeln pruefen:
        - Parameter muessen Kleinbuchstaben sein!
        - Ein Axiom kann nur ein Grossbuchstabe sein!
        - Wohlgeformte Klammern '()' (diese duerfen nicht verschachtelt sein) und '[]'
        - Parameter muessen mit einem ';' getrennt werden
        - Ein Grossbuchstabe muss die Zufaelligkeit von insgesamt 100% besitzen
      - Hinzufuegen der Regeln (-> Annahme: Vorliegenden Regeln wurden bereits geprueft und sind richtig):
        - Regeln werden eingelesen
        - Turtle wird zum Manager hinzugefuegt
      -> Funktionen werden nur auf Hilfsmethoden ausgelagert, weil diese nirgendwo anders benoetigt werden
    } 
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckGroup1ItemClick(Sender: TObject; Index: integer);
    procedure CheckListBox1ItemClick(Sender: TObject; Index: integer);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure Edit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private
    turtlemanager:TTurtlemanager;
    function gib_markierte_nr():CARDINAL;
    { Aufgabe:
      - Es muss gelten:
        1. Syntax: <Grossbuchstabe>(<zahl1>;...)
          -> Getrennt mit jeweils Semikolons
        2. Keine Kleinbuchstaben duerfen im Axiom sein, diese werden naemlich weder als Regel noch Befehle Akzeptiert
          -> dies sind die Variablennamen
        - Andere Vordefinierten Symbole werden nicht ueberprueft
        3. Wohlgeformte Klammern '()' (diese duerfen nicht verschachtelt sein)
        4. Wohlgeformte eckige Klammern '[]'
        5. Parameter muessen Zahlen sein
        6. Parameter muessen mit einem ';' getrennt werden
          -> Semikolons koennen nur in runden Klammern stehen
        7. Zahlen duerfen nicht ausserhalb von den runden Klammern stehen
      Rueckgabewert: Wenn das Axiom richtig ist, so wird True zurueckgegeben und false 
      andernfalls.
    }
    function pruefeAxiom(axiom: String) : Boolean;
    { 
    - Regeln pruefen:
      - Syntax: <Grossbuchstabe>[(<Kleinbuchstabe1>[,<Kleinbuchstabe2>,...])]-><Regel>;<Zufaelligkeit>
      - Parameter muessen Kleinbuchstaben sein!
      - Ein Axiom kann nur ein Grossbuchstabe sein!
        -> dannach koennen die Parameter in '(...)' angegeben werden, wenn es welche gibt
          -> diese duerften nicht verschachtelt sein
      - Wohlgeformte Klammern '[]'
      - Parameter muessen mit einem ';' getrennt werden
      - Ein Grossbuchstabe muss die Zufaelligkeit von insgesamt 100% besitzen
    }
    function pruefeRegel : Boolean;
    { Aufgabe: Hilfsfunktion von pruefeAxiom und pruefeRegel, da der Syntax des 
      Axioms und der linken Seite mit ausnahme des Inhaltes in der Klammer identisch ist.
      Parameter: 
        1: Der String, welcher zu analysieren ist. Dies ist entweder das Axiom oder
        die linke Seite der Regel (ohne Zufaelligkeit)
        2: Zeile der Regel, falls es eine ist
        3: Wenn die AnfangsPosition 0 ist, so ist der zuPruefende String ein Axiom.
        Andernfalls ist es eine Regel
    }
    function pruefeErsetzungsSyntax(zuPruefen: String; regelZeile: Cardinal; anfangsPosition: Cardinal) : Boolean;
  public

  end;

var
  aGrammatiken: TuGrammatiken;

implementation
uses uForm,uZeichnerBase,uZeichnerInit;
{$R *.lfm}

{ Hilfsfunktion }
function isDigit(c: Char) : Boolean;
begin
  // umwandlung in ascii-nummer sollte nicht noetig sein
  result := (c in ['0'..'9']);
end;

function isUpper(c: Char) : Boolean;
begin
  // umwandlung in ascii-nummer sollte nicht noetig sein
  result := (c in ['A'..'Z'])
end;

function isLower(c: Char) : Boolean;
begin
  // umwandlung in ascii-nummer sollte nicht noetig sein
  result := (c in ['a'..'z'])
end;

{ true - funktioniert}
function versucheStringToReal(s: String) : Boolean;
var c: Char;
    dot: Boolean;
begin
  dot := false;
  for c in s do
  begin
    if c = '.' then
    begin
      if dot then exit(false)
      else dot := true;
    end
    else if not isDigit(c) then exit(false);
  end;
  result := true;
end;

{ TuGrammatiken }

procedure TuGrammatiken.AnzahlClick(Sender: TObject);
begin

end;
function TuGrammatiken.gib_markierte_nr():CARDINAL;
VAR i:CARDINAL;
begin
   for i:=0 to CheckListBox1.Count -1 do
   begin
        if CheckListBox1.Checked[i] then result:=i;
   end;
end;


{ Eingabe: Der Pointer/Index (des Axiom-Strings) auf der Klammer (also axiom[idx] = '(' -> true)) 
  wird als Uebergeben.
  Aufgabe: Prueft die Eingabe in der Klammer.
  Rueckgabewert: Wenn die Eingabe in der Klammer Korrekt ist, so wird der Index des
  Axiom-Strings direkt auf der letzten Klammer zurueckgegeben. Andernfalls, wird die 
  position nicht mehr als wichtig erachtet und es wird der Token 0 also Rueckgabe zurueckgegeben. }
function pruefInKlammernAxiom(zuPruefen: String ;idx: Cardinal) : Cardinal;
begin
  // ueberspringen vom Klammer auf
  inc(idx);
  // der letzte Buchstabe wird weggelassen, da dieser ein ')' sein muss,
  // wenn alles richtig ist 
  while idx < length(zuPruefen) do 
  begin
    if zuPruefen[idx] = '(' then
    begin
      showMessage('Zeile 1 | Position' + IntToStr(idx) + ': Klammern duerfen nicht verschachtelt werden!');
      exit(0);
    end
    else if zuPruefen[idx] = ')' then break
    // Regel 6
    else if zuPruefen[idx] = ';' then
    begin
      if ((not isDigit(zuPruefen[idx-1])) or (not isDigit(zuPruefen[idx+1]))) then
      begin
        showMessage('Zeile 1 | Position' + IntToStr(idx) + ': Das Semikolon innerhalb einer Klammer ist nicht richtig plaziert worden!');
        exit(0);
      end;
    end
    else if not isDigit(zuPruefen[idx]) then
    begin
      showMessage('Zeile 1 | Position' + IntToStr(idx) + ': "' + zuPruefen[idx] + '" gefunden, aber eine Zahl erwartet!');
      exit(0);
    end;
    inc(idx);
  end;
  if zuPruefen[idx] = ')' then exit(idx);
  showMessage('Zeile 1 | Position ' + IntToStr(idx) + ': Runde Klammer gesucht, aber "' + zuPruefen[idx] + '" gefunden.');
  result := 0;
end;

{ Eingabe: Der Pointer/Index (des Axiom-Strings) auf der Klammer (also axiom[idx] = '(' -> true)) 
  wird als Uebergeben.
  Aufgabe: Prueft die Eingabe in der Klammer.
  Rueckgabewert: Wenn die Eingabe in der Klammer Korrekt ist, so wird der Index des
  Axiom-Strings direkt auf der letzten Klammer zurueckgegeben. Andernfalls, wird die 
  position nicht mehr als wichtig erachtet und es wird der Token 0 also Rueckgabe zurueckgegeben. }
function pruefInKlammernRegel(zuPruefen: String; regelZeile: Cardinal; idx: Cardinal) : Cardinal;
begin
  // ueberspringen vom Klammer auf
  inc(idx);
  // der letzte Buchstabe wird weggelassen, da dieser ein ')' sein muss,
  // wenn alles richtig ist 
  while idx < length(zuPruefen) do 
  begin
    if zuPruefen[idx] = '(' then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position ' + IntToStr(idx) + ': Klammern duerfen nicht verschachtelt werden!');
      exit(0);
    end
    else if zuPruefen[idx] = ')' then break
    else if zuPruefen[idx] = ';' then
    begin
      if ((not isLower(zuPruefen[idx-1])) or (not isLower(zuPruefen[idx+1]))) then
      begin
        showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position ' + IntToStr(idx) + ': Das Semikolon innerhalb einer Klammer ist nicht richtig plaziert worden!');
        exit(0);
      end;
    end
    else if not isLower(zuPruefen[idx]) then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position ' + IntToStr(idx) + ': "' + zuPruefen[idx] + '" gefunden, aber einen kleinen Buchstaben erwartet!');
      exit(0);
    end
    else if (isLower(zuPruefen[idx])) and (
        (not (
            // Trennzeichen von Links
            (zuPruefen[idx-1] = '(') or (zuPruefen[idx-1] = ';')
            ))
        or 
        (not (
            // Trennzeichen von Rechts
            (zuPruefen[idx+1] = ')') or (zuPruefen[idx+1] = ';')
          ))
      ) then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + '| Position' + IntToStr(idx) + ': Variablen muessen die Laenge 1 haben und von Semikolons getrennt werden.');
      exit(0);
    end;
    inc(idx);
  end;
  if zuPruefen[idx] = ')' then exit(idx);
  showMessage('Zeile ' + intToStr(regelZeile+1) + '| Position' + IntToStr(idx) + 'Es wurde eine Klammer erwartet, jedoch keine gefunden.');
  result := 0;
end;

function TuGrammatiken.pruefeErsetzungsSyntax(zuPruefen: String; regelZeile: Cardinal; anfangsPosition: Cardinal) : Boolean;
var stack: TStack;
    idx: Cardinal;
    isAxiom: Boolean;
begin
  if anfangsPosition = 0 then isAxiom := true
  else isAxiom := false;
  stack := TStack.Create;
  idx := 1;

  if length(zuPruefen) = 0 then
  begin
    if isAxiom then showMessage('Das Axiom darf nicht leer sein!')
    else showMessage('Zeile ' + intToStr(regelZeile+1) + ': Regel ist leer.');
    exit(false);
  end;
  while idx <= length(zuPruefen) do
  begin
    if zuPruefen[idx] = '[' then stack.push('[')
    else if zuPruefen[idx] = ']' then 
    begin
      if (stack.empty) or (stack.pop <> '[') then
      begin
        showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position '+ intToStr(idx+anfangsPosition) + ': Kann die zugehoerige eckige Klammer nicht finden.');
        exit(false);
      end;
    end
    else if isUpper(zuPruefen[idx]) then 
    begin
      // Es duerfen nur runde Klammern nach dem grossen Buchstaben folgen
      if (idx+1 <= length(zuPruefen)) and (zuPruefen[idx+1] = '(') then
      begin
        inc(idx);
        if isAxiom then idx := pruefInKlammernAxiom(zuPruefen,idx)
        else idx := pruefInKlammernRegel(zuPruefen,regelZeile,idx);
        if idx = 0 then exit(false);
      end
    end
    else if (zuPruefen[idx] = '(') or (zuPruefen[idx] = ')') then 
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position '+ intToStr(idx+anfangsPosition) + ': Einige runden Klammern sind fehl am Platz. Die sollten nur hinter den Grossbuchstaben als Parameter stehen.');
      exit(false);
    end
    else if isLower(zuPruefen[idx]) then 
    begin 
      showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position '+ intToStr(idx+anfangsPosition) + ': Es sind keine Kleinbuchstaben ausserhalb von runden Klammern erlaubt. Diese sind fuer Variabelnamen in der Regel reserviert!');
      exit(false);
    end
    else if isDigit(zuPruefen[idx]) then 
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position '+ intToStr(idx+anfangsPosition) + ': Zahlen sind ausserhalb runder Klammern nicht erlaubt!');
      exit(false);
    end;
    inc(idx)
  end;
  if not stack.empty then
  begin
    showMessage('Schliesse Klammern, die geoeffnet wurden!');
    exit(false)
  end;
  result := true;
end;

function TuGrammatiken.pruefeAxiom(axiom: String) : Boolean;
begin
  result := pruefeErsetzungsSyntax(axiom,0,0);
end;

function TuGrammatiken.pruefeRegel : Boolean;
var map: TMapStringToReal;
    regelZeile,dataIdx: Cardinal;
    tmp_rechts,tmp_links: String;
    tmp_zufaelligkeit,data: Real;
  function aux_pruefeRegel() : Boolean;
  var curRegelIdx,kommaPos,kommaCnt,kommaIdx: Cardinal;
  function istIdxInGrenzen(idx :Cardinal) : Boolean;
  begin
    result := (length(Memo1.lines[regelZeile]) >= idx);
  end;
  begin
    // puefen der linken Seite
    curRegelIdx := 2;
    // Die kleinst moegliche Zeichenkette: 'F->X'
    if length(Memo1.lines[regelZeile]) < 4 then 
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ': Das Format ist falsch!');
      exit(false);
    end
    else if not isUpper(Memo1.lines[regelZeile][1]) then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ': Die Regel muss immer mit einem Grossbuchstaben beginnen.');
      exit(false);
    end;
    if Memo1.lines[regelZeile][curRegelIdx] = '(' then
    begin
      curRegelIdx := pruefInKlammernRegel(Memo1.lines[regelZeile],regelZeile,curRegelIdx);
      if curRegelIdx = 0 then exit(false);
      // ueberspringen von der Schliessenden Klammer
      inc(curRegelIdx);
    end;
    tmp_links := copy(Memo1.lines[regelZeile],1,curRegelIdx-1);

    if (not istIdxInGrenzen(curRegelIdx+1)) or (Memo1.lines[regelZeile][curRegelIdx] <> '-') or (Memo1.lines[regelZeile][curRegelIdx+1] <> '>') then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ' | Position' + IntToStr(curRegelIdx) + ': Ein "-" gefolgt von ">" erwartet, aber nicht gefunden!');
      exit(false);
    end;
    curRegelIdx := curRegelIdx + 2;

    // Komma feststellen und pruefen der rechnten Seite
    kommaPos := 0; kommaCnt := 0;
    for kommaIdx := curRegelIdx to length(Memo1.lines[regelZeile]) do
    begin
      if Memo1.lines[regelZeile][kommaIdx] = ',' then
      begin
        kommaPos := kommaIdx;
        inc(KommaCnt);
      end;
    end;
    if kommaCnt > 1 then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ': Du kannst nicht mehr als ein Komma ein einer Regel haben.');
      exit(false);
    end;
    if kommaCnt = 0 then tmp_rechts := copy(Memo1.lines[regelZeile],curRegelIdx,length(Memo1.lines[regelZeile]))
    else tmp_rechts := copy(Memo1.lines[regelZeile],curRegelIdx,kommaPos-curRegelIdx);
    if not pruefeErsetzungsSyntax(tmp_rechts,regelZeile,curRegelIdx) then exit(false);

    // Zufaelligkeit angeben
    if kommaCnt = 0 then tmp_zufaelligkeit := 100 else if kommaPos = length(Memo1.lines[regelZeile]) then
    begin
      showMessage('Zeile ' + intToStr(regelZeile+1) + ': Es muss etwas nach dem Komma folgen.');
      exit(false);
    end
    else
    begin
      if versucheStringToReal(copy(Memo1.lines[regelZeile],kommaPos+1,length(Memo1.lines[regelZeile])-kommaPos+3)) then // 1 sollte eigentlich ausreichen
      begin
        tmp_zufaelligkeit := strToFloat(copy(Memo1.lines[regelZeile],kommaPos+1,length(Memo1.lines[regelZeile])-kommaPos+3))
      end
      else
      begin
        showMessage('Zeile ' + intToStr(regelZeile+1) + ': Die Zufaelligkeit ist nicht richtig formatiert.');
        exit(false);
      end;
    end;
    
    if not map.TryGetData(tmp_links,data) then map[tmp_links] := 0;
    map[tmp_links] := data + tmp_zufaelligkeit;

    result := true;
  end;
begin
  map := TMapStringToReal.Create;
  for regelZeile := 1 to Memo1.lines.count-1 do if not aux_pruefeRegel then exit(false);

  // pruefe map
  for dataIdx := 0 to map.Count - 1 do
  begin
    if map.data[dataIdx] <> 100 then
    begin
      showMessage('Die Zufaelligkeiten des Eintrages "' + map.keys[dataIdx] + '" ergeben in der Summe nicht 100.');
      exit(false);
    end;
  end;
  result := true;
end;

procedure TuGrammatiken.Button1Click(Sender: TObject); 
var zeichnerInit: TZeichnerInit;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;
    turtle: TTurtle;
    anzahl, nr, i: Cardinal;
    checked: Boolean;
    NameGrammatik: String;
    zeilenIdx,regelIdx: Cardinal;
    tmp_links, tmp_rechts: String;
    tmp_zufaelligkeit: Real;
begin
  // pruefen der Zeilen -> die Turtle wird beim einlesen erstellt
  if not pruefeAxiom(Memo1.lines[0]) then exit;
  if not pruefeRegel then exit;
  
  gram.axiom := Memo1.lines[0];
  for zeilenIdx := 1 to Memo1.lines.Count - 1 do
  begin 
    regelIdx := 1; tmp_links := ''; tmp_rechts := ''; tmp_zufaelligkeit := 0;
    // links
    while Memo1.lines[zeilenIdx][regelIdx] <> '-' do 
    begin
      tmp_links := tmp_links + Memo1.lines[zeilenIdx][regelIdx];
      inc(regelIdx)
    end;
    regelIdx := regelIdx + 2;

    // rechts
    while (length(Memo1.lines[zeilenIdx]) >= regelIdx) and (Memo1.lines[zeilenIdx][regelIdx] <> ',') do 
    begin
      tmp_rechts := tmp_rechts + Memo1.lines[zeilenIdx][regelIdx];
      inc(regelIdx)
    end;

    // zufaelligkeit
    if (length(Memo1.lines[zeilenIdx]) < regelIdx) then tmp_zufaelligkeit := 100
    else tmp_zufaelligkeit := strToFloat(copy(Memo1.lines[zeilenIdx],regelIdx+1,length(Memo1.lines[zeilenIdx])-regelIdx+3));

    gram.addRegel(tmp_links,tmp_rechts,tmp_zufaelligkeit)
  end;
  
  for i:=0 to CheckListBox1.Count -1 do
  begin
       if CheckListBox1.Checked[i] then checked:=true;
  end;
  if not checked=true then
  begin
       SHOWMESSAGE('Du musst eine Zeichenart makieren!');
       exit;
  end;

  If not (Edit2.text = '') then zeichenPara.rekursionsTiefe:= strtoint(Edit2.Text)
  else SHOWMESSAGE('Eine Rekurstiefe von 0 ist nicht möglich!');

  If not (Edit3.text = '') then
  Begin
    If strtofloat(Edit3.Text)<=360 then
    Begin
      zeichenPara.winkel:=strtofloat(Edit3.Text);
      NameGrammatik:=Edit4.Text;
      anzahl:= strtoint(Edit1.Text);
      if anzahl=0 then SHOWMESSAGE('Deine Anzahl ist 0. Es wird keine Darstellung erstellt.')
      else
      begin
        nr:=gib_markierte_nr();
        turtlemanager:=Hauptform.o.copy();
        //erstellen der Turtels
        for i:=1 to anzahl do
        begin
          Hauptform.update_startkoords();
          zeichenPara.setzeStartPunkt(Hauptform.akt_x,Hauptform.akt_y,Hauptform.akt_z);
          Turtle:=TTurtle.Create(gram,zeichnerInit.initialisiere(zeichnerInit.gibZeichnerListe[nr],zeichenPara),Hauptform.maximaleStringLaenge);
          Turtle.name:=NameGrammatik;
          turtlemanager.addTurtle(Turtle);
        end;
        if turtle.zeichnen then
        begin
          Hauptform.push_neue_instanz(turtlemanager);
          Hauptform.ordnen();
          Visible:=False;
          Hauptform.zeichnen();
        end
        else SHOWMESSAGE('Der gezeichnete Baum ist zu groß. In den Optionen kann die maximale Stringlänge geändert werden. ');
      end;
    end
    else SHOWMESSAGE('Du hast die Maximale Größe des Winkels von 360 überschritten!');
  end;
end;

procedure TuGrammatiken.Button2Click(Sender: TObject); //Alles leeren
var n:CARDINAL;
    i : integer;
begin
  For n:=0 to Memo1.Lines.Count-1 do
  Begin
       Memo1.Clear;
  end;
  for i := 0 to ComponentCount - 1 do if Components[i] is TEdit then TEdit(Components[i]).Clear;
  for i := 0 to CheckListBox1.Count -1 do CheckListBox1.Checked[I] := False;
end;

procedure TuGrammatiken.CheckGroup1ItemClick(Sender: TObject; Index: integer);
var i : integer;
//Diese Funktion sorgt dafür, dass immer nur ein objekt gleichzeitig angeklickt sein kann.
begin
    if (Sender as TCheckListBox).Checked[Index] then
    begin
        for i := 0 to CheckListBox1.Count -1 do
        CheckListBox1.Checked[i] := False;
        CheckListBox1.Checked[Index] := True;
    end;
end;

procedure TuGrammatiken.CheckListBox1ItemClick(Sender: TObject; Index: integer);
var
  Counter : integer;
  MyCheckListBox : TCheckListBox; // you can also use the name of the actual TCheckListBox
begin
  MyCheckListBox:=TCheckListBox(Sender);
  for Counter:= 0 to MyCheckListBox.Items.Count-1 do
    begin
         if (Counter<>Index) then
         MyCheckListBox.Checked[Counter]:= false;
    end;
end;

procedure TuGrammatiken.Edit1Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.Edit2Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.Edit3Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.Edit3KeyPress(Sender: TObject; var Key: char);
begin
    if not (Key in ['0'..'9', DecimalSeparator, Char(VK_BACK), Char(VK_DELETE)])
    then Key := #0;
end;

procedure TuGrammatiken.Edit4Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.FormCreate(Sender: TObject);
VAR zeichnerInit: TZeichnerInit; baumListe: TStringList;  i: Cardinal;
begin
  //zeichenarten laden
  zeichnerInit := TZeichnerInit.Create;
  baumListe := zeichnerInit.gibZeichnerListe;
  for i := 0 to baumListe.Count - 1 do
  begin
       // baumListe[i] in ComboBox packen
       CheckListBox1.AddItem(baumListe[i],NIL);
  end;
  for i := 0 to CheckListBox1.Count-1 do CheckListBox1.Checked[i] := False;
end;



procedure TuGrammatiken.Memo1Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.MenuItem1Click(Sender: TObject);
begin

end;

procedure TuGrammatiken.MenuItem2Click(Sender: TObject); //Turtle laden
var turtle: TTurtle;
    baumListe: TStringList;
    Baum:String;
    regelnLinkeSeite, regelnRechteSeite: TStringList;
    regelnLinkeSeiteIdx, regelnRechteSeiteIdx: Cardinal;
    i:Cardinal;
    q:Integer;
    conf: TJSONConfig;
    zeichnerInit: TZeichnerInit;
    tmp_pfad:String;
    produktion:String;
    axiom:String;
    zufaelligkeit:Real;
    n:CARDINAL;
    klammerauf:Integer;
    j : integer;
begin
  OpenDialog1.Filter:='Json-Dateien (*.json)|*.json';
  if OpenDialog1.Execute then
  begin
    conf:= TJSONConfig.Create(nil);
    regelnRechteSeite := TStringList.Create;
    regelnLinkeSeite := TStringList.Create;
    zeichnerInit := TZeichnerInit.Create;
    baumListe := zeichnerInit.gibZeichnerListe;
    turtle := TTurtle.Create(OpenDialog1.FileName);
    Edit2.Text:=inttostr(turtle.rekursionsTiefe);
    Edit3.Text:=floattostr(turtle.winkel);
    Edit4.Text:=turtle.name;
    Baum:=turtle.zeichnerName;
    conf.filename:= OpenDialog1.FileName;
    For n:=0 to Memo1.Lines.Count-1 do
    Begin
         Memo1.Clear;
    end;
    for j:=0 to ComponentCount - 1 do if Components[i] is TEdit then TEdit(Components[j]).Clear;
    for j:=0 to CheckListBox1.Count -1 do CheckListBox1.Checked[j] := False;
    For j:=0 to baumListe.Count - 1 do
    begin
      if Baum=baumListe[j] then CheckListBox1.Checked[j] := true;
    end;
    //Grammiken laden
    axiom := AnsiString(conf.getValue('Grammatik/axiom', ''));
    If axiom = '' then
    Begin
         SHOWMESSAGE('Deine Datei ist nicht geeignet!')
    end
    else
    Begin
         i:=1;
         Memo1.Lines[0]:=axiom;
         conf.EnumSubKeys(UnicodeString('Grammatik/regeln/'),regelnLinkeSeite);
         for regelnLinkeSeiteIdx := 0 to regelnLinkeSeite.Count - 1 do
         begin
            regelnRechteSeite:=TStringList.create;
            tmp_pfad := 'Grammatik/regeln/' + regelnLinkeSeite[regelnLinkeSeiteIdx];
            conf.EnumSubKeys(UnicodeString(tmp_pfad), regelnRechteSeite);
            for regelnRechteSeiteIdx := 0 to regelnRechteSeite.Count-1 do
                 begin
                      produktion := AnsiString(conf.getValue(
                      UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/produktion'),''));
                      q:=pos(',',produktion);
                      If q=0 then
                      Begin
                           zufaelligkeit := conf.getValue(
                           UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/zufaelligkeit'),0.0);
                           if zufaelligkeit=100 then
                           begin
                                Memo1.Lines[i]:=regelnLinkeSeite[regelnLinkeSeiteIdx]+'->'+produktion;
                                INC(i);
                           end
                           else
                           begin
                                Memo1.Lines[i]:=regelnLinkeSeite[regelnLinkeSeiteIdx]+'->'+produktion+','+FloattoStr(zufaelligkeit);
                                INC(i);
                           end;
                      end
                      else
                      Begin
                           produktion:=copy(produktion,1,q-1);
                           zufaelligkeit := conf.getValue(
                           UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/zufaelligkeit'),0.0);
                           if zufaelligkeit=100 then
                           begin
                                Memo1.Lines[i]:=regelnLinkeSeite[regelnLinkeSeiteIdx]+'->'+produktion;
                                INC(i);
                           end
                           else
                           begin
                                Memo1.Lines[i]:=regelnLinkeSeite[regelnLinkeSeiteIdx]+'->'+produktion+','+FloattoStr(zufaelligkeit);
                                INC(i);
                           end;
                      end;
                end;
                freeAndNil(regelnRechteSeite);
         end;
    end;
    conf.Free;
  end
  else
  begin
  end;
end;

procedure TuGrammatiken.MenuItem3Click(Sender: TObject); //Turtle speichern
  var turtle: TTurtle;
      n,nr:CARDINAL;
      gram:TGrammatik;R,L,NameGrammatik:String;
      W:REAL;
      zeichenPara: TZeichenParameter;
      p,s,q: Integer;
      zeichnerInit:TzeichnerInit;
      begin
       SaveDialog1.Filter:='Json-Dateien (*.json)|*.json';
       If SaveDialog1.Execute then
       begin
            zeichnerInit := TZeichnerInit.Create;
            gram:=TGrammatik.Create;
            n:=1;
            p:=pos('>',Memo1.Lines[0]);
            if not ((Edit3.text = '') or (Edit2.text = '') or (Edit4.text = '')) then
            begin
                 if p=0 then
                 begin
                      gram.axiom:= Memo1.Lines[0];
                      While n<= Memo1.Lines.Count-1 do
                      begin
                           s:=pos(',',Memo1.Lines[n]);
                           If s=0 then
                           begin
                                p:=pos('>',Memo1.Lines[n]);
                                L:=copy(Memo1.Lines[n],1,p-2);//linke Seite des '->'
                                R:=copy(Memo1.Lines[n],p+1,p+100);//rechte Seite des '->'
                                gram.addRegel(L,R);//Regel ohne Wahrscheinlichkeit hinzufügen
                                INC(n);
                           end
                           else
                           begin
                                p:=pos('>',Memo1.Lines[n]);
                                L:=copy(Memo1.Lines[n],1,p-2);//linke Seite des '->'
                                R:=copy(Memo1.Lines[n],p+1,s-1);//rechte Seite des '->'
                                q:=pos(',',R);
                                If q<>0 then R:=copy(R,0,q-1);
                                W:=strtofloat(copy(Memo1.Lines[n],s+1,s+10));//wahrscheinlichkeit
                                gram.addRegel(L,R,W);//Regel mit Wahrscheinlichkeit hinzufügen
                                INC(n);
                           end
                      end;
                      zeichenPara.rekursionsTiefe:= strtoint(Edit2.Text);
                      zeichenPara.winkel:=strtofloat(Edit3.Text);
                      NameGrammatik:=Edit4.Text;
                      nr:=gib_markierte_nr();
                      zeichenPara.setzeStartPunkt(Hauptform.akt_x,Hauptform.akt_y,Hauptform.akt_z);
                      turtle:=TTurtle.Create(gram,zeichnerInit.initialisiere(zeichnerInit.gibZeichnerListe[nr],zeichenPara));
                      turtle.name:=NameGrammatik;
                      turtle.speichern(SaveDialog1.FileName);
                 end
                 else SHOWMESSAGE('Du kannst nichts ohne Grammatik speichern!');
            end
            else
            begin
                 SHOWMESSAGE('Du musst überall Werte eingeben!');
            end;
      end
      else
      begin
      end;
end;
end.


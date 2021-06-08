unit UGrammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,uturtlemanager,
  ExtCtrls, CheckLst, uAnimation,ugrammatik, uTurtle,fpjson,LCLType,jsonparser, jsonConf, uStack;
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
  public

  end;

var
  aGrammatiken: TuGrammatiken;

implementation
uses uForm,uZeichnerBase,uZeichnerInit;
{$R *.lfm}

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
var stack: TStack;
    axiomIdx: Cardinal;
    { Eingabe: Der Pointer/Index (des Axiom-Strings) auf der Klammer (also axiom[idx] = '(' -> true)) 
      wird als Uebergeben.
      Aufgabe: Prueft die Eingabe in der Klammer.
      Rueckgabewert: Wenn die Eingabe in der Klammer Korrekt ist, so wird der Index des
      Axiom-Strings direkt auf der letzten Klammer zurueckgegeben. Andernfalls, wird die 
      position nicht mehr als wichtig erachtet und es wird der Token 0 also Rueckgabe zurueckgegeben. }
    function pruefInKlammern(idx: Cardinal) : Cardinal;
    begin
      // ueberspringen vom Klammer auf
      inc(idx);
      // der letzte Buchstabe wird weggelassen, da dieser ein ')' sein muss,
      // wenn alles richtig ist 
      while idx < length(axiom) do 
      begin
        if axiom[idx] = '(' then
        begin
          showMessage('Klammern duerfen nicht verschachtelt werden! Fehler an Position ' + IntToStr(idx) + ' im Axiom.');
          exit(0);
        end
        else if axiom[idx] = ')' then break
        // Regel 6
        else if axiom[idx] = ';' then
        begin
          if ((not isDigit(axiom[idx-1])) or (not isDigit(axiom[idx+1]))) then
          begin
            showMessage('Das Semikolon innerhalb einer Klammer ist nicht richtig plaziert worden! An Position ' + IntToStr(idx) + '.');
            exit(0);
          end;
        end
        else if not isDigit(axiom[idx]) then
        begin
          showMessage('"' + axiom[idx] + '" gefunden, aber eine Zahl erwartet! An Position  ' + IntToStr(idx) + '.');
          exit(0);
        end;
        inc(idx);
      end;
      if axiom[idx] = ')' then exit(idx);
      showMessage('Vermutlich wurde eine runde Klammer im Axiom vergessen.');
      result := 0;
    end;
begin
  stack := TStack.Create;
  axiomIdx := 1;
  while axiomIdx <= length(axiom) do
  begin
    // Regel 4
    if axiom[axiomIdx] = '[' then stack.push('[')
    else if axiom[axiomIdx] = ']' then 
    begin
      if (stack.empty) or (stack.pop <> '[') then
      begin
        showMessage('Kann die zugehoerige eckige Klammer im Axiom nicht nicht finden. An Position ' + IntToStr(axiomIdx) + '.'); 
        exit(false);
      end;
    end
    // Regel 1
    else if isUpper(axiom[axiomIdx]) then 
    begin
      // Es duerfen nur runde Klammern nach dem grossen Buchstaben folgen
      if (axiomIdx+1 <= length(axiom)) and (axiom[axiomIdx+1] = '(') then
      begin
        axiomIdx := pruefInKlammern(axiomIdx);
        if axiomIdx = 0 then exit(false);
      end
    end
    // Regel 3
    else if (axiom[axiomIdx] = '(') or (axiom[axiomIdx] = ')') then 
    begin
      showMessage('Einige runden Klammern sind im Axiom fehl am Platz. Die sollten nur hinter den Grossbuchstaben als Parameter stehen. Eine davon ist in der Position ' +IntToStr(axiomIdx) + '.');
      exit(false);
    end
    // Regel 2
    else if isLower(axiom[axiomIdx]) then 
    begin 
      showMessage('Es sind keine Kleinbuchstaben im Axiom erlaubt. Diese sind fuer Variabelnamen in der Regel reserviert! Guck dir Position ' + intToStr(axiomIdx) + ' an.');
      exit(false);
    end
    // Regel 7
    else if isDigit(axiom[axiomIdx]) then 
    begin
      showMessage('Im Axiom sind Zahlen ausserhalb der runden Klammern! In der Position ' + intToStr(axiomIdx) + '.');
      exit(false);
    end;
    inc(axiomIdx)
  end;
  if not stack.empty then
  begin
    showMessage('Schliesse Klammern, die im Axiom geoeffnet wurden!');
    exit(false)
  end;
  result := true;
end;
{
- Hinzufuegen der Regeln (-> Annahme: Vorliegenden Regeln wurden bereits geprueft und sind richtig):
  - Regeln werden eingelesen
  - Turtle wird zum Manager hinzugefuegt
}

{ 
- Regeln pruefen:
  - Parameter muessen Kleinbuchstaben sein!
  - Ein Axiom kann nur ein Grossbuchstabe sein!
    -> dannach koennen die Parameter in '(...)' angegeben werden, wenn es welche gibt
      -> diese duerften nicht verschachtelt sein
  - Wohlgeformte Klammern '[]'
  - Parameter muessen mit einem ';' getrennt werden
  - Ein Grossbuchstabe muss die Zufaelligkeit von insgesamt 100% besitzen
}
function pruefeRegel(regel: String; regelZeile: Cardinal);
begin
  result := true;
end;

procedure TuGrammatiken.Button1Click(Sender: TObject); 
var zeichnerInit: TZeichnerInit;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;
    Turtle: TTurtle;
begin
  if not pruefeAxiom(Memo1.lines[0]) then exit;
  // if not pruefeRegel(...) then exit;
  // Einfuegen von dem Axiom
  showMessage('Eingefuegt')
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


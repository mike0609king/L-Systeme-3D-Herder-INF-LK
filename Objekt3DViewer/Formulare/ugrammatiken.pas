unit UGrammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,uturtlemanager,
  ExtCtrls, CheckLst, uAnimation, fgl, ugrammatik, uTurtle, fpjson, jsonparser, jsonConf;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckGroup1ItemClick(Sender: TObject; Index: integer);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private
    turtlemanager:TTurtlemanager;
    function gib_markierte_nr():CARDINAL;
    function stringanalyse(s:string):BOOLEAN;
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
function TuGrammatiken.stringanalyse(s:string):BOOLEAN;
//für regeln nicht axiome
VAR str,rest_string:string; i,l,h,k,j,g,b:CARDINAL; c:Char;klammer_auf,bool:Boolean;
begin
   str:=Copy(s,1,length(s));
   rest_string:=Copy(s,1,length(s));
   l:=length(str);
   h:=ord(str[1]);
   if not ((h=ord('f')) or ((h>=ord('A')) and (h<=ord('Z')))) then
   begin
        SHOWMessage('Ein Axiom kann nur ein Großbuchstabe sein! ');
        exit(False);
   end;
   //wohlgeformte klammern   ()
   klammer_auf:=False;
   for i:=1 to l do
     begin
       if str[i]='(' then
       begin
         if klammer_auf then
         begin
              SHOWMessage('Eine Klammer muss geschlossen werden bevor eine neue geöffent werden kann!');
              exit(False);
         end
         else klammer_auf:=True;
       end;
       if str[i]=')' then klammer_auf:=False;
     end;
   if not klammer_auf then
     begin
     j:=pos('(',str);
     if j<>0 then
       begin
       while pos('(',rest_string)<>0 do
         begin
            g:=pos(')',rest_string)-1;
            bool:=True;
            for k:=pos('(',rest_string)+1 to g do
              begin
                h:=ord(str[k]);
                if bool then
                begin
                     if not ((h>=ord('a')) and (h<=ord('z'))) then
                     begin
                          ShowMessage('Parameter müssen kleine Buchstaben sein!');
                          exit(False)
                     end;
                     bool:=False;
                end
                else
                begin
                     if h=ord(';') then
                     begin
                         bool:=False;
                     end
                     else
                     begin
                          ShowMessage('Parameter müssen mit einem ";" getrennt werden!');
                          exit(False)
                     end;
                end;
              end;
            g:=pos(')',rest_string);
            rest_string:=copy(rest_string,g+1,g+100);
          end;
       end;
   end
   else
   begin
        SHOWMessage('Klammern müssen geschlossen werden!');
        exit(False);
   end;
end;
procedure TuGrammatiken.Button1Click(Sender: TObject); //Turtle erstellen
var i,n,nr,anzahl:CARDINAL;
    gram:TGrammatik;R,L,NameGrammatik:String;
    W:REAL;
    g:String;
    //Lc:Char;
    k,c:String;
    Turtle:TTurtle;zeichenPara: TZeichenParameter;
    p,s,q: Integer; zeichnerInit:TzeichnerInit;
Begin
g:=Memo1.Lines[0];
if Length(g) > 0 then
Begin
  n:=1;
  While n<= Memo1.Lines.Count-1 do
        Begin
          zeichnerInit := TZeichnerInit.Create;
          gram:=TGrammatik.Create;
          gram.axiom:= Memo1.Lines[0];
            begin
             if not stringanalyse(Memo1.Lines[n])then break;
             p:=pos('>',Memo1.Lines[n]);
             if p=0 then
             Begin
               SHOWMESSAGE('Deine Eingabe ist falsch! Bitte überprüfe die Grammatik!');
               break;
             end;
             begin
             s:=pos(',',Memo1.Lines[n]);
             If s=0 then
              begin
                p:=pos('>',Memo1.Lines[n]);
                L:=copy(Memo1.Lines[n],1,p-2);//linke Seite des '->'
                R:=copy(Memo1.Lines[n],p+1,p+100);//rechte Seite des '->'
                gram.addRegel(L,R);//Regel ohne Wahrscheinlichkeit hinzufügen
                INC(n)
              end
              else
              begin
                p:=pos('>',Memo1.Lines[n]);
                L:=copy(Memo1.Lines[n],1,p-2);//linke Seite des '->'
                R:=copy(Memo1.Lines[n],p+1,s-1);//rechte Seite des '->'
                q:=pos(',',R);
                If not q=0 then delete(R,q,q+10)
              else
              begin
                W:=strtofloat(copy(Memo1.Lines[n],s+1,s+10));//wahrscheinlichkeit
                gram.addRegel(L,R,W);//Regel mit Wahrscheinlichkeit hinzufügen
                INC(n);
                end;
              end
            end;
          If not (Edit2.text = '') then
          Begin
           zeichenPara.rekursionsTiefe:= strtoint(Edit2.Text);
           If not (Edit3.text = '') then
           Begin
           If strtofloat(Edit3.Text)<=99999999 then
           Begin
           zeichenPara.winkel:=strtofloat(Edit3.Text);
           NameGrammatik:=Edit4.Text;
           anzahl:= strtoint(Edit1.Text);
           if anzahl=0 then
             Begin
             SHOWMESSAGE('Deine Anzahl ist 0. Es wird keine Darstellung erstellt.');
             end
           else
           Begin
             nr:=gib_markierte_nr();
             turtlemanager:=Hauptform.o.copy();
             //erstellen der Turtels
             for i:=1 to anzahl do
               begin
                 Hauptform.update_startkoords();
                 zeichenPara.setzeStartPunkt(Hauptform.akt_x,Hauptform.akt_y,Hauptform.akt_z);
                 Turtle:=TTurtle.Create(gram,zeichnerInit.initialisiere(zeichnerInit.gibZeichnerListe[nr],zeichenPara));
                 Turtle.name:=NameGrammatik;
                 turtlemanager.addTurtle(Turtle);
               end;
             if True then
             begin
               Hauptform.push_neue_instanz(turtlemanager);
               Hauptform.ordnen();
               Visible:=False;
               Hauptform.zeichnen();
             end
             else
             begin
               SHOWMESSAGE('Der gezeichnete Baum ist zu groß. In den Optionen kann die maximale Stringlänge geändert werden. ');
             end;
           end;
           end
           else SHOWMESSAGE('Du hast die Maximale Größe des Winkels von 99999999 überschritten!');
           end;
           end
           else SHOWMESSAGE('Eine Rekurstiefe von 0 ist nicht möglich!');
         end;
    end;
end
else SHOWMESSAGE('Deine Eingabe ist falsch! Bitte überprüfe die Grammatik!');
end;

procedure TuGrammatiken.Button2Click(Sender: TObject); //Alles leeren
var n:CARDINAL;
    i : integer;
begin
  For n:=0 to Memo1.Lines.Count-1 do
  Begin
  Memo1.Lines[n]:='';
  end;
  for i := 0 to ComponentCount - 1 do
  if Components[i] is TEdit then
    TEdit(Components[i]).Clear;
  for i := 0 to CheckListBox1.Count -1 do CheckListBox1.Checked[I] := False;
end;

procedure TuGrammatiken.CheckGroup1ItemClick(Sender: TObject; Index: integer);
var i : integer;
//Diese Funktion sorgt dafür, dass immer nur ein objekt gleichzeitig angeklickt sein kann.
begin
    if (Sender as TCheckListBox).Checked[Index] then begin
        for i := 0 to CheckListBox1.Count -1 do
            CheckListBox1.Checked[i] := False;
        CheckListBox1.Checked[Index] := True;
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

procedure TuGrammatiken.Edit4Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.FormCreate(Sender: TObject);
VAR zeichnerInit: TZeichnerInit; baumListe: TStringList;  i: Cardinal;
begin
  //zeichenarten laden
  zeichnerInit := TZeichnerInit.Create;
  baumListe := zeichnerInit.gibZeichnerListe;
  // durch die Liste iterieren
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
    tmp_pfad:String; FGrammatik:TGrammatik;
    produktion:String;
    axiom:String;
    zufaelligkeit:Real;
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
    For i:=0 to baumListe.Count - 1 do
    begin
      if Baum=baumListe[i] then CheckListBox1.Checked[i] := true;
    end;
    //Grammiken laden
    axiom := AnsiString(conf.getValue('Grammatik/axiom', ''));
    If axiom = '' then
    Begin
    SHOWMESSAGE('Deine Datei ist nicht geeignet!')
    end
    else
    Begin
    conf.EnumSubKeys(UnicodeString('Grammatik/regeln/'),regelnLinkeSeite);
    for regelnLinkeSeiteIdx := 0 to regelnLinkeSeite.Count - 1 do
        begin
            i:=1;
            tmp_pfad := 'Grammatik/regeln/' + regelnLinkeSeite[regelnLinkeSeiteIdx];
            conf.EnumSubKeys(UnicodeString(tmp_pfad), regelnRechteSeite);
            for regelnRechteSeiteIdx := 0 to regelnRechteSeite.Count - 1 do
            begin
                produktion := AnsiString(conf.getValue(
                    UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/produktion'),
                    ''
                ));
                q:=pos(',',produktion);
                If q=0 then
                BEGIN
                  zufaelligkeit := conf.getValue(
                      UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/zufaelligkeit'),
                      0.0
                  );
                  Memo1.Lines[0]:=axiom;
                  Memo1.Lines[i]:=axiom+'->'+produktion+','+FloattoStr(zufaelligkeit);
                  INC(i);
                end
                else
                Begin
                delete(produktion,q,q+10);
                  zufaelligkeit := conf.getValue(
                      UnicodeString(tmp_pfad + '/' + regelnRechteSeite[regelnRechteSeiteIdx] + '/zufaelligkeit'),
                      0.0
                  );
                  Memo1.Lines[0]:=axiom;
                  Memo1.Lines[i]:=axiom+'->'+produktion+','+FloattoStr(zufaelligkeit);
                  INC(i);
                END;
          end;
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
      n,nr,anzahl:CARDINAL;
      //Lc:Char;
      gram:TGrammatik;R,L,NameGrammatik:String;
      W:REAL;
      zeichenPara: TZeichenParameter;
      p,s,q: Integer; zeichnerInit:TzeichnerInit;
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
          INC(n)
        end
           else
           begin
            p:=pos('>',Memo1.Lines[n]);
            L:=copy(Memo1.Lines[n],1,p-2);//linke Seite des '->'
            R:=copy(Memo1.Lines[n],p+1,s-1);//rechte Seite des '->'
            q:=pos(',',R);
          If not q=0 then
          delete(R,q,q+10)
          else
            W:=strtofloat(copy(Memo1.Lines[n],s+1,s+10));//wahrscheinlichkeit
            gram.addRegel(L,R,W);//Regel mit Wahrscheinlichkeit hinzufügen
            INC(n);
        end
      end;
    zeichenPara.rekursionsTiefe:= strtoint(Edit2.Text);
    zeichenPara.winkel:=strtofloat(Edit3.Text);
    NameGrammatik:=Edit4.Text;
    nr:=gib_markierte_nr();
         begin
           zeichenPara.setzeStartPunkt(Hauptform.akt_x,Hauptform.akt_y,Hauptform.akt_z);
           turtle:=TTurtle.Create(gram,zeichnerInit.initialisiere(zeichnerInit.gibZeichnerListe[nr],zeichenPara));
           turtle.name:=NameGrammatik;
           turtle.speichern(SaveDialog1.FileName);
         end;
       end
       else
       SHOWMESSAGE('Du kannst nichts ohne Grammatik speichern!');
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


unit uEditor_Grammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  CheckLst;

type

  { TForm10 }

  TForm10 = class(TForm)
    BT_entfernen: TButton;
    BT_bearbeiten: TButton;
    BT_Fertig: TButton;
    BT_sichtbarkeit: TButton;
    BT_update: TButton;
    BT_Alle: TButton;
    BT_alle_unmarkieren: TButton;
    BT_unsichtbar_machen: TButton;
    CheckListBox1: TCheckListBox;
    procedure BT_AlleClick(Sender: TObject);
    procedure BT_bearbeitenClick(Sender: TObject);
    procedure BT_entfernenClick(Sender: TObject);
    procedure BT_FertigClick(Sender: TObject);
    procedure BT_sichtbarkeitClick(Sender: TObject);
    procedure BT_unsichtbar_machenClick(Sender: TObject);
    procedure BT_updateClick(Sender: TObject; o:TTurtleManager);
    procedure BT_alle_unmarkierenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function gib_markierte_nr();
  public

  end;

var
  Form10: TForm10;
  o:TTurtleManager;

implementation

{$R *.lfm}

{ TForm10 }

procedure TForm10.BT_updateClick(Sender: TObject);
VAR i,anzahl:CARDINAL;
begin
  CheckListBox1.clear
  anzahl:=o.anzahlElemente;
  for i:=0 to anzahl do               //aufpassen indexe
      begin
           str:='Turtel'+strtoint(i)+':'+o[i].name    //Die weiteren Eigenschaften der Turtel hinzufügen: sichtbarkeit, Koordinaten??, Parameter, name
           CheckListBox1.AddItem(str,NIL)
      end;
end;

procedure TForm10.BT_alle_unmarkierenClick(Sender: TObject);
VAR i:CARDINAL;
begin
  for i := 0 to CheckListBox1.Count-1 do CheckListBox1.Checked[I] := False;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin

end;

procedure TForm10.BT_AlleClick(Sender: TObject);
begin
    CheckListBox1.SelectAll;
end;

procedure TForm10.BT_bearbeitenClick(Sender: TObject);
VAR liste:TList;
begin
    //Parameterform aufrufen
    liste:= gib_markierte_nr
end;

procedure TForm10.BT_entfernenClick(Sender: TObject); //dringt testen
VAR hl:TListe;i,a:CARDINAL;
begin
   hl:=gibmarkierte_nr
   a:=0
   for i := 0 to CheckListBox1.Count -1 do
       begin
            if CheckListBox1.Checked[i] then
            begin
                 o.setzeSichtbarkeit(i-a,true)
                 o.entferneTurtleAn(i-a)
                 inc(a)
            end;
       end;
   BT_updateClick(self)
end;
procedure TForm10.BT_FertigClick(Sender: TObject);
begin

end;

procedure TForm10.BT_sichtbarkeitClick(Sender: TObject);
VAR hl:TListe;i:CARDINAL;
begin
   hl:=gibmarkierte_nr
   for i := 0 to CheckListBox1.Count -1 do
       begin
            if CheckListBox1.Checked[i] then
            begin
                 o.setzeSichtbarkeit(i,true)
            end;
       end;
end;

procedure TForm10.BT_unsichtbar_machenClick(Sender: TObject);
VAR hl:TListe;i:CARDINAL;
begin
   hl:=gibmarkierte_nr
   for i := 0 to CheckListBox1.Count -1 do
       begin
            if CheckListBox1.Checked[i] then
            begin
                 o.setzeSichtbarkeit(i,false)
            end;
       end;
   BT_updateClick(self)
end;
function TForm10.gib_markierte_nr();
VAR hl:TList;i,h:CARDINAL;
begin
   hl.Create()
   h:=0
   for i := 0 to CheckListBox1.Count -1 do
       begin
       if CheckListBox1.Checked[i] then
       begin
            hl.Insert(h,i)
            INC(h)
       end;
       end;
   result:=hl
end;
end.


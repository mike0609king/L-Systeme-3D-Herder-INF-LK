unit uparameter_form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, uTurtlemanager,
  CheckLst;

type

  { TParameter_Form }

  TParameter_Form = class(TForm)
    BT_Bestaetigen: TButton;
    BT_reset: TButton;
    CheckListBox1: TCheckListBox;
    ED_Winkel: TEdit;
    ED_Rek_tiefe: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BT_BestaetigenClick(Sender: TObject);
    procedure BT_resetClick(Sender: TObject);
    procedure CheckListBox1ItemClick(Sender: TObject; Index: integer);
    procedure ED_Rek_tiefeChange(Sender: TObject);
    procedure ED_WinkelChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    baumListe: TStringList;
    turtlemanager:TTurtlemanager;
  public
  end;

var
  Parameter_Form: TParameter_Form;

implementation
uses uEditor_Grammatiken,uForm, uzeichnerinit;

{$R *.lfm}

{ TParameter_Form }

procedure TParameter_Form.BT_BestaetigenClick(Sender: TObject);
begin
  ED_WinkelChange(self);
  ED_Rek_tiefeChange(self);
  Hauptform.zeichnen();
  Visible:=False;

end;

procedure TParameter_Form.BT_resetClick(Sender: TObject);
VAR i:CARDINAl;
begin
  ED_Winkel.text:='';
  ED_Rek_tiefe.text:='';
  for i:= 0 to CheckListBox1.Count -1 do CheckListBox1.Checked[I] := False;
end;

procedure TParameter_Form.CheckListBox1ItemClick(Sender: TObject; Index: integer);
var
I,h : integer;
begin
    if (Sender as TCheckListBox).Checked[Index] then begin
        turtlemanager:=Hauptform.o.copy();
        for I := 0 to CheckListBox1.Count -1 do
            CheckListBox1.Checked[I] := False;
        CheckListBox1.Checked[Index] := True;
        //zeichenart der markierten turtels ändern
        for h:=0 to EditorForm.ListView1.Items.Count-1 do
        begin
             if EditorForm.ListView1.Items[h].Checked then turtlemanager.turtleListe[h].setzeZeichnerName(baumListe[Index])
        end;
        Hauptform.push_neue_instanz(turtlemanager);
        EditorForm.BT_updateClick(1);
        Hauptform.zeichnen();
    end;
end;
//exceptions handeling
//werte überprüfen
procedure TParameter_Form.ED_WinkelChange(Sender: TObject);
VAR winkel:REAL;i:CARDINAL; str:string;
begin
  str:=ED_Winkel.Text;
  if not (str='') then
  begin
    turtlemanager:=Hauptform.o.copy();
    winkel:=strtofloat(ED_Winkel.text);
    if winkel> 9999999 then
    begin
       SHOWMESSAGE('Der Winkelparameter darf maximal 9.999.999 groß sein.');
       ED_Winkel.text:='';
    end
    else
    begin
      for i:=0 to EditorForm.ListView1.Items.Count-1 do
      begin
           if EditorForm.ListView1.Items[i].Checked then turtlemanager.turtleListe[i].winkel:=winkel;
      end;
      Hauptform.push_neue_instanz(turtlemanager);
      Hauptform.zeichnen();
      EditorForm.BT_updateClick(1);
    end;
  end;
end;

procedure TParameter_Form.FormCreate(Sender: TObject);
VAR zeichnerInit: TZeichnerInit;   i: Cardinal;
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


procedure TParameter_Form.ED_Rek_tiefeChange(Sender: TObject);
VAR rek_tiefe,i:CARDINAL; str:string;bool:boolean;
begin
  turtlemanager:=Hauptform.o.copy();
  bool:=False;
  str:=ED_Rek_tiefe.Text;
  if not (str='') then
    begin
      rek_tiefe:=strtoint(ED_Rek_tiefe.text);
      for i:=0 to EditorForm.ListView1.Items.Count-1 do
      begin
           if EditorForm.ListView1.Items[i].Checked then
           begin
             turtlemanager.turtleListe[i].rekursionsTiefe:=rek_tiefe;
             if not turtlemanager.turtleListe[i].zeichnen() then bool:=True;
           end;
      end;
      if bool then
      begin
         Showmessage('Eine oder mehrere Turtles überschreiten bei dieser Rekursiontiefe die maximale Stringlänge. Diese kann im Optionenfeld geändert werden.');
         ED_Rek_tiefe.Text:='';
      end
      else
      begin
        Hauptform.push_neue_instanz(turtlemanager);
        Hauptform.zeichnen();
        EditorForm.BT_updateClick(1);
      end;

    end;
end;
end.


unit uEditor_Grammatiken;
//funktioniert noch nicht
{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  CheckLst, ComCtrls,uTurtle;

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
    ED_abstand: TEdit;
    Label1: TLabel;
    ListView1: TListView;
    UpDown1: TUpDown;
    procedure BT_AlleClick(Sender: TObject);
    procedure BT_bearbeitenClick(Sender: TObject);
    procedure BT_entfernenClick(Sender: TObject);
    procedure BT_FertigClick(Sender: TObject);
    procedure BT_sichtbarkeitClick(Sender: TObject);
    procedure BT_unsichtbar_machenClick(Sender: TObject);
    procedure BT_updateClick(Sender: TObject);
    procedure BT_alle_unmarkierenClick(Sender: TObject);
    procedure ED_abstandChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
  private
    //function gib_markierte_nr():TList;
  public

  end;

var
  EditorForm: TForm10;

implementation
uses uForm,uParameter_Form;

{$R *.lfm}

{ TForm10 }
procedure TForm10.FormCreate(Sender: TObject);
begin
  //CheckListBox1:=TCheckListBox.Create();


end;
procedure TForm10.UpDown1Click(Sender: TObject; Button: TUDBtnType);
VAR i:REAL;
begin
   //an ED_abstand anbinden
   if button = btNext then
   begin
        i:=strtofloat(ED_abstand.Text)+1;
        ED_abstand.Text:=floattostr(i);
   end
   else
   begin
        i:=strtofloat(ED_abstand.Text)-1;
        ED_abstand.Text:=floattostr(i);
   end;
end;

procedure TForm10.BT_updateClick(Sender: TObject);
VAR i,anzahl:CARDINAL;str,name,sichtbarkeit,Winkel,Rek_tiefe,Zeichenart:string; turtle:TTurtle; Item1: TListItem;
begin
  ListView1.clear;
  anzahl:=(HauptForm.o.turtleListe.Count)-1;
  //abstand
  ED_abstand.Text:=floattostr(Hauptform.abstand_x);
  for i:=0 to anzahl do               //aufpassen indexe
      begin
           Item1 := ListView1.Items.Add;
           Item1.Caption := '';
           turtle:=HauptForm.o.turtleListe[i];
           str:='Turtel'+inttostr(i);
           name:=turtle.name;   //Die weiteren Eigenschaften der Turtel hinzufügen: sichtbarkeit, Koordinaten??, Parameter, name
           if turtle.visible then sichtbarkeit:='Sichtbar'
           else sichtbarkeit:='Unsichtbar';
           Winkel:=floattostr(turtle.winkel);
           Rek_tiefe:=inttostr(turtle.rekursionsTiefe);
           //Zeichenart:=turtle.zeichnerName;  //
           Item1.SubItems.Add(str);
           Item1.SubItems.Add(name);
           Item1.SubItems.Add(sichtbarkeit);
           Item1.SubItems.Add(Winkel);
           Item1.SubItems.Add(Rek_tiefe);
           //Item1.SubItems.Add(Zeichenart);
           //Aktuelle anzhal von Spalten 5
      end;
end;

procedure TForm10.BT_alle_unmarkierenClick(Sender: TObject);
VAR i:CARDINAL;
begin
  for i := 0 to ListView1.Items.Count-1 do ListView1.Items[i].Checked := False;
end;

procedure TForm10.ED_abstandChange(Sender: TObject);
VAR x_abstand:REAL;
    str:String;
begin
   str:=ED_abstand.Text;
   if not (str='') then
   begin
     x_abstand:= strtofloat(ED_abstand.Text);
     Hauptform.abstand_aendern(x_abstand);
   end;
end;

procedure TForm10.BT_AlleClick(Sender: TObject);
VAR i:CARDINAL;
begin
  for i := 0 to ListView1.Items.Count-1 do ListView1.Items[i].Checked := True;
end;

procedure TForm10.BT_bearbeitenClick(Sender: TObject);
begin
    //Parameterform aufrufen
    Parameter_Form.Show;
end;

procedure TForm10.BT_entfernenClick(Sender: TObject);
VAR i,a:CARDINAL;
begin
   a:=0;
   for i := 0 to ListView1.Items.Count -1 do
       begin
            if ListView1.Items[i].Checked then
            begin
                 HauptForm.o.setzeSichtbarkeit(i-a,true);
                 HauptForm.o.entferneTurtleAn(i-a) ;
                 inc(a)
            end;
       end;
   BT_updateClick(self);
end;
procedure TForm10.BT_FertigClick(Sender: TObject);
begin
   Visible:=False;
   Hauptform.zeichnen;
end;

procedure TForm10.BT_sichtbarkeitClick(Sender: TObject);
VAR i:CARDINAL;
begin
   for i := 0 to ListView1.Items.Count -1 do
       begin
            if ListView1.Items[i].Checked then
            begin
                 Hauptform.o.setzeSichtbarkeit(i,true)
            end;
       end;
   BT_updateClick(self);
end;

procedure TForm10.BT_unsichtbar_machenClick(Sender: TObject);
VAR i:CARDINAL;
begin
   for i := 0 to ListView1.Items.Count -1 do
       begin
            if ListView1.Items[i].Checked then
            begin
                 HauptForm.o.setzeSichtbarkeit(i,false)
            end;
       end;
   BT_updateClick(self) ;
end;
(*
function TForm10.gib_markierte_nr():TList;
  VAR hl:TList;i,h:CARDINAL;
  begin
     hl.Create();
     h:=0;
     for i := 0 to CheckListBox1.Count -1 do
         begin
         if CheckListBox1.Checked[i] then
         begin
              hl.Insert(h,i);
              INC(h);
         end;
         end;
     result:=hl;
  end; *)
end.


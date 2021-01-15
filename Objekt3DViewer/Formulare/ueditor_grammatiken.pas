unit uEditor_Grammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  CheckLst,uTurtle;

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
    procedure BT_updateClick(Sender: TObject);
    procedure BT_alle_unmarkierenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    turtle:TTurtle; //hilfsvariable
   // function gib_markierte_nr():TList;
  public

  end;

var
  EditorForm: TForm10;

implementation
uses uForm;

{$R *.lfm}

{ TForm10 }
procedure TForm10.FormCreate(Sender: TObject);
begin
  //CheckListBox1:=TCheckListBox.Create();
end;
procedure TForm10.BT_updateClick(Sender: TObject);
VAR i,h,anzahl:CARDINAL;str,name,sichtbarkeit,Winkel,Rek_tiefe:string;
begin
  //CheckListBox1.clear;
  anzahl:=(HauptForm.o.turtleListe.Count)-1;
  for i:=0 to anzahl do               //aufpassen indexe
      begin
           Hauptform.o.gibTurtle(i,turtle);
           str:='Turtel'+inttostr(i);
           name:=turtle.name;   //Die weiteren Eigenschaften der Turtel hinzufügen: sichtbarkeit, Koordinaten??, Parameter, name
           if turtle.visible then sichtbarkeit:='Sichtbar'
           else sichtbarkeit:='Unsichtbar';
           Winkel:=floattostr(turtle.winkel);
           Rek_tiefe:=inttostr(turtle.rekursionsTiefe);
           CheckListBox1.AddItem(str,NIL);   //Aktuelle anzhal von Spalten 5
           //CheckListBox1.Items.Add(str ^I name ^I sichtbarkeit ^I Winkel ^I Rek_tiefe)
           //Problem
      end;
end;

procedure TForm10.BT_alle_unmarkierenClick(Sender: TObject);
VAR i:CARDINAL;
begin
  for i := 0 to CheckListBox1.Count-1 do CheckListBox1.Checked[i] := False;
end;

procedure TForm10.BT_AlleClick(Sender: TObject);
begin
    CheckListBox1.SelectAll;
end;

procedure TForm10.BT_bearbeitenClick(Sender: TObject);
VAR liste:TList;
begin
    //Parameterform aufrufen
    //liste:= gib_markierte_nr;
end;

procedure TForm10.BT_entfernenClick(Sender: TObject); //dringt testen
VAR i,a:CARDINAL;
begin
   a:=0;
   for i := 0 to CheckListBox1.Count -1 do
       begin
            if CheckListBox1.Checked[i] then
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
   for i := 0 to CheckListBox1.Count -1 do
       begin
            if CheckListBox1.Checked[i] then
            begin
                 Hauptform.o.setzeSichtbarkeit(i,true)
            end;
       end;
end;

procedure TForm10.BT_unsichtbar_machenClick(Sender: TObject);
VAR i:CARDINAL;
begin
   for i := 0 to CheckListBox1.Count -1 do
       begin
            if CheckListBox1.Checked[i] then
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
              hl.Insert(h,i)
              INC(h)
         end;
         end;
     result:=hl;
  end;    *)
end.


unit uParameterisierung_Form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ValEdit, StdCtrls;

type

  { TParameterisierung_Form }

  TParameterisierung_Form = class(TForm)
    BT_Fertig: TButton;
    BT_aktuallisieren: TButton;
    ValueListEditor1: TValueListEditor;
    procedure BT_aktuallisierenClick(Sender: TObject);
    procedure BT_FertigClick(Sender: TObject);
  private
    NR:CARDINAL;
  public
    procedure update_ed(nr:CARDINAL);
  end;

var
  Parameterisierung_Form: TParameterisierung_Form;

implementation
uses uForm,uTurtle,uTurtlemanager;

{$R *.lfm}


procedure TParameterisierung_Form.BT_FertigClick(Sender: TObject);
VAR stringliste:TStringlist;  i:CARDINAL; manager:TTurtlemanager;Turtle:TTurtle; value:String;
begin
   stringliste:=TStringlist.create();
   for i:=1 to ValueListEditor1.RowCount-1 do
   begin
        value:=ValueListEditor1.Values[inttostr(i)];
        stringliste.Add(value);
   end;
   manager:=Hauptform.o.copy();
   manager.gibTurtle(NR,turtle);
   turtle.aendereParameter(stringliste);
   Hauptform.push_neue_instanz(manager);
   Hauptform.zeichnen();
   Visible:=False;
end;

procedure TParameterisierung_Form.BT_aktuallisierenClick(Sender: TObject);
VAR stringliste:TStringlist;  i:CARDINAL; manager:TTurtlemanager;Turtle:TTurtle; value:String;
begin
   stringliste:=TStringlist.create();
   for i:=1 to ValueListEditor1.RowCount-1 do
   begin
        value:=ValueListEditor1.Values[inttostr(i)];
        stringliste.Add(value);
   end;
   manager:=Hauptform.o.copy();
   manager.gibTurtle(NR,turtle);
   turtle.aendereParameter(stringliste);
   Hauptform.push_neue_instanz(manager);
   Hauptform.zeichnen();
end;

procedure TParameterisierung_Form.update_ed(nr:CARDINAL);
VAR Turtle:TTurtle;stringliste:TStringlist;i:CARDINAL;value:String;
begin
  ValueListEditor1.clear;
  ValueListEditor1.Row := 0;
  NR:=nr;
  Hauptform.o.gibTurtle(nr,Turtle);
  stringliste:=Turtle.gibParameter();
  for i:=0 to stringliste.Count-1 do
  begin
    value:=stringliste[i];
    ValueListEditor1.InsertRow(inttostr(i+1),value,True);
  end;
end;

end.


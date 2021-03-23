unit uParameterisierung_Form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ValEdit;

type

  { TParameterisierung_Form }

  TParameterisierung_Form = class(TForm)
    ValueListEditor1: TValueListEditor;
    procedure ValueListEditor1EditingDone(Sender: TObject);
  private

  public
    procedure update_ed(nr:CARDINAL);
  end;

var
  Parameterisierung_Form: TParameterisierung_Form;

implementation
uses uForm,uTurtle,uTurtlemanager;

{$R *.lfm}

procedure TParameterisierung_Form.ValueListEditor1EditingDone(Sender: TObject);
VAR stringliste:TStringlist;  i:CARDINAL; manager:TTurtlemanager;
begin
   //on change push update
   //überprüfen ob valide
   stringliste:=TStringlist.create();
   for i:=0 to ValueListEditor1.RowCount-1 do
   begin
        stringliste.Add(ValueListEditor1.Values[inttostr(i)]);
   end;
   manager:=Hauptform.o.copy();
   Hauptform.push_neue_instanz(manager);
   Hauptform.zeichnen();
end;

procedure TParameterisierung_Form.update_ed(nr:CARDINAL);
VAR Turtle:TTurtle;stringliste:TStringlist;i:CARDINAL;value:String;
begin
   ValueListEditor1.clear;
   ValueListEditor1.Row := 0;
   Turtle:=Hauptform.o.turtleListe[nr];
   stringliste:=Turtle.gibParameter();
   for i:=0 to stringliste.Count-1 do
   begin
     value:=stringliste.Strings[i];
     ValueListEditor1.InsertRow(inttostr(i),value,True);
   end;

end;



end.


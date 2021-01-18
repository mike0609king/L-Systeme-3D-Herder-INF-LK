unit uparameter_form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus;

type

  { TParameter_Form }

  TParameter_Form = class(TForm)
    BT_Bestaetigen: TButton;
    ED_Winkel: TEdit;
    ED_Rek_tiefe: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure BT_BestaetigenClick(Sender: TObject);
    procedure ED_Rek_tiefeChange(Sender: TObject);
    procedure ED_WinkelChange(Sender: TObject);
  private

  public

  end;

var
  Parameter_Form: TParameter_Form;

implementation
uses uEditor_Grammatiken,uForm;

{$R *.lfm}

{ TParameter_Form }

procedure TParameter_Form.BT_BestaetigenClick(Sender: TObject);
begin
  ED_WinkelChange(self);
  ED_Rek_tiefeChange(self);
  Hauptform.zeichnen();

end;
//exceptions handeling
//werte überprüfen
procedure TParameter_Form.ED_WinkelChange(Sender: TObject);
VAR winkel:REAL;i:CARDINAL; str:string;
begin
  str:=ED_Winkel.Text;
  if not (str='') then
  begin
    winkel:=strtofloat(ED_Winkel.text);
    for i:=0 to EditorForm.ListView1.Items.Count-1 do
    begin
         if EditorForm.ListView1.Items[i].Checked then Hauptform.o.turtleListe[i].winkel:=winkel;
    end;
    Hauptform.zeichnen();
  end;
end;

procedure TParameter_Form.ED_Rek_tiefeChange(Sender: TObject);
VAR rek_tiefe,i:CARDINAL; str:string;
begin
  str:=ED_Rek_tiefe.Text;
  if not (str='') then
    begin
      rek_tiefe:=strtoint(ED_Rek_tiefe.text);
      for i:=0 to EditorForm.ListView1.Items.Count-1 do
      begin
           if EditorForm.ListView1.Items[i].Checked then Hauptform.o.turtleListe[i].rekursionsTiefe:=rek_tiefe;
      end;
      Hauptform.zeichnen();
    end;
end;
end.


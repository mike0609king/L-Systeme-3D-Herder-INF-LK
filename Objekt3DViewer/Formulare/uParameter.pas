unit uParameter;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,uTurtleManager;

type

  { TForm_Parameter }

  TForm_Parameter = class(TForm)
    BT_Bestaetigen: TButton;
    BT_update: TButton;
    ED_Winkel: TEdit;
    ED_Rek_tiefe: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure BT_BestaetigenClick(Sender: TObject);
    procedure BT_updateClick(Sender: TObject); //soll immer "klickt" werden wenn es gestartet wird.
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form_Parameter: TForm_Parameter;

implementation
uses uEditor_Grammatiken,uForm;
{$R *.lfm}

{ TForm_Parameter }



procedure TForm_Parameter.FormCreate(Sender: TObject);
begin

end;

procedure TForm_Parameter.BT_BestaetigenClick(Sender: TObject);
VAR Winkel:Real;Rekursionstiefe,i:CARDINAL;
begin
  //aus lesen der neuen Parameter
  Rekursionstiefe:=strtoint(ED_Rek_tiefe.Text);
  Winkel:=strtofloat(ED_Winkel.Text);
  //Überprüfen ob die Parameter sinvoll sind?

  //Übergeben der neuen Parameter.
  for i:=0 to (EditorForm.CheckListBox1.Count-1) do                     //lösung
      begin
           if EditorForm.CheckListBox1.Checked[i] then
           begin
             HauptForm.o.turtleListe[i].winkel:=Winkel;
             HauptForm.o.turtleListe[i].rekursionsTiefe:=Rekursionstiefe;
           end;
      end;
  //Form wieder unsichtbar machen.
  Visible:=False;
  //Hauptform.zeichnen;              //kopie zurück übergeben
end;

procedure TForm_Parameter.BT_updateClick(Sender: TObject);
begin
   //kopie übergeben?


end;


end.


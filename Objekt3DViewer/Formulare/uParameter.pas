unit uParameter;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus;

type

  { TTForm_Parameter }

  TTForm_Parameter = class(TForm)
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
    procedure BT_updateClick(Sender: TObject;Rekursionstiefe,Winkel:String); //soll immer "klickt" werden wenn es gestartet wird.
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  TForm_Parameter: TTForm_Parameter;

implementation

{$R *.lfm}

{ TForm_Parameter }



procedure TTForm_Parameter.FormCreate(Sender: TObject);
begin

end;

procedure TTForm_Parameter.BT_BestaetigenClick(Sender: TObject);
VAR Rekursionstiefe,Winkel:Real;
begin
  //aus lesen der neuen Parameter
  Rekursionstiefe:=strtoint(ED_Rek_tiefe.Text);
  Winkel:=strtoint(ED_Winkel.Text);
  //Überprüfen ob die Parameter sinvoll sind?
  //Übergeben der neuen Parameter.
  //Form wieder unsichtbar machen.
end;

procedure TTForm_Parameter.BT_updateClick(Sender: TObject;Rekursionstiefe,Winkel:String);
begin
  //Aktuelle Parameter einstellen.
  Label4.Caption:=Rekursionstiefe;
  Label5.Caption:=Winkel;

end;


end.


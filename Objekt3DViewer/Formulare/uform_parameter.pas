unit uForm_Parameter;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTForm_Parameter }

  TTForm_Parameter = class(TForm)
    BT_Bestaetigen: TButton;
    ED_Rek_tiefe: TEdit;
    Label1: TLabel;
    procedure BT_BestaetigenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  TForm_Parameter: TTForm_Parameter;

implementation

{$R *.lfm}

{ TTForm_Parameter }



procedure TTForm_Parameter.FormCreate(Sender: TObject);
begin
  //Aktuelle Parameter einstellen.
end;

procedure TTForm_Parameter.BT_BestaetigenClick(Sender: TObject);
begin
  //Übergeben der neuen Parameter.
end;

procedure TTForm_Parameter.Label1Click(Sender: TObject);
begin

end;


end.


unit uOptionen_form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTOptionen }

  TTOptionen = class(TForm)
    BT_fertig: TButton;
    BT_zuruecksetzen: TButton;
    ED_stringlaenge: TEdit;
    Label1: TLabel;
    procedure BT_fertigClick(Sender: TObject);
    procedure BT_zuruecksetzenClick(Sender: TObject);
  private

  public
    procedure update();
  end;

var
  Optionen_Form: TTOptionen;

implementation

{$R *.lfm}
uses uForm;

{ TTOptionen }

procedure TTOptionen.BT_fertigClick(Sender: TObject);
VAR maximaleStringLaenge:CARDINAL;
begin
  maximaleStringLaenge:=strtoint(ED_stringlaenge.text); //Aufpassen mit der Größe
  if  maximaleStringLaenge < 99999999 then
  begin

  end;

end;

procedure TTOptionen.BT_zuruecksetzenClick(Sender: TObject);
begin
   update();
end;
procedure TTOptionen.update();
begin
   ED_stringlaenge.text:=inttostr(Hauptform.maximaleStringLaenge);
end;


end.


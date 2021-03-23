unit uParameterisierung_Form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ValEdit;

type

  { TParameterisierung_Form }

  TParameterisierung_Form = class(TForm)
    ValueListEditor1: TValueListEditor;
  private

  public
    procedure update(nr:CARDINAL);
  end;

var
  Parameterisierung_Form: TParameterisierung_Form;

implementation

{$R *.lfm}

procedure TParameterisierung_Form.update(nr:CARDINAL);
begin

end;

end.


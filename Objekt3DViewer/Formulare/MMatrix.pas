unit MMatrix;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    M44: TEdit;
    M43: TEdit;
    M42: TEdit;
    M41: TEdit;
    M34: TEdit;
    M33: TEdit;
    M32: TEdit;
    M31: TEdit;
    M14: TEdit;
    M13: TEdit;
    M12: TEdit;
    M11: TEdit;
    M24: TEdit;
    M23: TEdit;
    M22: TEdit;
    M21: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMMatrix: TForm3;

implementation

{$R *.lfm}

{ TForm3 }


procedure TForm3.FormCreate(Sender: TObject);
begin
  left:=screen.width-width
end;

end.


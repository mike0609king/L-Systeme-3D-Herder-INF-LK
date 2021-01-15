unit Verschiebung;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm8 }

  TForm8 = class(TForm)
    BtEigenKOS: TButton;
    BtWeltKOS: TButton;
    EdVX: TEdit;
    EdVY: TEdit;
    EdVZ: TEdit;
    Label1: TLabel;
    procedure BtEigenKOSClick(Sender: TObject);
    procedure BtWeltKOSClick(Sender: TObject);
    procedure EdVXChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormVer: TForm8;

implementation
uses AMatrix;
{$R *.lfm}

{ TForm8 }

procedure TForm8.EdVXChange(Sender: TObject);
begin
  With FormAMatrix DO
  begin
    EdAinit;
    IF (EdVX.Text<>'') AND (EdVY.Text<>'') AND (EdVZ.Text<>'') THEN
    begin
      A[1,4].Text:=EdVX.Text;
      A[2,4].Text:=EdVY.Text;
      A[3,4].Text:=EdVZ.Text
    end;
  end;
end;

procedure TForm8.FormActivate(Sender: TObject);
begin
  EdVXChange(self);
  top:=screen.height-230
end;

procedure TForm8.FormCreate(Sender: TObject);
begin

end;

procedure TForm8.BtEigenKOSClick(Sender: TObject);
begin
  IF (EdVX.Text<>'') AND (EdVY.Text<>'') AND (EdVZ.Text<>'') THEN
  begin
    EdVXChange(self);
    FormAMatrix.BtMxAClick(self);
  end;
end;

procedure TForm8.BtWeltKOSClick(Sender: TObject);
begin
  IF (EdVX.Text<>'') AND (EdVY.Text<>'') AND (EdVZ.Text<>'') THEN
  begin
    EdVXChange(self);
    FormAMatrix.BtAxMClick(self)
  end;
end;

end.


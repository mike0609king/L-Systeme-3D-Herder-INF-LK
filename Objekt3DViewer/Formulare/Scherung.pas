unit Scherung;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm9 }

  TForm9 = class(TForm)
    BtEigenKOS: TButton;
    BtWeltKOS: TButton;
    EdScherungsF: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    procedure BtEigenKOSClick(Sender: TObject);
    procedure BtWeltKOSClick(Sender: TObject);
    procedure EdScherungsFChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1SelectionChanged(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormScher: TForm9;

implementation
uses AMatrix;
{$R *.lfm}

{ TForm9 }

procedure TForm9.FormCreate(Sender: TObject);
begin
end;

procedure TForm9.EdScherungsFChange(Sender: TObject);
begin
  RadioGroup1SelectionChanged(self)
end;

procedure TForm9.FormActivate(Sender: TObject);
begin
  RadioGroup1SelectionChanged(self);
  top:=screen.height-245
end;

procedure TForm9.BtEigenKOSClick(Sender: TObject);
begin
  IF EdScherungsF.Text<>'' THEN
  BEGIN
    RadioGroup1SelectionChanged(self);
    FormAMatrix.BtMxAClick(self)
  end;
end;

procedure TForm9.BtWeltKOSClick(Sender: TObject);
begin
  RadioGroup1SelectionChanged(self);
  FormAMatrix.BtAxmClick(self)
end;

procedure TForm9.RadioGroup1SelectionChanged(Sender: TObject);
begin
  With FormAMatrix DO
  begin
    EdAinit;
    IF EdScherungsF.Text<>'' THEN
    BEGIN
      Case RadioGroup1.ItemIndex OF
        0:A[1,3].Text:=EdScherungsF.Text;
        1:A[2,3].Text:=EdScherungsF.Text;
        2:A[1,2].Text:=EdScherungsF.Text;
        3:A[3,2].Text:=EdScherungsF.Text;
        4:A[2,1].Text:=EdScherungsF.Text;
        5:A[3,1].Text:=EdScherungsF.Text;
      end;
    end;
  end;
end;

end.


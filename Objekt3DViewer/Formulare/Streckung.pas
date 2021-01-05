unit Streckung;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioGroup1ChangeBounds(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormStreck: TForm7;

implementation
uses AMatrix;
{$R *.lfm}

{ TForm7 }



procedure TForm7.RadioGroup1ChangeBounds(Sender: TObject);
VAR x:Real; i:CARDINAL;
begin
  FormAMatrix.EdAinit;
  Case RadioGroup1.ItemIndex OF
    0..2: begin
           FOR i:=1 to 3 do
           IF (i-1)<>RadioGroup1.ItemIndex then FormAMatrix.A[i,i].Text:='1'
           else FormAMatrix.A[i,i].Text:=(Edit1.Text)
          end;
    3: begin For i:=1 TO 3 DO FormAMatrix.A[i,i].Text:= Edit1.Text end;
  end;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  RadioGroup1ChangeBounds(self);
  FormAMatrix.BtMxAClick(self)
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  RadioGroup1ChangeBounds(self);
  FormAMatrix.BtAxMClick(self)
end;

procedure TForm7.FormActivate(Sender: TObject);
begin
  top:=screen.height-210
end;

procedure TForm7.RadioGroup1Click(Sender: TObject);
begin

end;

end.


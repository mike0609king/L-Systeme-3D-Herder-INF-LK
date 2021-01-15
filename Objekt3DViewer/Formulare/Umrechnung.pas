unit Umrechnung;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    BtUmrechnen: TButton;
    EdX: TEdit;
    EdY: TEdit;
    EdZ: TEdit;
    EdR: TEdit;
    EdPhi: TEdit;
    EdTheta: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    procedure BtUmrechnenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure kartToKugel;
    { private declarations }
  public
    { public declarations }
  end;

var
  FormKart2Kugel: TForm5;

implementation
uses Math;
{$R *.lfm}

procedure TForm5.BtUmrechnenClick(Sender: TObject);
begin
  kartToKugel;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  left:=screen.width-width
end;

procedure TForm5.kartToKugel;
VAR x,y,z,r,phi,theta:Real;
begin
   x:=StrToFloat(EdX.Text);
   y:=StrToFloat(EdY.Text);
   z:=StrToFloat(EdZ.Text);
   r:=(sqrt(sqr(x)+sqr(y)+sqr(z)));
   EdR.Text:=FloatToStr(r);
   phi:=arctan2(y,x);
   EdPhi.Text:=FloatToStr(phi/pi*180);
   theta:=arctan2(sqrt(sqr(x)+sqr(y)),z);
   EdTheta.Text:=FloatToStr(theta/pi*180);
end;

end.


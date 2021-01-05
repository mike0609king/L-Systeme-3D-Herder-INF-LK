unit Umrechnung2;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    BtUmrechnen: TButton;
    EdY: TEdit;
    EdX: TEdit;
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
    procedure KugelToKart;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormKugel2Kart: TForm6;

implementation

{$R *.lfm}

{ TForm6 }
procedure TForm6.KugelToKart;
VAR x,y,z,r,phi,theta,r1:Real;
begin
   r:=StrToFloat(EdR.Text);
   phi:=StrToFloat(EdPhi.Text)/180*pi;
   theta:=StrToFloat(EdTheta.Text)/180*pi;
   z:=r*cos(theta);
   r1:=r*sin(theta);
   x:=r1*cos(phi);
   y:=r1*sin(phi);
   EdX.Text:=FloatToStr(x);
   EdY.Text:=FloatToStr(y);
   EdZ.Text:=FloatToStr(z);
end;

procedure TForm6.BtUmrechnenClick(Sender: TObject);
begin
  KugelToKart;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  left:=screen.width-width
end;

end.


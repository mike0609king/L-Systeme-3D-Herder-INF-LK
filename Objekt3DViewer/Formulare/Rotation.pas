unit Rotation;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    BtAction: TButton;
    EdWinkel: TEdit;
    Label22: TLabel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    procedure BtXRotClick(Sender: TObject);
    procedure BtYRotClick(Sender: TObject);
    procedure BtZRotClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtActionClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EdWinkelChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1SelectionChanged(Sender: TObject);
    procedure RadioGroup2SelectionChanged(Sender: TObject);
private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormRot: TForm4;

implementation
uses AMatrix,uMatrizen,dglOpenGL;
{$R *.lfm}

procedure TForm4.BtXRotClick(Sender: TObject);
VAR phi:Real;
begin
  phi:=StrToFloat(EdWinkel.Text)/180*pi;
  FormAMatrix.EdAInit;
  With FormAMatrix DO
  BEGIN
    A[2,2].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
    A[3,2].text:=FloatToStrF(sin(phi),ffGeneral,3,4);
    A[2,3].text:=FloatToStrF(-sin(phi),ffGeneral,3,4);
    A[3,3].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
  end;
end;

procedure TForm4.BtYRotClick(Sender: TObject);
VAR phi:Real;
begin
  phi:=StrToFloat(EdWinkel.Text)/180*pi;
  FormAMatrix.EdAInit;
  With FormAMatrix DO
  begin
    A[1,1].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
    A[3,1].text:=FloatToStrF(-sin(phi),ffGeneral,3,4);
    A[1,3].text:=FloatToStrF(sin(phi),ffGeneral,3,4);
    A[3,3].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
  end;
end;

procedure TForm4.BtZRotClick(Sender: TObject);
VAR phi:Real;
begin
   phi:=StrToFloat(EdWinkel.Text)/180*pi;
   With FormAMatrix DO
   BEGIN
     EdAInit;
     A[1,1].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
     A[2,1].text:=FloatToStrF(sin(phi),ffGeneral,3,4);
     A[1,2].text:=FloatToStrF(-sin(phi),ffGeneral,3,4);
     A[2,2].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
   end;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
   FormAMatrix.BtAxMClick(self);
end;

procedure TForm4.BtActionClick(Sender: TObject);
begin
  If EdWinkel.Text<>'' THEN
  begin
    EdWinkelChange(self);
    IF RadioGroup2.ItemIndex=0 THEN FormAMatrix.BtMxAClick(self)
    ELSE FormAMatrix.BtAxMClick(self);
  end;
end;

procedure TForm4.Button3Click(Sender: TObject);
VAR temp:MatrixPaar;
begin
  With OMatrix DO
  ObjUmWeltKOSDrehen(StrToFloat(EdWinkel.Text),
                        o[Mat_Pos].x,o[Mat_Pos].y,o[Mat_Pos].z,
                        o[Mat_Z].x,o[Mat_z].y,o[Mat_Z].z)
end;

procedure TForm4.EdWinkelChange(Sender: TObject);
VAR temp:MatrixPaar;
VAR phi:Real;
begin
  If EdWinkel.Text<>'' THEN
  Begin
    IF RadioGroup2.ItemIndex<>2 THEN
    begin
      Case RadioGroup1.ItemIndex OF
         0: BtXRotClick(self);
         1: BtYRotClick(self);
         2: BtZRotClick(self);
      end;
    end
    else
    begin
      phi:=StrToFloat(EdWinkel.Text);///180*pi;
      glMatrixMode(GL_ModelView);
      glLoadIdentity;
     //glMultMatrixf(@OMatrix.o);
      WITH OMatrix.o[Mat_Pos] DO glTranslatef(x,y,z);
      CASE RadioGroup1.ItemIndex OF
        0: With OMatrix.o[Mat_X] DO glRotatef(phi,x,y,z);
        1: With OMatrix.o[Mat_Y] DO glRotatef(phi,x,y,z);
        2: With OMatrix.o[Mat_Z] DO glRotatef(phi,x,y,z);
      END;
      With OMatrix.o[Mat_Pos] DO glTranslatef(-x,-y,-z);
      glGetFloatv(GL_MODELVIEW_MATRIX,@temp.o);
      FormAMatrix.EdFelderBesetzen(FormAMatrix.A,temp)
    end;
  end;
end;

procedure TForm4.FormActivate(Sender: TObject);
VAR phi:Real;
begin
   phi:=StrToFloat(EdWinkel.Text)/180*pi;
   With FormAMatrix DO
   BEGIN
     EdAInit;
     A[1,1].text:=FloatToStrF(cos(phi),ffGeneral,3,4);
     A[2,1].text:=FloatToStrf(sin(phi),ffGeneral,3,4);
     A[1,2].text:=FloatToStrf(-sin(phi),ffGeneral,3,4);
     A[2,2].text:=FloatToStrf(cos(phi),ffGeneral,3,4);
   end;
   top:=screen.height-210
end;

procedure TForm4.FormCreate(Sender: TObject);
begin

end;

procedure TForm4.RadioGroup1SelectionChanged(Sender: TObject);
begin
  EdWinkelChange(self)
end;

procedure TForm4.RadioGroup2SelectionChanged(Sender: TObject);
begin
  EdWinkelChange(self)
end;


end.



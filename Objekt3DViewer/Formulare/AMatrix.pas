unit AMatrix;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, uMatrizen;

type
  EditArray=Array [1..4,1..4] OF TEdit;
  { TForm2 }

  TForm2 = class(TForm)
    BtAxM: TButton;
    BtMxA: TButton;
    A11: TEdit;
    A14: TEdit;
    A12: TEdit;
    A24: TEdit;
    A34: TEdit;
    A41: TEdit;
    A42: TEdit;
    A43: TEdit;
    A44: TEdit;
    A13: TEdit;
    A21: TEdit;
    A22: TEdit;
    A23: TEdit;
    A31: TEdit;
    A32: TEdit;
    A33: TEdit;
    BtZurueck: TButton;
    BtInit: TButton;
    BtMAnAus: TButton;
    procedure BtAxMClick(Sender: TObject);
    procedure Azxsinit(z,s:CARDINAL);
    procedure BtMAnAusClick(Sender: TObject);
    procedure BtMxAClick(Sender: TObject);
    procedure BtZurueckClick(Sender: TObject);
    procedure BtInitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Schritt_zurueck;
    procedure EdAinit;
  private
    MatrizenAnzahl:CARDINAL;
    procedure templesen;
    { private declarations }
  public
    { public declarations }
    A,M:EditArray;
    procedure EdFelderBesetzen(E:EditArray;Matrix:Matrixpaar);
  end;

var
  FormAMatrix: TForm2;

implementation
uses dglOpenGL, MMatrix;
VAR temp:MatrixPaar;
{$R *.lfm}

{ TForm2 }
procedure TForm2.EdAinit;
VAR i,j:CARDINAL;
BEGIN
   For i:=1 to 4 DO
      FOR j:=1 to 4 DO IF i=j THEN A[i,j].Text:='1' ELSE A[i,j].text:='0'
end;

procedure TForm2.EdFelderBesetzen(E:EditArray;Matrix:Matrixpaar);
begin
   E[1,1].Text:=FloatToStrF(Matrix.o[Mat_x].x,ffGeneral,3,4);
   E[2,1].Text:=FloatToStrF(Matrix.o[Mat_x].y,ffGeneral,3,4);
   E[3,1].Text:=FloatToStrF(Matrix.o[Mat_x].z,ffGeneral,3,4);
   E[4,1].Text:=FloatToStrF(Matrix.o[Mat_x].w,ffGeneral,3,4);
   E[1,2].Text:=FloatToStrF(Matrix.o[Mat_y].x,ffGeneral,3,4);
   E[2,2].Text:=FloatToStrF(Matrix.o[Mat_y].y,ffGeneral,3,4);
   E[3,2].Text:=FloatToStrF(Matrix.o[Mat_y].z,ffGeneral,3,4);
   E[4,2].Text:=FloatToStrF(Matrix.o[Mat_y].w,ffGeneral,3,4);
   E[1,3].Text:=FloatToStrF(Matrix.o[Mat_z].x,ffGeneral,3,4);
   E[2,3].Text:=FloatToStrF(Matrix.o[Mat_z].y,ffGeneral,3,4);
   E[3,3].Text:=FloatToStrF(Matrix.o[Mat_z].z,ffGeneral,3,4);
   E[4,3].Text:=FloatToStrF(Matrix.o[Mat_z].w,ffGeneral,3,4);
   E[1,4].Text:=FloatToStrF(Matrix.o[Mat_pos].x,ffGeneral,3,4);
   E[2,4].Text:=FloatToStrF(Matrix.o[Mat_pos].y,ffGeneral,3,4);
   E[3,4].Text:=FloatToStrF(Matrix.o[Mat_pos].z,ffGeneral,3,4);
   E[4,4].Text:=FloatToStrF(Matrix.o[Mat_pos].w,ffGeneral,3,4);
end;

procedure TForm2.tempLesen;
VAR Spalte:TMatrixSpalten;
    Zeile:CARDINAL;
begin
   FOR Spalte:=Mat_x TO Mat_Pos DO
   BEGIN
      temp.o[Spalte].x:=StrToFloat(A[Ord(Spalte)+1,1].text);
      temp.o[Spalte].y:=StrtoFloat(A[Ord(Spalte)+1,2].text);
      temp.o[Spalte].z:=StrtoFloat(A[Ord(Spalte)+1,3].text);
      temp.o[Spalte].w:=StrtoFloat(A[Ord(Spalte)+1,4].text);
   end;
   {temp.o[Mat_x].x:=StrToFloat(A[1,1].text);
   temp.o[Mat_x].y:=StrToFloat(A[2,1].text);
   temp.o[Mat_x].z:=StrToFloat(A[3,1].text);
   temp.o[Mat_x].w:=StrToFloat(A[4,1].text);

   temp.o[Mat_y].x:=StrToFloat(A[1,2].text);
   temp.o[Mat_y].y:=StrToFloat(A[2,2].text);
   temp.o[Mat_y].z:=StrToFloat(A[3,2].text);
   temp.o[Mat_y].w:=StrToFloat(A[4,2].text);
   temp.o[Mat_z].x:=StrToFloat(A[1,3].text);
   temp.o[Mat_z].y:=StrToFloat(A[2,3].text);
   temp.o[Mat_z].z:=StrToFloat(A[3,3].text);
   temp.o[Mat_z].w:=StrToFloat(A[4,3].text);
   temp.o[Mat_pos].x:=StrToFloat(A[1,4].text);
   temp.o[Mat_pos].y:=StrToFloat(A[2,4].text);
   temp.o[Mat_pos].z:=StrToFloat(A[3,4].text);
   temp.o[Mat_pos].w:=StrToFloat(A[4,4].text); }
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  A[1,1]:=A11; A[1,2]:=A12; A[1,3]:=A13; A[1,4]:=A14;
  A[2,1]:=A21; A[2,2]:=A22; A[2,3]:=A23; A[2,4]:=A24;
  A[3,1]:=A31; A[3,2]:=A32; A[3,3]:=A33; A[3,4]:=A34;
  A[4,1]:=A41; A[4,2]:=A42; A[4,3]:=A43; A[4,4]:=A44;
  With FormMMatrix DO
  BEGIN
     M[1,1]:=M11; M[1,2]:=M12; M[1,3]:=M13; M[1,4]:=M14;
     M[2,1]:=M21; M[2,2]:=M22; M[2,3]:=M23; M[2,4]:=M24;
     M[3,1]:=M31; M[3,2]:=M32; M[3,3]:=M33; M[3,4]:=M34;
     M[4,1]:=M41; M[4,2]:=M42; M[4,3]:=M43; M[4,4]:=M44;
  end;
  glMatrixMode(GL_ModelView);
  //glPushMatrix;
  glLoadIdentity;
  glGetFloatv(GL_MODELVIEW_MATRIX,@temp.o);
  glPushMatrix;
  //glLoadIdentity;
  glGetFloatv(GL_MODELVIEW_MATRIX,@oMatrix.o);
  glPushMatrix;
  MatrizenAnzahl:=1;
  EdFelderBesetzen(A,temp);
  EdFelderBesetzen(M,oMatrix);
  left:=screen.Width-width;
end;

procedure TForm2.BtAxMClick(Sender: TObject);
begin
   tempLesen;
   //ObjKOSinitialisieren;  //muss bei Matrixmultiplikation auskommentiert werden
   glMatrixMode(GL_ModelView);
   glLoadMatrixf(@temp.o);
   glPushMatrix;
   glLoadMatrixf(@OMatrix.o);
   glPushMatrix;
   glLoadMatrixf(@temp.o);
   glMultMatrixf(@OMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   EdAinit;
   EdFelderBesetzen(M,oMatrix);
   INC (MatrizenAnzahl);
   //Form3.EdMFelderBesetzen;
   //ObjKOSInitialisieren;
end;

procedure TForm2.Azxsinit(z,s:CARDINAL);
VAR i,j:CARDINAL;
begin
   For i:=1 to 4 DO
      FOR j:=1 to 4 DO
         If (i>z) or (j>s) THEN
         Begin
            A[i,j].Visible:=FALSE; M[i,j].Visible:=FALSE
         END
         ELSE
         Begin
            A[i,j].Visible:=TRUE; M[i,j].Visible:=TRUE
         END;
   IF (z=2) AND (s=3) THEN
   BEGIN
     For i:=1 to 2 DO For j:=3 TO 4 DO
     Begin
        A[i,j].Visible:=NOT A[i,j].Visible;
        M[i,j].Visible:=NOT M[i,j].Visible
     end;
   end;
end;

procedure TForm2.BtMAnAusClick(Sender: TObject);
begin
   FormMMatrix.Visible:=Not FormMMatrix.Visible
end;

procedure TForm2.BtMxAClick(Sender: TObject);
begin
   templesen;
   glMatrixMode (GL_ModelView_Matrix);
   //glLoadIdentity;
   glLoadMatrixf(@temp.o);
   glPushMatrix;
   glLoadMatrixf(@OMatrix.o);
   glPushMatrix;
   glMultMatrixf(@temp.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   EdAinit;
   EdFelderBesetzen(M,oMatrix);
   //Button20.click
   INC(MatrizenAnzahl);



end;

procedure TForm2.BtZurueckClick(Sender: TObject);
begin
  Schritt_zurueck;
end;

procedure TForm2.BtInitClick(Sender: TObject);
begin
  ObjKOSinitialisieren;
   //EdAFelderBesetzen;  //muss bei Matrixmultiplikation auskommentiert werden
   glMatrixMode(GL_ModelView);
   WHILE MatrizenAnzahl>1 DO
   begin
      glPopMatrix;
      glPopMatrix;
      DEC(MatrizenAnzahl)
   END;
   EdAinit;
   EdFelderBesetzen(M,OMatrix)
end;

Procedure TForm2.Schritt_zurueck;
begin
   IF MatrizenAnzahl>0 THEN
   BEGIN
      glMatrixMode(GL_MODELVIEW_MATRIX);
      glPopMatrix;
      glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
      EdFelderBesetzen(M,oMatrix);
      glPopMatrix;
      glGetFloatv(GL_MODELVIEW_MATRIX,@temp.o);
      EdFelderBesetzen(A,temp);
      DEC(MatrizenAnzahl)
   end
   else
   begin
      glMatrixMode(GL_MODELVIEW_MATRIX);
      glLoadIdentity;
      glGetFloatv(GL_Modelview_Matrix,@temp.o);
      glGetFloatv(GL_Modelview_Matrix,@OMatrix.o);
      //EdMFelderBesetzen ;
      EdFelderBesetzen(A,temp);
      EdFelderBesetzen(M,OMatrix)
   end;
end;

end.


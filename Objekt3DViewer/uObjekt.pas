unit uObjekt;

{$mode delphi}

interface

uses
  Classes, SysUtils;

TYPE TObjekte = (kw,gw,p,kq,gq,d);
TYPE TObjekt = class
    procedure zeichnen;
end;

VAR ts,ersetzung:String;
    phi:REAL;
VAR objekt:TObjekte;

//procedure
//procedure init (sx,sy,sz,bx,by,bz:Real);
//procedure Schritt (l:Real;Spur:BOOLEAN);
//procedure X_Rot (a:Real);
//procedure Y_Rot (a:Real);
//procedure Z_Rot (a:Real);
//procedure kehrt;
//procedure Push;
//procedure Pop;

implementation

uses uMatrizen,dglOpenGL;

procedure init (sx,sy,sz,bx,by,bz:Real);
begin
  glMatrixMode(GL_ModelView);
  glClearColor (0,0,0,0);
  ObjKOSInitialisieren;
  ObjInEigenKOSVerschieben(sx,sy,sz);
end;

procedure Schritt (l:Real;Spur:BOOLEAN);
begin
  IF Spur Then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(1,1,1);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure X_Rot (a:Real);
begin
  ObjUmEigenKOSDrehen(a,0,0,0,1,0,0);
end;

procedure Y_Rot (a:Real);
begin
  ObjUmEigenKOSDrehen (a,0,0,0,0,1,0)
end;

procedure Z_Rot (a:Real);
begin
  ObjUmEigenKOSDrehen (a,0,0,0,0,0,1)
end;

procedure kehrt;
begin
  ObjUmEigenKOSDrehen (180,0,0,0,0,0,1)
end;

procedure Push;
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glLoadMatrixf(@OMatrix.o);
  glPushMatrix;
end;

procedure Pop;
begin
  glMatrixMode(GL_MODELVIEW_MATRIX);
  glPopMatrix;
  glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
end;

procedure Blatt (l:Real;Spur:BOOLEAN);
begin
  IF Spur Then
  begin
    glMatrixMode(GL_ModelView);
    UebergangsmatrixObjekt_Kamera_Laden;
    glColor3f(0,1,0);
    glBegin(GL_LINES);
       glVertex3f(0,0,0);glVertex3f(0,l,0);
    glEnd;
  end;
  ObjInEigenKOSVerschieben(0,l,0)
end;

procedure TObjekt.zeichnen;
VAR hs:String;
   procedure rekErsetzung (m,n:CARDINAL;s:String);
   begin
      WHILE s<>'' DO
      begin
        CASE s[1] of
          'F':IF n=0 THEN schritt (1/m,TRUE)
              ELSE
              BEGIN
                 //delete (hs,1,1);
                 //Push;
                 rekErsetzung(m,n-1,ersetzung);
                 //Pop
              end;
          'f':schritt (1/m,FALSE);
          '+':Z_Rot (phi);
          '-':Z_Rot (-phi);
          '&':Y_Rot (phi);
          '^':Y_Rot (-phi);
          '/':X_Rot (phi);
          '\':X_Rot (-phi);
          '[':Push;
          ']':Pop;
          'B':Blatt(1/m,True);
        end;
        delete (s,1,1);
      end;
   end;
begin
  init (0,0,0,0,0,0);
  hs:=ts;
  rekErsetzung (20,4,hs);
end;
begin
  ts:='F';
  ersetzung:='F&[+F&&FB]&&F[-^^/^-FB]F';
  phi:=47.5
end.


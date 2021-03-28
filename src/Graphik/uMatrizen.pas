unit uMatrizen;

{$MODE Delphi}

interface
uses dglOpenGL, math;

Type TPunkt = record x,y,z:Real END;
Type TVektor= TPunkt; //als Ortsvektor interpretiert;
TYPE THVektor = record x,y,z,w: glFloat END;
TYPE TMatrixSpalten= (mat_X,mat_Y,mat_Z,mat_Pos);
TYPE TMatrix = array[TMatrixSpalten] of THVektor;
TYPE MatrixPaar=record o,i:TMatrix END;

VAR OMatrix,KMatrix:MatrixPaar;

PROCEDURE KOSInitialisieren;
//KameraKOS und ObjektKOS stimmt mit WeltKOS überein.
//Die Projektionsfläche der Kamera ist geleert (alle Pixel sind gelöscht).
procedure KamKOSInitialisieren;
//KameraKOS stimmt mit WeltKOS überein.
//Die Projektionsfläche der Kamera ist geleert (alle Pixel sind gelöscht).
procedure ObjKOSInitialisieren;
//ObjektKOS stimmt mit WeltKOS überein.
procedure UebergangsmatrixObjekt_Welt_laden;
procedure UebergangsmatrixWelt_Objekt_laden;
procedure UebergangsmatrixObjekt_Kamera_laden;
procedure UebergangsmatrixWelt_Kamera_laden;
procedure UebergangsmatrixKamera_Welt_laden;
procedure ObjUmEigenKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real); overload;
procedure ObjUmEigenKOSDrehen(grad:Real;p:TPunkt;d:TVektor); overload;
procedure ObjUmWeltKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real); overload;
procedure ObjUmWeltKOSDrehen(grad:Real;p:TPunkt;d:TVektor); overload;
procedure KamUmEigenKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real); overload;
procedure KamUmEigenKOSDrehen(grad:Real;p:TPunkt;d:TVektor); overload;
procedure KamUmWeltKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real); overload;
procedure KamUmWeltKOSDrehen(grad:Real;p:TPunkt;d:TVektor); overload;
//d-Richtungsvektor der Drehachse, welche durch p verläuft.
procedure ObjInEigenKOSVerschieben(vx,vy,vz:Real); overload;
procedure ObjInEigenKOSVerschieben(v:TVektor); overload;
procedure ObjInWeltKOSVerschieben(vx,vy,vz:Real); overload;
procedure ObjInWeltKOSVerschieben(v:TVektor); overload;
procedure KamInEigenKOSVerschieben(vx,vy,vz:REAL); overload;
procedure KamInEigenKOSVerschieben(v:TVektor); overload;
//v-Verschiebungsvektor des Weltkoordinatensystems
procedure ObjInEigenKOSSkalieren(px,py,pz,sx,sy,sz:REAL); overload;
procedure ObjInEigenKOSSkalieren(p:TPunkt;sx,sy,sz:REAL); overload;
procedure ObjInEigenKOSSkalieren(p:TPunkt;s:Real); overload;
procedure ObjInWeltKOSSkalieren(px,py,pz,sx,sy,sz:Real); overload;
procedure ObjInWeltKOSSkalieren(p:TPunkt;sx,sy,sz:Real); overload;
procedure ObjInWeltKOSSkalieren(p:TPunkt;s:Real); overload;
//p-Punkt des Weltkoordinatensystems, an dem mit s gestaucht/gestreckt wird.

procedure UmrechnenObjPunktInWeltPunkt(OP:TPunkt;VAR WP:TPunkt);
procedure UmrechnenWeltPunktInObjPunkt(WP:TPunkt;VAR OP:TPunkt);
procedure UmrechnenKamPunktInWeltPunkt(KP:TPunkt;VAR WP:TPunkt);
procedure UmrechnenWeltPunktInKamPunkt(WP:TPunkt;VAR KP:TPunkt);
procedure UmrechnenObjPunktInKamPunkt (OP:TPunkt;VAR KP:TPunkt);
procedure UmrechnenKamPunktInObjPunkt (KP:TPunkt;VAR OP:TPunkt);
procedure UmrechnenObjVektorInWeltVektor(OV:TVektor;VAR WV:TVektor);
procedure UmrechnenWeltVektorInObjVektor(WV:TVektor;VAR OV:TVektor);
procedure UmrechnenKamVektorInWeltVektor(KV:TVektor;VAR WV:TVektor);
procedure UmrechnenWeltVektorInKamVektor(WV:TVektor;VAR KV:TVektor);
procedure UmrechnenObjVektorInKamVektor(OV:TVektor;VAR KV:TVektor);
procedure UmrechnenKamVektorInObjVektor(KV:TVektor;VAR OV:TVektor);
procedure UmrechnenKartKoordInPolarKoord(V:TVektor;VAR r,phi,theta:Real);
//phi und theta in Grad
procedure UmrechnenPolarKoordInKartKoord(r,phi,theta:Real;Var V:TVektor);
procedure Kreuzprodukt (v1,v2:TVektor;VAR ve:TVektor);
function  Skalarprodukt (v1,v2:TVektor):Real;
function  VektorBetrag (v:TVektor):Real;
function  WinkelZwischenVektoren (v1,v2:TVektor):Real;

implementation

//OMatrix.o beschreibt die Lage eines Objektpunktes im WeltKOS.
//OMatrix.i beschreibt die Lage eines Weltpunktes im ObjektKOS.
//KMatrix.0 beschreibt die Lage eines Kamerapunktes im WeltKOS.
//KMatrix.i      "      "   "     "   Weltpunktes im KameraKOS.
function Skalarprodukt(v1,v2:TVektor):Real;
begin
  result:=v1.x*v2.x+v1.y*v2.y+v1.z*v2.z
end;

function VektorBetrag (v:TVektor):Real;
begin
  result:=sqrt(Skalarprodukt(v,v))
end;

function WinkelZwischenVektoren(v1,v2:Tvektor):Real;
begin
  result:=arccos(Skalarprodukt(v1,v2)/(Vektorbetrag(v1)*Vektorbetrag(v2)))
end;

procedure KreuzProdukt(v1,v2:TVektor;VAR ve:TVektor);
begin
  ve.x:=v1.y*v2.z-v1.z*v2.y;
  ve.y:=v1.z*v2.x-v1.x*v2.z;
  ve.z:=v1.x*v2.y-v1.y*v2.x;
end;

   procedure Matrix_Vektor_Produkt (m:TMatrix;v:THVektor;VAR erg:THVektor);
   begin
      erg.x:=m[mat_X].x*v.x+m[mat_Y].x*v.y+m[mat_Z].x*v.z+m[mat_Pos].x*v.w;
      erg.y:=m[mat_X].y*v.x+m[mat_Y].y*v.y+m[mat_Z].y*v.z+m[mat_Pos].y*v.w;
      erg.z:=m[mat_X].z*v.x+m[mat_Y].z*v.y+m[mat_Z].z*v.z+m[mat_Pos].z*v.w;
      erg.w:=m[mat_X].w*v.x+m[mat_Y].w*v.y+m[mat_Z].w*v.z+m[mat_Pos].w*v.w;
   end;

procedure UmrechnenKartKoordInPolarKoord(V:TVektor;VAR r,phi,theta:Real);
begin
   r:=sqrt(sqr(V.x)+sqr(V.y)+sqr(V.z));
   phi:=arctan2(V.y,V.x)/pi*180;
   theta:=arctan2(V.z,sqrt(sqr(V.x)+sqr(V.y)))/pi*180;
end;

procedure UmrechnenPolarKoordInKartKoord(r,phi,theta:Real;Var V:TVektor);
Var rxy:Real;
begin
   V.z:=r*cos(theta/180*pi);
   rxy:=r*sin(theta/180*pi);
   V.x:=rxy*sin(phi/180*pi);
   V.z:=rxy*cos(phi/180*pi);
end;

procedure UmrechnenObjPunktInWeltPunkt(OP:TPunkt;VAR WP:TPunkt);
var v,ergv:THVektor;
begin
       v.x:=OP.x; v.y:=OP.y; v.z:=OP.z; v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.o,v,ergv);
       WP.x:=ergv.x; WP.y:=ergv.y; WP.z:=ergv.z;
end;
procedure UmrechnenWeltPunktInObjPunkt(WP:TPunkt;VAR OP:TPunkt);
var v,ergv:THVektor;
begin
       v.x:=WP.x; v.y:=WP.y; v.z:=WP.z; v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.i,v,ergv);
       OP.x:=ergv.x; OP.y:=ergv.y; OP.z:=ergv.z;
end;
procedure UmrechnenKamPunktInWeltPunkt(KP:TPunkt;VAR WP:TPunkt);
var v,ergv:THVektor;
begin
       v.x:=KP.x; v.y:=KP.y; v.z:=KP.z; v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.o,v,ergv);
       WP.x:=ergv.x; WP.y:=ergv.y; WP.z:=ergv.z;
end;
procedure UmrechnenWeltPunktInKamPunkt(WP:TPunkt;VAR KP:TPunkt);
var v,ergv:THVektor;
begin
       v.x:=WP.x; v.y:=WP.y; v.z:=WP.z; v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.i,v,ergv);
       KP.x:=ergv.x; KP.y:=ergv.y; KP.z:=ergv.z;
end;
procedure UmrechnenObjPunktInKamPunkt (OP:TPunkt;VAR KP:TPunkt);
var v,ev,ergv:THVektor;
begin
       v.x:=OP.x; v.y:=OP.y; v.z:=OP.z; v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.o,v,ev);
       Matrix_Vektor_Produkt (KMatrix.i,ev,ergv);
       KP.x:=ergv.x; KP.y:=ergv.y; KP.z:=ergv.z;
end;
procedure UmrechnenKamPunktInObjPunkt (KP:TPunkt;VAR OP:TPunkt);
var v,ev,ergv:THVektor;
begin
       v.x:=KP.x; v.y:=KP.y; v.z:=KP.z; v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.o,v,ev);
       Matrix_Vektor_Produkt (OMatrix.i,ev,ergv);
       OP.x:=ergv.x; OP.y:=ergv.y; OP.z:=ergv.z;
end;

procedure UmrechnenObjVektorInWeltVektor(OV:TVektor;VAR WV:TVektor);
var v,ev,ergv:THVektor;
begin
       v.x:=OV.x; v.y:=OV.y; v.z:=OV.z; v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.o,v,ev);
       v.x:=0;v.y:=0;v.z:=0;v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.o,v,ergv);
       WV.x:=ev.x-ergv.x; WV.y:=ev.y-ergv.y; WV.z:=ev.z-ergv.z;
end;
procedure UmrechnenWeltVektorInObjVektor(WV:TVektor;VAR OV:TVektor);
var v,ev,ergv:THVektor;
begin
       v.x:=WV.x; v.y:=WV.y; v.z:=WV.z; v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.i,v,ev);
       v.x:=0;v.y:=0;v.z:=0;v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.i,v,ergv);
       OV.x:=ev.x-ergv.x; OV.y:=ev.y-ergv.y; OV.z:=ev.z-ergv.z;
end;
procedure UmrechnenKamVektorInWeltVektor(KV:TVektor;VAR WV:TVektor);
var v,ev,ergv:THVektor;
begin
       v.x:=KV.x; v.y:=KV.y; v.z:=KV.z; v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.o,v,ev);
       v.x:=0;v.y:=0;v.z:=0;v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.o,v,ergv);
       WV.x:=ev.x-ergv.x; WV.y:=ev.y-ergv.y; WV.z:=ev.z-ergv.z;
end;
procedure UmrechnenWeltVektorInKamVektor(WV:TVektor;VAR KV:TVektor);
var v,ev,ergv:THVektor;
begin
       v.x:=WV.x; v.y:=WV.y; v.z:=WV.z; v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.i,v,ev);
       v.x:=0;v.y:=0;v.z:=0;v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.i,v,ergv);
       KV.x:=ev.x-ergv.x; KV.y:=ev.y-ergv.y; KV.z:=ev.z-ergv.z;
end;
procedure UmrechnenObjVektorInKamVektor(OV:TVektor;VAR KV:TVektor);
var v,ev,ergv1,ergv2:THVektor;
begin
       v.x:=OV.x; v.y:=OV.y; v.z:=OV.z; v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.o,v,ev);
       Matrix_Vektor_Produkt (KMatrix.i,ev,ergv1);
       v.x:=0;v.y:=0;v.z:=0;v.w:=1;
       Matrix_Vektor_Produkt (OMatrix.O,v,ev);
       Matrix_Vektor_Produkt (KMatrix.i,ev,ergv2);
       KV.x:=ergv1.x-ergv2.x; KV.y:=ergv1.y-ergv2.y; KV.z:=ergv1.z-ergv2.z;
end;
procedure UmrechnenKamVektorInObjVektor(KV:TVektor;VAR OV:TVektor);
var v,ev,ergv1,ergv2:THVektor;
begin
       v.x:=KV.x; v.y:=KV.y; v.z:=KV.z; v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.o,v,ev);
       Matrix_Vektor_Produkt (OMatrix.i,ev,ergv1);
       v.x:=0;v.y:=0;v.z:=0;v.w:=1;
       Matrix_Vektor_Produkt (KMatrix.O,v,ev);
       Matrix_Vektor_Produkt (OMatrix.i,ev,ergv2);
       OV.x:=ergv1.x-ergv2.x; OV.y:=ergv1.y-ergv2.y; OV.z:=ergv1.z-ergv2.z;
end;

procedure Matrixinitialisieren(VAR m:TMatrix);
begin
   glMatrixMode(GL_ModelView);
   //glPushMatrix;
   glLoadIdentity;
   glGetFloatv(GL_MODELVIEW_MATRIX,@m);
   //glPopMatrix;
end;

procedure KOSInitialisieren;
begin
   ObjKOSInitialisieren;
   KamKOSInitialisieren;
end;
procedure KamKOSInitialisieren;
begin
   Matrixinitialisieren(KMatrix.o);
   Matrixinitialisieren(KMatrix.i);
   //glEnable(gl_depth_test);
   //glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;
procedure ObjKOSInitialisieren;
begin
   Matrixinitialisieren(OMatrix.o);
   Matrixinitialisieren(OMatrix.i);
end;

procedure ObjUmWeltKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real);
//Var temp:TMatrix;
begin
    glMatrixMode(GL_ModelView);

//   glPushMatrix;
   glLoadIdentity;
   //glMultMatrixf(@OMatrix.o);
   glTranslatef(px,py,pz);
   glRotatef(grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   glMultMatrixf(@OMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   glLoadIdentity;
   glMultMatrixf(@OMatrix.i);
   glTranslatef(px,py,pz);
   glRotatef(-grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   //glMultMatrixf(@OMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.i);
//   glPopMatrix;
end;
procedure ObjUmWeltKOSDrehen(grad:Real;p:TPunkt;d:TVektor);
begin
   ObjUmWeltKOSDrehen(grad,p.x,p.y,p.z,d.x,d.y,d.z);
end;

procedure ObjUmEigenKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real);
//Var temp:TMatrix;
begin
   glMatrixMode(GL_ModelView);
//   glPushMatrix;
   glLoadIdentity;
   glMultMatrixf(@OMatrix.o);
   glTranslatef(px,py,pz);
   glRotatef(grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   //glMultMatrixf(@OMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   glLoadIdentity;
   //glMultMatrixf(@OMatrix.i);
   glTranslatef(px,py,pz);
   glRotatef(-grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   glMultMatrixf(@OMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.i);
//   glPopMatrix;
end;
procedure ObjUmEigenKOSDrehen(grad:Real;p:TPunkt;d:TVektor);
begin
   ObjUmEigenKOSDrehen(grad,p.x,p.y,p.z,d.x,d.y,d.z)
end;

procedure KamUmWeltKOSDrehen(grad:Real;px,py,pz,dx,dy,dz:Real);
//Var temp:TMatrix;
begin
   glMatrixMode(GL_ModelView);

//   glPushMatrix;
   glLoadIdentity;
   //glMultMatrixf(@KMatrix.o);
   glTranslatef(px,py,pz);
   glRotatef(grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   glMultMatrixf(@KMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@KMatrix.o);
   glLoadIdentity;
   glMultMatrixf(@KMatrix.i);
   glTranslatef(px,py,pz);
   glRotatef(-grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   //glMultMatrixf(@KMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@KMatrix.i);
//   glPopMatrix;
end;
procedure KamUmWeltKOSDrehen(grad:Real;p:TPunkt;d:TVektor);
begin
   KamUmWeltKOSDrehen(grad,p.x,p.y,p.z,d.x,d.y,d.z)
end;

procedure KamUmEigenKOSDrehen(grad,px,py,pz,dx,dy,dz:Real);
begin
   glMatrixMode(GL_ModelView);
//   glPushMatrix;
   glLoadIdentity;
   glMultMatrixf(@KMatrix.o);
   glTranslatef(px,py,pz);
   glRotatef(grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   //glMultMatrixf(@KMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@KMatrix.o);
   glLoadIdentity;
   //glMultMatrixf(@KMatrix.i);
   glTranslatef(px,py,pz);
   glRotatef(-grad,dx,dy,dz);
   glTranslatef(-px,-py,-pz);
   glMultMatrixf(@KMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@KMatrix.i);
//   glPopMatrix;
end;
procedure KamUmEigenKOSDrehen(grad:Real;p:TPunkt;d:TVektor);
begin
   KamUmEigenKOSDrehen(grad,p.x,p.y,p.z,d.x,d.y,d.z)
end;

procedure ObjInWeltKOSVerschieben(vx,vy,vz:Real);
begin
    glMatrixMode(GL_ModelView);

//   glPushMatrix;
   glLoadIdentity;
   glTranslatef(vx,vy,vz);
   glMultMatrixf(@OMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   glLoadIdentity;
   glMultMatrixf(@OMatrix.i);
   glTranslatef(-vx,-vy,-vz);
   //glMultMatrixf(@OMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.i);
//   glPopMatrix;
end;
procedure ObjInWeltKOSVerschieben(v:TVektor);
begin
   ObjInWeltKOSVerschieben(v.x,v.y,v.z)
end;

procedure ObjInEigenKOSVerschieben(vx,vy,vz:Real);
begin
   glMatrixMode(GL_ModelView);

//   glPushMatrix;
   glLoadIdentity;
   glMultMatrixf(@OMatrix.o);
   glTranslatef(vx,vy,vz);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   glLoadIdentity;
   //glMultMatrixf(@OMatrix.i);
   glTranslatef(-vx,-vy,-vz);
   glMultMatrixf(@OMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.i);
//   glPopMatrix;
end;
procedure ObjInEigenKOSVerschieben(v:TVektor);
begin
   ObjInEigenKOSVerschieben(v.x,v.y,v.z)
end;

procedure KamInEigenKOSVerschieben(vx,vy,vz:Real);
begin
   glMatrixMode(GL_ModelView);
//   glPushMatrix;
   glLoadMatrixf(@KMatrix.o);
   glTranslatef(vx,vy,vz);
   glGetFloatv(GL_MODELVIEW_MATRIX,@KMatrix.o);
   glLoadIdentity;
   glTranslatef(-vx,-vy,-vz);
   glMultMatrixf(@KMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@KMatrix.i);
//   glPopMatrix;
end;
procedure KamInEigenKOSVerschieben(v:TVektor);
begin
   KamInEigenKOSVerschieben(v.x,v.y,v.z)
end;

procedure skalieren (VAR m:MatrixPaar;px,py,pz,sx,sy,sz:Real);
begin
   glLoadIdentity;
   gltranslatef(px,py,pz);
   glScalef(sx,sy,sz);
   gltranslatef(-px,-py,-pz);
   glGetFloatv(GL_MODELVIEW_MATRIX,@m.o);
   glLoadIdentity;
   gltranslatef(px,py,pz);
   glScalef(1/sx,1/sy,1/sz);
   gltranslatef(-px,-py,-pz);
   glGetFloatv(GL_MODELVIEW_MATRIX,@m.i);
end;

procedure ObjInWeltKOSSkalieren(px,py,pz,sx,sy,sz:REAL);
VAR temp:MatrixPaar;
begin
   glMatrixMode(GL_ModelView);
//   glPushMatrix;
   skalieren(temp,px,py,pz,sx,sy,sz);
   glLoadMatrixf(@temp.o);
   glMultMatrixf(@OMatrix.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   glLoadMatrixf(@OMatrix.i);
   glMultMatrixf(@temp.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.i);
//   glPopMatrix;
end;
procedure ObjInEigenKOSSkalieren(p:TPunkt;sx,sy,sz:REAL);
begin
   ObjInEigenKOSSkalieren(p.x,p.y,p.z,sx,sy,sz)
end;
procedure ObjInEigenKOSSkalieren(p:TPunkt;s:Real);
begin
   ObjInEigenKOSSkalieren(p.x,p.y,p.z,s,s,s)
end;


procedure ObjInEigenKOSSkalieren(px,py,pz,sx,sy,sz:REAL);
VAR temp:MatrixPaar;
begin
   glMatrixMode(GL_ModelView);
//   glPushMatrix;
   skalieren(temp,px,py,pz,sx,sy,sz);
   glLoadMatrixf(@OMatrix.o);
   glMultMatrixf(@temp.o);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.o);
   glLoadMatrixf(@temp.i);
   glMultMatrixf(@OMatrix.i);
   glGetFloatv(GL_MODELVIEW_MATRIX,@OMatrix.i);
//   glPopMatrix;
end;
procedure ObjInWeltKOSSkalieren(p:TPunkt;sx,sy,sz:Real);
begin
   ObjInWeltKOSSkalieren(p.x,p.y,p.z,sx,sy,sz)
end;
procedure ObjInWeltKOSSkalieren(p:TPunkt;s:Real);
begin
   ObjInWeltKOSSkalieren(p.x,p.y,p.z,s,s,s)
end;


procedure UebergangsmatrixObjekt_Welt_laden;
begin
  glMatrixMode(GL_ModelView);
  glLoadIdentity;
  glMultMatrixf(@OMatrix.o);
end;

procedure UebergangsmatrixWelt_Objekt_laden;
begin
  glMatrixMode(GL_ModelView);
  glLoadIdentity;
  glMultMatrixf(@OMatrix.i);
end;

procedure UebergangsmatrixWelt_Kamera_laden;
begin
  glMatrixMode(GL_ModelView);
  glLoadIdentity;
  glMultMatrixf(@KMatrix.i);
end;

procedure UebergangsmatrixKamera_Welt_laden;
begin
  glMatrixMode(GL_ModelView);
  glLoadIdentity;
  glMultMatrixf(@KMatrix.o);
end;

procedure UebergangsmatrixObjekt_Kamera_laden;
begin
  glMatrixMode(GL_ModelView);
  //glPushMatrix;
  glLoadIdentity;
  glMultMatrixf(@KMatrix.i);
  glMultMatrixf(@OMatrix.o);
end;

end.

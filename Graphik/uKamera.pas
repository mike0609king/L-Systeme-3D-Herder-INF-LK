unit uKamera;

interface
uses ExtCtrls,uRenderer;

procedure KameraInit(p:TPanel); overload;
//das Panel ist die Projektionsfläche der Kamera
//es wird ein Standardobjektiv für die Kamera benutzt.
procedure KameraInit(p:TPanel;phi,nah,fern:REAL); overload;
//das Panel ist die Projektionsfläche der Kamera
//phi,nah,fern sind Einstellungen des Kameraobjektivs
procedure KameraDestroy(p:TPanel);
//die Kamera wird ausgeschaltet
procedure KameraStart(anim:ProcRenderer);
//anim ist die zu startende Animation und wird auf der Projektionsfläche
//dargestellt
procedure KameraPause;
//das aktuelle Kamerabild wird eingefroren
procedure KameraWeiter;
//die Szene wird nach einer Pause wieder über die Kamera dargestellt
procedure KameraZoom(deltaPhi:Real);
procedure KameraXVersch(deltaX:Real);
procedure KameraYVersch(deltaY:Real);
procedure KameraZVersch(deltaZ:Real);

procedure KameraHorizontalSchwenken(deltaphi:Real);
procedure KameraVertikalSchwenken(deltaphi:Real);
procedure KameraSeitlichKippen(deltaphi:Real);
procedure KameraGrossKreisXRotieren(deltaphi:Real);
//Richtungsvektor der Drehachse ist x-Achse der Kamera durch Koordinatenursprung
//des Weltkoordinatensystems
procedure KameraGrossKreisYRotieren(deltaphi:Real);
procedure KameraUmTurtleXRotieren(deltaphi:Real);
procedure KameraUmTurtleYRotieren(deltaphi:Real);
//
implementation
uses uMatrizen,uKamObjektiv,uForm;

procedure KameraInit(p:TPanel);
begin
  RendererInit(p);
  KamProjFlaecheInit(p.width,p.height);
  KamObjektivInit(40,0.1,99);
  KamKOSInitialisieren;
  KamInEigenKOSVerschieben(0,3,10);
  //KamUmWeltKOSDrehen(15,0,0,0,0,1,0);
  //KamUmWeltKOSDrehen(15,0,0,0,1,0,0)
end;

procedure KameraInit(p:TPanel;phi,nah,fern:REAL);
begin
  KameraInit(p);
  KamObjektivInit(phi,nah,fern);
end;
procedure KameraUmTurtleXRotieren(deltaphi:Real);
VAR pw,po,pt:TPunkt;nr:CARDINAL;
Begin
   po.x:=1;po.y:=0;po.z:=0;
   nr:=Hauptform.aktuelle_turtle_nr;
   pt.x:=Hauptform.o.turtleListe[nr].StartPunkt.x;
   pt.y:=Hauptform.o.turtleListe[nr].StartPunkt.y;
   pt.z:=Hauptform.o.turtleListe[nr].StartPunkt.z;
   UmrechnenKamVektorInWeltVektor(po,pw);
   KamUmWeltKosDrehen(deltaphi,pt.x,pt.y,pt.z,pw.x,pw.y,pw.z);
end;
procedure KameraUmTurtleYRotieren(deltaphi:Real);
VAR pw,po,pt:TPunkt;nr:CARDINAL;
Begin
   po.x:=0;po.y:=1;po.z:=0;
   nr:=Hauptform.aktuelle_turtle_nr;
   pt.x:=Hauptform.o.turtleListe[nr].StartPunkt.x;
   pt.y:=Hauptform.o.turtleListe[nr].StartPunkt.y;
   pt.z:=Hauptform.o.turtleListe[nr].StartPunkt.z;
   UmrechnenKamVektorInWeltVektor(po,pw);
   KamUmWeltKosDrehen(deltaphi,pt.x,pt.y,pt.z,pw.x,pw.y,pw.z);
end;

procedure Kameradestroy(p:TPanel);
begin
  RendererDestroy(p);
end;

procedure Kamerapause;
begin
  RendererDeaktivieren;
end;

procedure Kameraweiter;
begin
  RendererAktivieren;
end;

procedure Kamerazoom (deltaphi:Real);
begin
  KamObjektivZoom(deltaphi);
end;

procedure KameraStart(anim:ProcRenderer);
begin
  RendererStart(anim)
end;
procedure KameraXVersch(deltaX:Real);
begin
   KamInEigenKOSVerschieben(deltaX,0,0)
end;

procedure KameraYVersch(deltaY:Real);
begin
   KamInEigenKOSVerschieben(0,deltaY,0)
end;

procedure KameraZVersch(deltaZ:Real);
begin
   KamInEigenKosVerschieben(0,0,deltaZ)
end;

procedure KameraHorizontalSchwenken(deltaphi:Real);
begin
   KamUmEigenKOSDrehen(deltaphi,0,0,0,0,1,0);
end;

procedure KameraVertikalSchwenken(deltaphi:Real);
begin
   KamUmEigenKOSDrehen(deltaphi,0,0,0,1,0,0);
end;

procedure KameraSeitlichKippen(deltaphi:Real);
begin
   KamUmEigenKOSDrehen(deltaphi,0,0,0,0,0,1);
end;

procedure KameraGrossKreisYRotieren(deltaphi:Real);
VAR pw,po:TPunkt;
Begin
   po.x:=0;po.y:=1;po.z:=0;
   UmrechnenKamVektorInWeltVektor(po,pw);
   KamUmWeltKosDrehen(deltaphi,0,0,0,pw.x,pw.y,pw.z);
end;

procedure KameraGrossKreisXRotieren(deltaphi:Real);
VAR pw,po:TPunkt;
Begin
   po.x:=1;po.y:=0;po.z:=0;
   UmrechnenKamVektorInWeltVektor(po,pw);
   KamUmWeltKosDrehen(deltaphi,0,0,0,pw.x,pw.y,pw.z);
end;


end.


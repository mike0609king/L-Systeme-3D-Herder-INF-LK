unit uKamObjektiv;

{$MODE Delphi}

//Bisher etwas mager, da nur Objektive für perspektivische Sicht vorgesehen sind.
//Eine Minimalauswahl aus "Standardobjektiven wäre vorstellbar (Weitwinkelobjektiv ...).
interface
TYPE TObjektiv= (Perspektive, Orthogonal);
VAR  aktObjektiv: TObjektiv;
procedure KamProjFlaecheInit
             (Breite,Hoehe:CARDINAL);
(*Die Kamera besitzt ein Display von Breite * Hoehe Pixeln.*)

procedure KamObjektivInit (Sichtwinkel:Real;  //in y-Richtung
                           nah,fern:Real); //Clippingbereich
(*Vor: 0<SichtWinkel<180 und 0<nah<fern
  Eff: Initialisiert die Kamera mit dem Objektiv so, dass das
       Kameradisplay ProjFlaechenBreite*ProjFlaechenHoehe Pixel besitzt.
       Das Objektiv hat die Einstellung, dass es in der ProjFlaechenHoehe
       den Sichtwinkel abbildet.
       Nah und Fern sind der darstellbare Tiefenbereich des Objektivs.*)
procedure KamObjektivZoom (deltaSichtWinkel:Real);
//Ändert den SichtWinkel um deltaSichtWinkel, wobei deltaSichtwinkel>0 ein
//heranzoomen bedeutet.
//Würde hierdurch der Sichtwinkel<=0 oder SichtWinkel>=180, so ist nichts
//verändert.

implementation
uses dglOpenGL, Math;

VAR phi:Real;
    Pbreite,Phoehe:CARDINAL;  //Pixelanzahl
    Cnah,Cfern:Real;
procedure KamProjFlaecheInit(Breite,Hoehe:CARDINAL);
begin
   PBreite:=breite;
   PHoehe:=Hoehe;
end;

procedure KamObjektivInit (Sichtwinkel:Real;  //in y-Richtung
                           nah,fern:Real); //Clippingbereich
VAR d:REAL;
begin
   Cnah:=nah;
   CFern:=fern;
   phi:=Sichtwinkel;
   glMatrixMode(GL_Projection);
   glLoadIdentity;
   IF aktObjektiv=Perspektive THEN
       gluPerspective(phi,Pbreite/Phoehe, CNah, CFern)
   ELSE
   begin
      d:=3*tan(phi/180*pi);
      glOrtho (-Pbreite/PHoehe*d,PBreite/PHoehe*d,-d,d,Cnah,Cfern);
   end;
end;

procedure KamObjektivZoom (deltaSichtWinkel:Real);
var temp:Real;
    d:Real;
begin
   temp:=phi-deltaSichtWinkel;
   IF (temp>0) and (temp<180) then
   begin
      phi:=temp;
      glMatrixMode(GL_Projection);
      glLoadIdentity;
      IF aktObjektiv=Perspektive THEN
         gluPerspective(phi,Pbreite/Phoehe, CNah, CFern)
      Else
      begin
         d:=3*tan(phi/180*pi);
         glOrtho (-Pbreite/PHoehe*d,PBreite/PHoehe*d,-d,d,Cnah,Cfern);
      end;
   end;
end;

begin
   aktObjektiv:=Perspektive
end.

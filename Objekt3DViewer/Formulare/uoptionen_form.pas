unit uOptionen_form;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,uturtlemanager;

type

  { TTOptionen }

  TTOptionen = class(TForm)
    BT_fertig: TButton;
    BT_zuruecksetzen: TButton;
    ED_stringlaenge: TEdit;
    Label1: TLabel;
    procedure BT_fertigClick(Sender: TObject);
    procedure BT_zuruecksetzenClick(Sender: TObject);
  private

  public
    procedure update_bt();
    procedure turtles_neuzeichnen(turtlemanager:TTurtlemanager;maximaleStringLaenge:CARDINAL);
  end;

var
  Optionen_Form: TTOptionen;

implementation

{$R *.lfm}
uses uForm;

{ TTOptionen }

procedure TTOptionen.BT_fertigClick(Sender: TObject);
VAR maximaleStringLaenge:CARDINAL;turtlemanager:TTurtlemanager;i:CARDINAL;
begin
  maximaleStringLaenge:=strtoint(ED_stringlaenge.text); //Aufpassen mit der Größe
  if maximaleStringLaenge > 9999999 then
  begin
     SHOWMESSAGE('Die maximale Stringlänge darf maximal 9.999.999 sein.');
     BT_zuruecksetzenClick(self);
  end
  else
  begin
    turtlemanager:=Hauptform.o.copy();
    // wenn kleiner als vorher neuzeichnen, wenn größer -> egal
    if maximaleStringLaenge < Hauptform.maximaleStringLaenge then
    begin
       turtles_neuzeichnen(turtlemanager,maximaleStringLaenge);
    end
    else
    begin
       Hauptform.maximaleStringLaenge:=maximaleStringLaenge;
       //alle maximalenStringLaengen anpassen
       for i:=0 to turtlemanager.turtleListe.Count-1 do
         begin
           turtlemanager.turtleListe[i].maximaleStringLaenge:=maximaleStringLaenge;
           turtlemanager.turtleListe[i].zeichnen();
         end;
    end;
    Visible:=False;
    Hauptform.zeichnen;
  end;
  //wieder unsichtbar machen

end;

function neuzeichnen(turtlemanager:TTurtlemanager;maximaleStringLaenge:CARDINAL):Boolean;
var i:CARDINAL;
begin
   for i:=0 to turtlemanager.turtleListe.Count-1 do
   begin
     turtlemanager.turtleListe[i].maximaleStringLaenge:=maximaleStringLaenge;
     if not turtlemanager.turtleListe[i].zeichnen then result:=True;
   end;
   result:=False;
end;

function neu_machen(turtlemanager:TTurtlemanager;maximaleStringLaenge:CARDINAL): TTurtlemanager;
VAR i,rek:CARDINAL;
begin
   for i:=0 to turtlemanager.turtleListe.Count-1 do
   begin
     turtlemanager.turtleListe[i].maximaleStringLaenge:=maximaleStringLaenge;
     while not turtlemanager.turtleListe[i].zeichnen do
     begin
          rek:= turtlemanager.turtleListe[i].rekursionsTiefe;
          turtlemanager.turtleListe[i].rekursionsTiefe:=rek-1;
     end;
   end;
   result:= turtlemanager;
end;

procedure TTOptionen.turtles_neuzeichnen(turtlemanager:TTurtlemanager;maximaleStringLaenge:CARDINAL);
VAR str_1,str_2,str_3,str:string; bt_selected:Integer;kopie:TTurtlemanager;
begin
  //neuzeichen mit fehler handeling
  //mehrere optionen: rekursionstiefe runter machen (automatisch oder löschen)
  if neuzeichnen(turtlemanager,maximaleStringLaenge) then
  begin
     Hauptform.maximaleStringLaenge:=maximaleStringLaenge;
     Hauptform.push_neue_instanz(turtlemanager); //testen
  end
  else
  begin
    str_1:='Es gab einen Fehler beim Neuzeichen der Turtles!';
    str_2:='Dies liegt daran, das eine oder mehrere Turtles zu lang für die neue Maximallänge sind.';
    str_3:='Soll die Rekursiontiefe automatisch angepasst werden, da es passt?';
    str:= str_1+sLineBreak+str_2+ sLineBreak + str_3;
    bt_selected:=MessageDlg(str,mtCustom,[mbYes,mbCancel],0);
    if bt_selected=mrYes then
    begin
      turtlemanager:= neu_machen(turtlemanager,maximaleStringLaenge);
      Hauptform.maximaleStringLaenge:=maximaleStringLaenge;
      Hauptform.push_neue_instanz(turtlemanager);
    end
    else
    begin
      //Abruch
    end;
  end;
end;

procedure TTOptionen.BT_zuruecksetzenClick(Sender: TObject);
begin
   update_bt();
end;

procedure TTOptionen.update_bt();
begin
   ED_stringlaenge.text:=inttostr(Hauptform.maximaleStringLaenge);
end;


end.


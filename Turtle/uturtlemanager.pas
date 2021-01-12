unit uTurtleManager;

{$mode delphi}

interface

uses
  Classes, SysUtils, fgl, uTurtle;

type TTurtleListe = TFPGList<TTurtle>;

type TTurtleManager = class
    private
        FTurtleListe:  TTurtleListe;
        FAnzahlElemente : Cardinal;
    public
        constructor Create;
        procedure addTurtle(turtle: TTurtle);
        procedure zeichnen;
        procedure setzeSichtbarkeit(idx: Cardinal; visibility: Boolean);

        // property
        property turtleListe: TTurtleListe read FTurtleListe;
        property anzahlElemente: Cardinal read FAnzahlElemente;
end;
   
implementation
uses uMatrizen,dglOpenGL;

constructor TTurtleManager.Create;
begin
    FTurtleListe := TTurtleListe.Create;
    FAnzahlElemente := 0;
end;

procedure TTurtleManager.addTurtle(turtle: TTurtle);
begin
    FTurtleListe.add(turtle);
    inc(FAnzahlElemente);
end;

procedure TTurtleManager.setzeSichtbarkeit(idx: Cardinal; visibility: Boolean);
begin
    // check valid index
    if (idx >= 0) and (idx < FAnzahlElemente) then FTurtleListe[idx].visible := visibility;
end;

procedure TTurtleManager.zeichnen;
var i: Cardinal;
begin
    glMatrixMode(GL_ModelView);
    glClearColor(0,0,0,0);
    for i := 0 to FAnzahlElemente - 1 do
    begin
        if not FTurtleListe[i].visible then continue;
        FTurtleListe[i].zeichnen;
    end;
end;

end.


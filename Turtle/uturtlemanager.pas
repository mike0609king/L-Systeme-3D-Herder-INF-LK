unit uTurtleManager;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fgl, uTurtle;

type TTurtleListe = TFPGList<TTurtle>;
type PTurtle = ^TTurtle;

type TTurtleManager = class
  private
    FTurtleListe:  TTurtleListe;

    { Rueckgabe: True, wenn gueltig. False andernfalls. }
    function ueberpruefeGueltigkeitVomIndex(idx: Cardinal) : Boolean;

  public
    constructor Create;

    destructor Destroy; override;

    // property
    property turtleListe: TTurtleListe read FTurtleListe;

    { Aufgabe: Fuegt eine Turtle hinzu. }
    procedure addTurtle(turtle: TTurtle);
    { Aufgabe: Entfernt eine Turtle, die den gleichen Wert, wie die uebergebene Instanz hat.
      Rueckgabe: Gibt an, ob die Turtle endfernt wurde bzw. ob der Index.}
    function entferneTurtle(turtle: TTurtle) : Boolean;
    { Aufgabe: Entfernt die Schildkroete am Index, der als Parameter uebergeben wurde.
      Rueckgabe: Gibt an, ob die Turtle endfernt wurde bzw. ob der Index. }
    function entferneTurtleAn(idx: Cardinal) : Boolean;
    { Aufgabe: Zeichnet alle L-Systeme dessen Turtles schon in den Manager eingefuegt worden
      wurden und dessen status auf sichtbar gestellt wurde. }
    procedure zeichnen;
    function copy : TTurtleManager;

    // setter-Funktion (public)
    { Rueckgabe: Gibt an, ob die Sichtbarkeit gesetzt wurde bzw. ob der Index
      gueltig war. }
    function setzeSichtbarkeit(idx: Cardinal; visibility: Boolean) : Boolean;

    // getter-Funktionen (public)
    function gibTurtle(idx: Cardinal; var turt: TTurtle) : Boolean;
end;
   
implementation
uses uMatrizen,dglOpenGL;

constructor TTurtleManager.Create;
begin
  FTurtleListe := TTurtleListe.Create;
end;

destructor TTurtleManager.Destroy;
VAR i:CARDINAL;
begin
  for i:=0 to FTurtleListe.count-1 do
  begin
   FTurtleListe[i].destroy()
  end;
  FreeandNil(FTurtleListe);
end;

function TTurtleManager.ueberpruefeGueltigkeitVomIndex(idx: Cardinal) :Boolean;
begin
  if (idx >= 0) and (idx < FTurtleListe.Count) then result := true
  else result := false;
end;

procedure TTurtleManager.addTurtle(turtle: TTurtle);
begin
  FTurtleListe.add(turtle);
end;

function TTurtleManager.entferneTurtle(turtle: TTurtle) : Boolean;
var retSpeicher: Integer;
begin
  retSpeicher := FTurtleListe.remove(turtle);
  if retSpeicher = -1 then result := false
  else result := true;
end;

function TTurtleManager.entferneTurtleAn(idx: Cardinal) : Boolean;
begin
  result := ueberpruefeGueltigkeitVomIndex(idx);
  // result muesste nicht zugewiesen werden, aber falls noch etwas geaendert wird...
  if result then result := entferneTurtle(FTurtleListe[idx]); 
end;

procedure TTurtleManager.zeichnen;
var i: Cardinal;
begin
  glMatrixMode(GL_ModelView);
  glClearColor(0,0,0,0);
  for i := 0 to FTurtleListe.Count-1 do
  begin
    if not FTurtleListe[i].visible then continue;
    FTurtleListe[i].zeichnen;
  end;
end;

function TTurtleManager.copy : TTurtleManager;
var i: Cardinal;
    turtle: TTurtle;
begin
  result := TTurtleManager.Create;
  for i := 0 to FTurtleListe.Count-1 do
  begin
    gibTurtle(i,turtle);
    result.addTurtle(turtle.copy);
  end;
end;

function TTurtleManager.setzeSichtbarkeit(idx: Cardinal; visibility: Boolean) : Boolean;
begin
  result := ueberpruefeGueltigkeitVomIndex(idx);
  if result then FTurtleListe[idx].visible := visibility;
end;

function TTurtleManager.gibTurtle(idx: Cardinal; var turt: TTurtle) : Boolean;
begin
  result := ueberpruefeGueltigkeitVomIndex(idx);
  if result then turt := FTurtleListe[idx];
end;
end.


unit uStack;

{$mode delphi}{$h+}

interface

uses Classes, SysUtils;

// kann noch Variabel gemacht werden
type elementTyp = Char;

{
Der Stack soll nach aussen so wie stack<string> in C++ scheinen
}
const mxStackSize = 1000;
type TStack = class
  private
    pTop: Cardinal; // markiert naechster Platz zum einfuegen
    stack: array[0..mxStackSize] of elementTyp;
  public
    constructor Create;
    destructor Destroy; override;

    procedure push(element: elementTyp);
    function pop : elementTyp;
    function top : elementTyp;
    function empty : Boolean;
end;

implementation

constructor TStack.Create;
begin
  pTop := 0;
end;

destructor TStack.Destroy;
begin
  FreeAndNil(stack);
  FreeAndNil(pTop);
end;

procedure TStack.push(element: elementTyp);
begin
  if pTop < mxStackSize then
  begin
    stack[pTop] := element;
    inc(pTop);
  end;
end;
  
function TStack.pop : elementTyp;
begin
  if not empty then
  begin
    result := stack[pTop - 1];
    dec(pTop);
  end;
end;

function TStack.top : elementTyp;
begin
  if not empty then
  begin
    result := stack[pTop - 1];
  end;
end;

function TStack.empty : Boolean;
begin
  result := (pTop = 0);
end;

end.

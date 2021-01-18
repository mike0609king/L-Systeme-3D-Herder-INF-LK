unit UGrammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, uAnimation, fgl,uTurtleManager,ugrammatik,uTurtle;
type

  { TuGrammatiken }

  TuGrammatiken = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Anzahl: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure AnzahlClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  aGrammatiken: TuGrammatiken;

implementation
uses uform,uZeichnerBase;
{$R *.lfm}

{ TuGrammatiken }

procedure TuGrammatiken.AnzahlClick(Sender: TObject);
begin

end;
//zeichenstyle fehlt noch
procedure TuGrammatiken.Button1Click(Sender: TObject);
var i,n,anzahl:CARDINAL;MemoLine: TStringArray;
    gram:TGrammatik;R:String;L,S:Char;
    Turtel:TTurtle;zeichenPara: TZeichenParameter;
begin
  gram:=gram.create;
  n:=0;
  S:=copy(Memo1.Lines[1],1,pos('->',Memo1.Lines[1])-1);
  gram.axiom:= S;
  While n-1>= Memo1.Lines.Count do
    begin
    L:=copy(Memo1.Lines[n],1,pos('->',Memo1.Lines[n])-1);            //ändern
    R:=copy(Memo1.Lines[n],1,pos('->',Memo1.Lines[n]));
    //wahrscheinlichkeit

    gram.addRegel(L,R);
    INC(n);
    end;
  //
  zeichenPara.rekursionsTiefe:= strtoint(Edit2.Text);
  zeichenPara.winkel:=strtofloat(Edit3.Text);
  NameGrammatik:=Edit4.Text;
  anzahl:= strtoint(Edit1.Text)-1;
  //erstellen der Turtels
  for i:=0 to anzahl do
  begin
       zeichenPara.setzeStartPunkt(Hauptform.akt_x,Haupform.akt_y,Haupform.akt_z);
       turtle:=TTurtle.Create(gram, TZeichnerBase.Create(zeichenPara));
       turtle.name:=NameGrammatik;
       Hauptform.update_startkoords();
       Hauptform.o.addTurtle(turtle);
  end;
  Visible:=False;
end;

procedure TuGrammatiken.Button2Click(Sender: TObject);
begin
end;

procedure TuGrammatiken.Edit1Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.Edit2Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.Edit3Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.Edit4Change(Sender: TObject);
begin

end;

procedure TuGrammatiken.FormCreate(Sender: TObject);
begin

end;

procedure TuGrammatiken.Memo1Change(Sender: TObject);
begin

end;


end.


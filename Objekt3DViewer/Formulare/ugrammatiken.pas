unit UGrammatiken;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, uAnimation, fgl,uTurtleManager,ugrammatik,uTurtle;
type

  { TuGrammatiken }

  TuGrammatiken = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
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
    procedure Button3Click(Sender: TObject);
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
uses uForm,uZeichnerBase;
{$R *.lfm}

{ TuGrammatiken }

procedure TuGrammatiken.AnzahlClick(Sender: TObject);
begin

end;
//zeichenstyle fehlt noch
procedure TuGrammatiken.Button1Click(Sender: TObject);
var i,n,anzahl:CARDINAL;
    gram:TGrammatik;R,L,NameGrammatik:String;
    Lc:Char;
    W:REAL;
    Turtle:TTurtle;zeichenPara: TZeichenParameter;
    p,s: Integer;
begin
  gram:=TGrammatik.Create;
  n:=0;
  p:=pos('->',Memo1.Lines[0]);
  gram.axiom:= copy(Memo1.Lines[0],1,p-1);
  While n<= Memo1.Lines.Count do
    begin
    p:=pos('->',Memo1.Lines[n]);
    s:=pos(',',Memo1.Lines[n]);
    L:=copy(Memo1.Lines[n],1,p-1);//linke Seite des '->'
    Lc:=L[1]; //StrToChar
    R:=copy(Memo1.Lines[n],1,p-1);//rechte Seite des '->'
    delete(R,1,s-2);              //,aber hinter dem Komma
    W:=strtofloat(copy(Memo1.Lines[n],1,s-2));//wahrscheinlichkeit
    gram.addRegel(Lc,R,W);
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
       zeichenPara.setzeStartPunkt(Hauptform.akt_x,Hauptform.akt_y,Hauptform.akt_z);
       Turtle:=TTurtle.Create(gram, TZeichnerBase.Create(zeichenPara));
       Turtle.name:=NameGrammatik;
       Hauptform.update_startkoords();
       Hauptform.o.addTurtle(Turtle);
       Hauptform.zeichnen();
  end;
  Visible:=False;
end;

procedure TuGrammatiken.Button2Click(Sender: TObject);
var turtle: TTurtle;
    datei: String;
begin
  turtle.speichern(datei);
end;

procedure TuGrammatiken.Button3Click(Sender: TObject);
var i,n,anzahl:CARDINAL;MemoLine: TStringArray;
    gram:TGrammatik;L,R,NameGrammatik:String;
    W:REAL;
    zeichenPara: TZeichenParameter;
    p,s:Integer;
    Lc:Char;
    turtle: TTurtle;
    datei: String;
    begin
      gram:=TGrammatik.Create;
      n:=0;
      p:=pos('->',Memo1.Lines[0]);
      gram.axiom:= copy(Memo1.Lines[0],1,p-1);
      While n-1>= Memo1.Lines.Count do
        begin
        p:=pos('->',Memo1.Lines[n]);
        s:=pos(',',Memo1.Lines[n]);
        L:=copy(Memo1.Lines[n],1,p-1);//linke Seite des ->
        Lc:=L[1];
        R:=copy(Memo1.Lines[n],1,p-2);//rechte Seite des ->
        delete(R,1,s-2); //,aber hinter dem Komma
        W:=strtofloat(copy(Memo1.Lines[n],1,s-2));//wahrscheinlichkeit
        gram.addRegel(Lc,R,W);
        INC(n);
        end;
  //
  zeichenPara.rekursionsTiefe:= strtoint(Edit2.Text);
  zeichenPara.winkel:=strtofloat(Edit3.Text);
  NameGrammatik:=Edit4.Text;
  anzahl:= strtoint(Edit1.Text)-1;
   //speichern des Turtels
  for i:=0 to anzahl do
  begin
       zeichenPara.setzeStartPunkt(Hauptform.akt_x,Hauptform.akt_y,Hauptform.akt_z);
       turtle:= TTurtle.Create(datei);
  end;
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


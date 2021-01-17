unit UGrammatiken;

{$mode delphi}

interface

uses
<<<<<<< HEAD
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, uAnimation, fgl,uTurtleManager,ugrammatik;
=======
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus, uAnimation, fgl;
>>>>>>> parent of 9c3a191... UGrammatiken weiterarbeit
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
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  aGrammatiken: TuGrammatiken;

implementation
uses uform;
{$R *.lfm}

{ TuGrammatiken }

procedure TuGrammatiken.AnzahlClick(Sender: TObject);
begin

end;

procedure TuGrammatiken.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TuGrammatiken.Button2Click(Sender: TObject);
var n:CARDINAL;
<<<<<<< HEAD
    MemoLine: TStringArray;
    gram:TGrammatik;
    S,R:String;
=======
>>>>>>> parent of 9c3a191... UGrammatiken weiterarbeit
begin
  n:=0;
<<<<<<< HEAD
  S:=copy(Memo1.Lines[1],1,pos('->',Memo1.Lines[1])-1);
  gram.axiom:= S;
  While n-1>= Memo1.Lines.Count do
  begin
  S:=copy(Memo1.Lines[n],1,pos('->',Memo1.Lines[n])-1);
  R:=copy(Memo1.Lines[n],1,pos('->',Memo1.Lines[n]);
  gram.addRegel(S,R,18);
=======
  TFPGList.create;
  While n-1>= Memo1.Lines.Count do
  Begin
  TFPGList.Add(Memo1.Lines[n];
>>>>>>> parent of 9c3a191... UGrammatiken weiterarbeit
  INC(n);
  end;
end;

procedure TuGrammatiken.Edit1Change(Sender: TObject);
begin
  Anzahl:= Edit1.Text;
end;

procedure TuGrammatiken.Edit2Change(Sender: TObject);
begin
  zeichenPara.rekursionsTiefe:= Edit2.Text;
end;

procedure TuGrammatiken.Edit3Change(Sender: TObject);
begin
  zeichenPara.winkel:=Edit3.Text;
end;

procedure TuGrammatiken.Edit4Change(Sender: TObject);
begin
  NameGrammatik:=Edit4.Text;
end;

procedure TuGrammatiken.Memo1Change(Sender: TObject);
begin

end;


end.


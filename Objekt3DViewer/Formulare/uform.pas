unit uForm;

{$MODE Delphi}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ExtCtrls, StdCtrls, ComCtrls, Menus, LMessages, Spin;
type

  { TForm1 }

  TForm1 = class(TForm)
    BtPause: TButton;
    BtZoomP: TButton;
    BtZoomM: TButton;
    BtKameraReset: TButton;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    GraphikPanel: TPanel;
    Grammatik: TMenuItem;
    Parameter: TMenuItem;
    Timer1: TTimer;
    BtLinksV: TButton;
    BtRechtsV: TButton;
    BtVorV: TButton;
    BtZurueckV: TButton;
    BtHochV: TButton;
    BtRunterV: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BtLinksS: TButton;
    BtRechtsS: TButton;
    BtRunterS: TButton;
    BtHochS: TButton;
    BtLinksK: TButton;
    BtRechtsK: TButton;
    Label6: TLabel;
    BtLinksKreis: TButton;
    BtRechtsKreis: TButton;
    BtHochKreis: TButton;
    BtRunterKreis: TButton;
    TrackBar1: TTrackBar;
    Label8: TLabel;
    procedure BtKameraResetClick(Sender: TObject);
    procedure GrammatikClick(Sender: TObject);
    procedure ParameterClick(Sender: TObject);
    procedure MOrthoClick(Sender: TObject);
    procedure MZentralClick(Sender: TObject);
    procedure MKoordinatensystemClick(Sender: TObject);
    procedure MWeltKOSClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtPauseClick(Sender: TObject);
    procedure Button2OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button2OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button3OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button4OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button5OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button6OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button7OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button8OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button9OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button10OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button11OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button12OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button13OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button14OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button15OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button16OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button17OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button18OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button19OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure BtXRotClick(Sender: TObject);
    procedure BtYRotClick(Sender: TObject);
    procedure BtZRotClick(Sender: TObject);
  private    { Private-Deklarationen }
    aktiv:procedure (r:Real);
    r:Real;
    v:CARDINAL;
  public    { Public-Deklarationen }
  end;

var
  HauptForm: TForm1;

implementation
uses  uAnimation,uKamera, uKamObjektiv, uMatrizen;
{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  width:=screen.width-310;
  height:=screen.Height-200;
  GraphikPanel.Height:=height-50;
  GraphikPanel.Width:=width-150;
  Trackbar1.width:=width-100;
  Trackbar1.top:=height-25;
  Label8.Top:=height-25;
  v:=TrackBar1.Position;
  //uObjekt.objekt:=n;
  KameraInit(GraphikPanel);
  KameraStart(uAnimation.ozeichnen);
  Timer1.Enabled:=FALSE;
  ObjKOSinitialisieren;
 // kartToKugel;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Kameradestroy(GraphikPanel);
end;
procedure TForm1.GrammatikClick(Sender: TObject);
begin

end;

procedure TForm1.ParameterClick(Sender: TObject);
begin

end;



procedure TForm1.BtPauseClick(Sender: TObject);
begin
   IF BtPause.Caption='Pause' THEN
   Begin
      BtPause.Caption:='Weiter';
      KameraPause
   END
   ELSE
   Begin
      BtPause.Caption:='Pause';
      KameraWeiter
   end
end;

procedure TForm1.Button2OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=Kamerazoom;
   r:=0.1*v;
   Timer1.Enabled:=TRUE;
end;

procedure TForm1.Button2OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   Timer1.Enabled:=FALSE;
end;


procedure TForm1.Button3OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=Kamerazoom;
   r:=-0.1*v;
   Timer1.Enabled:=TRUE;
end;

procedure TForm1.Timer1Timer (Sender: TObject);
begin
   Timer1.Interval:=1;
   aktiv(r)
end;
procedure TForm1.MOrthoClick(Sender: TObject);
begin
   uKamObjektiv.aktObjektiv:=Orthogonal;
   aktiv:=Kamerazoom;
   r:=0*v;
   Timer1.Enabled:=TRUE;

end;

procedure TForm1.BtKameraResetClick(Sender: TObject);
begin
  KameraInit(GraphikPanel);
end;


procedure TForm1.MZentralClick(Sender: TObject);
begin
   uKamObjektiv.aktObjektiv:=Perspektive;
   aktiv:=Kamerazoom;
   r:=0*v;
   Timer1.Enabled:=TRUE;

end;

procedure TForm1.MKoordinatensystemClick(Sender: TObject);
begin
end;

procedure TForm1.MWeltKOSClick(Sender: TObject);
begin
    //uObjekt.WeltKOSein:=NOT WeltKOSein;

end;

procedure TForm1.Button4OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraXVersch;
   r:=-0.01*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button5OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraXVersch;
   r:=0.01*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button6OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraZVersch;
   r:=-0.01*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button7OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraZVersch;
   r:=0.01*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button8OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraYVersch;
   r:=0.01*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button9OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraYVersch;
   r:=-0.01*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button10OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraHorizontalSchwenken;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button11OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraHorizontalSchwenken;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button12OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraVertikalSchwenken;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button13OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraVertikalSchwenken;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button14OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraSeitlichKippen;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button15OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraSeitlichKippen;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button16OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraGrossKreisYRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button17OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraGrossKreisYRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button18OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraGrossKreisXRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.Button19OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraGrossKreisXRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
   v:=TrackBar1.Position
end;

procedure TForm1.BtXRotClick(Sender: TObject);
begin

end;

procedure TForm1.BtYRotClick(Sender: TObject);
begin

end;

procedure TForm1.BtZRotClick(Sender: TObject);
begin

end;


end.

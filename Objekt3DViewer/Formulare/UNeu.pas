unit UNeu;

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
    Button1: TButton;
    BtOK: TButton;
    Button3: TButton;
    BtKameraReset: TButton;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    MSierpinsky: TMenuItem;
    MDreieckS: TMenuItem;
    MTetraederS: TMenuItem;
    MObjekt: TMenuItem;
    MProjektion: TMenuItem;
    MOrtho: TMenuItem;
    MZentral: TMenuItem;
    MAbbildung: TMenuItem;
    MMatrizen: TMenuItem;
    MKoordinatensystem: TMenuItem;
    MWeltKOS: TMenuItem;
    MZurueck: TMenuItem;
    MInit: TMenuItem;
    MklQuadrat: TMenuItem;
    MObjektKOS: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MgrQuadrat: TMenuItem;
    MenuItem30: TMenuItem;
    MUmrechnung: TMenuItem;
    MkartToKugel: TMenuItem;
    MKugelToKart: TMenuItem;
    MDreieck: TMenuItem;
    MGeomAbb: TMenuItem;
    MklWuerfel: TMenuItem;
    MgrWuerfel: TMenuItem;
    MPyramide: TMenuItem;
    PnRekTiefe: TPanel;
    GraphikPanel: TPanel;
    PnPunktSpiegelung: TPanel;
    PnEbenenSpiegelung: TPanel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    SpinEdit1: TSpinEdit;
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
    procedure Button1Click(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtKameraResetClick(Sender: TObject);
    procedure FormShortCut(var Msg: TLMKey; var Handled: Boolean);
    procedure MainMenu1Change(Sender: TObject; Source: TMenuItem;
      Rebuild: Boolean);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MDreieckSClick(Sender: TObject);
    procedure MOrthoClick(Sender: TObject);
    procedure MTetraederSClick(Sender: TObject);
    procedure MZentralClick(Sender: TObject);
    procedure MKoordinatensystemClick(Sender: TObject);
    procedure MWeltKOSClick(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MZurueckClick(Sender: TObject);
    procedure MInitClick(Sender: TObject);
    procedure MObjektClick(Sender: TObject);
    procedure MObjektKOSClick(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MklQuadratClick(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MkartToKugelClick(Sender: TObject);
    procedure MKugelToKartClick(Sender: TObject);
    procedure MgrQuadratClick(Sender: TObject);
    procedure MDreieckClick(Sender: TObject);
    procedure MklWuerfelClick(Sender: TObject);
    procedure MgrWuerfelClick(Sender: TObject);
    procedure MPyramideClick(Sender: TObject);
    procedure PnEbenenSpiegelungClick(Sender: TObject);
    procedure PnEbenenSpiegelungGetDockCaption(Sender: TObject; AControl: TControl;
      var ACaption: String);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup2SelectionChanged(Sender: TObject);
    procedure RadioGroup3SelectionChanged(Sender: TObject);
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
    procedure BtFormMClick(Sender: TObject);
   // procedure kartToKugel;
   // procedure BtUmrechnenClick(Sender: TObject);
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
uses  uAnimation,uKamera, uKamObjektiv, uMatrizen, dglopenGL, uTurtle,
      AMatrix,Rotation,Umrechnung, Umrechnung2,Streckung, Verschiebung, Scherung;
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

procedure TForm1.MTetraederSClick(Sender: TObject);
begin
  PnRekTiefe.Visible:=True;
  //uObjekt.objekt:=st

end;

procedure TForm1.MainMenu1Change(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  With FormAMatrix DO
  begin
    EdAInit;
    A11.Text:='-1';A22.Text:='-1';A33.Text:='-1';
  end;
  PnPunktSpiegelung.Visible:=TRUE;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  RadioGroup2SelectionChanged(self);
  PnEbenenSpiegelung.Visible:=TRUE;
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  FormStreck.Visible:=True
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  FormScher.Visible:=TRUE
end;

procedure TForm1.MenuItem29Click(Sender: TObject);
begin
   FormVer.Visible:=TRUE
end;

procedure TForm1.MDreieckSClick(Sender: TObject);
begin
  PnRekTiefe.Visible:=True;
  //uObjekt.objekt:=sd
end;

procedure TForm1.FormShortCut(var Msg: TLMKey; var Handled: Boolean);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //RekTiefe:=SpinEdit1.Value;
  PnRekTiefe.Visible:=FALSE
end;

procedure TForm1.BtOKClick(Sender: TObject);
begin
  IF RadioGroup1.ItemIndex=0 THEN FormAMatrix.BtMxAClick(self)
  ELSE FormAMatrix.BtAxMClick(self);
  PnPunktSpiegelung.Visible:=FALSE
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  RadioGroup2SelectionChanged(self);
  FormAMatrix.BtAxMClick(self);
  PnEbenenSpiegelung.Visible:=FALSE
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

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
end;

procedure TForm1.MZurueckClick(Sender: TObject);
begin
   FormAMatrix.Schritt_zurueck;
end;

procedure TForm1.MInitClick(Sender: TObject);
begin
  FormAMatrix.BtInitClick(self)
end;

procedure TForm1.MObjektClick(Sender: TObject);
begin

end;

procedure TForm1.MObjektKOSClick(Sender: TObject);
begin
  //uObjekt.ObjektKOSein:= NOT ObjektKOSein;

end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
   FormAMatrix.Azxsinit(2,2);
   FormAMatrix.Visible:=TRUE;
end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
   FormAMatrix.Azxsinit(2,3);
   FormAMatrix.Visible:=TRUE;

end;

procedure TForm1.MenuItem24Click(Sender: TObject);
begin
   FormAMatrix.Azxsinit(3,3);
   FormAMatrix.Visible:=TRUE;
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
begin
   FormAMatrix.Azxsinit(4,4);
   FormAMatrix.Visible:=TRUE;
end;

procedure TForm1.MenuItem26Click(Sender: TObject);
begin
   FormRot.Visible:=True;
end;

procedure TForm1.MklQuadratClick(Sender: TObject);
begin
  uTurtle.objekt:=kq;
end;

procedure TForm1.MenuItem30Click(Sender: TObject);
begin
   FormAMatrix.Azxsinit(3,4);
   FormAMatrix.Visible:=TRUE;
end;

procedure TForm1.MkartToKugelClick(Sender: TObject);
begin
  FormKart2Kugel.Visible:=TRUE
end;

procedure TForm1.MKugelToKartClick(Sender: TObject);
begin
  FormKugel2Kart.Visible:=TRUE
end;

procedure TForm1.MgrQuadratClick(Sender: TObject);
begin
  uTurtle.objekt:=gq;
end;

procedure TForm1.MDreieckClick(Sender: TObject);
begin
  uTurtle.objekt:=d;
end;

procedure TForm1.MklWuerfelClick(Sender: TObject);
begin
  uTurtle.objekt:=kw
end;

procedure TForm1.MgrWuerfelClick(Sender: TObject);
begin
  uTurtle.objekt:=gw
end;

procedure TForm1.MPyramideClick(Sender: TObject);
begin
  uTurtle.objekt:=p
end;

procedure TForm1.PnEbenenSpiegelungClick(Sender: TObject);
begin
  RadioGroup2SelectionChanged(self)
end;

procedure TForm1.PnEbenenSpiegelungGetDockCaption(Sender: TObject; AControl: TControl;
  var ACaption: String);
begin

end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin

end;



procedure TForm1.RadioGroup2SelectionChanged(Sender: TObject);
VAR vx,vy,vz,vs:TVektor;
    f:Real;
VAR temp:MatrixPaar;
VAR phi:Real;

begin
  WITH FormAMatrix DO
  begin
    EdAInit;
    IF RadioGroup3.ItemIndex=1 THEN
    Begin
      CASE RadioGroup2.ItemIndex OF
        0: A33.Text:='-1';
        1: A22.Text:='-1';
        2: A11.Text:='-1';
     end;
    end
    else
    begin
      vx.x:=OMatrix.o[Mat_x].x;vx.y:=OMatrix.o[Mat_X].y;vx.z:=OMatrix.o[Mat_X].z;
      vy.x:=OMatrix.o[Mat_Y].x;vy.y:=OMatrix.o[Mat_Y].y;vy.z:=OMatrix.o[Mat_Y].z;
      vz.x:=OMatrix.o[Mat_Z].x;vz.y:=OMatrix.o[Mat_Z].y;vz.z:=OMatrix.o[Mat_Z].z;
      phi:=180;
      glMatrixMode(GL_ModelView);
      glLoadIdentity;
      glGetFloatV(GL_MODELVIEW_MATRIX,@temp.o);
      temp.o[Mat_X].x:=-1;temp.o[Mat_Y].y:=-1;temp.o[Mat_Z].z:=-1;
      WITH OMatrix.o[Mat_Pos] DO glTranslatef(x,y,z);
      Case RadioGroup2.ItemIndex Of
        0: Kreuzprodukt(vx,vy,vs);
        1: KreuzProdukt(vx,vz,vs);
        2: KreuzProdukt(vy,vz,vs);
      end;
      glRotatef(phi,vs.x,vs.y,vs.z);
      glMultMatrixf(@temp.o);
      //Punktspiegelung;
      With OMatrix.o[Mat_Pos] Do glTranslatef(-x,-y,-z);
      glGetFloatV(GL_MODELVIEW_MATRIX,@temp.o);
      EdFelderBesetzen(A,temp);
    end;
  end;
end;

procedure TForm1.RadioGroup3SelectionChanged(Sender: TObject);
begin
  RadioGroup2SelectionChanged(self)
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


procedure TForm1.BtFormMClick(Sender: TObject);
begin
   FormAMatrix.Visible:=TRUE;
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

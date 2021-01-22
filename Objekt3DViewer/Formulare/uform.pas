unit uForm;

{$MODE Delphi}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ExtCtrls, StdCtrls, ComCtrls, Menus, LMessages, Spin,uTurtleManager,uTurtle,
  uGrammatik, uBeleuchtung, uZeichnerBase, uZeichnerGruenesBlatt,uEditor_Grammatiken; {uGrammatiken}
type

  { TForm1 }

  TForm1 = class(TForm)
    BtPause: TButton;
    BtZoomP: TButton;
    BtZoomM: TButton;
    BtKameraReset: TButton;
    Button1: TButton;
    BT_Zurueck: TButton;
    BT_weiter: TButton;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    GraphikPanel: TPanel;
    hinzufuegen: TMenuItem;
    bearbeiten: TMenuItem;
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
    procedure BT_weiterClick(Sender: TObject);
    procedure BT_ZurueckClick(Sender: TObject);
    procedure hinzufuegenClick(Sender: TObject);
    procedure bearbeitenClick(Sender: TObject);
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
    procedure zeichnen();

  private    { Private-Deklarationen }
    aktiv:procedure (r:Real);
    r:Real;
    liste_z:TList; //liste letzen der instanzen von o
    liste_w:TList; //liste letzen der instanzen von o die zurückgesetzt wurden
    v:CARDINAL;
    procedure standardturtel();
  public    { Public-Deklarationen }
    o:TTurtleManager;
    abstand_x,akt_x,akt_y,akt_z:REAL;
    procedure update_startkoords();
    procedure abstand_aendern(x_abstand:REAL);
  end;

var
  HauptForm: TForm1;


implementation
uses  uAnimation,uKamera, uKamObjektiv, uMatrizen, uGrammatiken;
{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  width:=screen.width-310;
  height:=screen.Height-200;
  GraphikPanel.Height:=height-50;
  GraphikPanel.Width:=width-150;
  Trackbar1.width:=width-300;
  Trackbar1.top:=height-25;
  BT_Zurueck.top:=height-25;
  BT_weiter.top:=height-25;
  Label8.Top:=height-25;
  v:=TrackBar1.Position;
  //uObjekt.objekt:=n;
  KameraInit(GraphikPanel);
  liste_z:=TList.Create();
  liste_w:=TList.Create();
  abstand_x:=2;
  akt_x:=0;
  akt_y:=0;
  akt_z:=0;
  standardturtel;
  KameraStart(uAnimation.ozeichnen);
  Timer1.Enabled:=FALSE;
  ObjKOSinitialisieren;
 // kartToKugel;
end;
procedure TForm1.abstand_aendern(x_abstand:REAL);
VAR i:CARDINAL;
begin
  abstand_x:=x_abstand;
  akt_x:=0;
  akt_y:=0;
  akt_z:=0;
  for i:=0 to (o.turtleListe.Count)-1 do
      begin
       o.turtleListe[i].setzeStartPunkt(akt_x,akt_y,akt_z);
       update_startkoords();
      end;
  zeichnen();
end;

procedure TForm1.update_startkoords();
begin
   //erweiterung für mehr dimensionen möglich
   akt_x:=akt_x+abstand_x;
end;

procedure TForm1.zeichnen();
begin
  KameraStart(uAnimation.ozeichnen);
end;
procedure TForm1.standardturtel();
VAR //o: TTurtleManager;
    turtle: TTurtle;
    gram: TGrammatik;
    zeichenPara: TZeichenParameter;
begin
    o := TTurtleManager.Create;
    // So wird die hinzufuegen erstellt
    gram := TGrammatik.Create;                          // initialisieren der hinzufuegen-Klass
    gram.axiom := 'F';                                  // axiom einstellen
    gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);   // 18%ige Chance fuer diese Einsetzung
    gram.addRegel('F','B',2.01);                        // 2.01%ige Chance fuer diese Einsetzung
    gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',79.99);  // 79.99%ige Chance fuer diese Einsetzung
    //gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F');      // 100%ige Chance fuer diese Einsetzung

    // einistellen vom winkel und der rekursionsTiefe
    zeichenPara.winkel := 47.5;
    zeichenPara.rekursionsTiefe := 5;

    // erster Baum (index 0)
    zeichenPara.setzeStartPunkt(0,0,0);
    turtle := TTurtle.Create(gram, TZeichnerBase.Create(zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(0,false);  // setzten der Sichtbarkeit der Turtle

    // zweiter Baum (index 1)
    zeichenPara.setzeStartPunkt(2,0,0);
    turtle := TTurtle.Create(gram, TZeichnerGruenesBlatt.Create(zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

    // dritter Baum (index 2)
    zeichenPara.setzeStartPunkt(-2,0,0);
    turtle := TTurtle.Create(gram, TZeichnerGruenesBlatt.Create(zeichenPara));
    o.addTurtle(turtle);
    //o.setzeSichtbarkeit(2,false);  // setzten der Sichtbarkeit der Turtle

    // beides das gleiche (entfernt beide die Turtle an index 2)
    // o.entferneTurtle(turtle);
    // o.entferneTurtleAn(2);

    // modifizieren der rekursions Tiefe und Winkel der Turtle an index 0
    turtle.rekursionsTiefe := 4;
    turtle.winkel := 15;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Kameradestroy(GraphikPanel);
end;
procedure TForm1.hinzufuegenClick(Sender: TObject);
begin
   aGrammatiken.Show;
end;

procedure TForm1.bearbeitenClick(Sender: TObject);
begin
   EditorForm.BT_updateClick(self);
   EditorForm.Show;
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
//Alle interaktionen mit o überarbeiten
procedure TForm1.BT_weiterClick(Sender: TObject);  //weiter bt nur sichtbar wenn sinvoll
begin
  //stellt die letzte zurückgenommene änderung wieder her
end;

procedure TForm1.BT_ZurueckClick(Sender: TObject);
begin
  //nimmt letzte änderung am object o zurück. Maximal 20 mal.
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

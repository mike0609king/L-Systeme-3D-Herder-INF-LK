unit uForm;

{$MODE Delphi}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ExtCtrls, StdCtrls, ComCtrls, Menus, LMessages, Spin,uTurtleManager,
  uGrammatik, uBeleuchtung, uZeichnerBase, uZeichnerGruenesBlatt,uEditor_Grammatiken, LCLType, uscaledpi; {uGrammatiken}
type

  { TForm1 }

  TForm1 = class(TForm)
    BtHochKreis1: TButton;
    BtLinksKreis1: TButton;
    BtRechtsKreis1: TButton;
    BtRunterKreis1: TButton;
    BtPause: TButton;
    BtZoomP: TButton;
    BtZoomM: TButton;
    BtKameraReset: TButton;
    BT_Zurueck: TButton;
    BT_weiter: TButton;
    Button1: TButton;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    GraphikPanel: TPanel;
    hinzufuegen: TMenuItem;
    bearbeiten: TMenuItem;
    optionen: TMenuItem;
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
    procedure BtHochKreis1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtHochKreisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtHochKreisKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtLinksKreis1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtLinksKreisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtLinksKreisKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtRechtsKreis1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtRechtsKreisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtRechtsKreisKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtRunterKreis1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtRunterKreisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtKameraResetClick(Sender: TObject);
    procedure BtRunterKreisKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BT_weiterClick(Sender: TObject);
    procedure BT_ZurueckClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure hinzufuegenClick(Sender: TObject);
    procedure bearbeitenClick(Sender: TObject);
    procedure optionenClick(Sender: TObject);
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
    procedure update_sichtbarkeit_bt();
    procedure update_combobox();
  public    { Public-Deklarationen }
    aktuelle_turtle_nr:CARDINAL;
    o:TTurtleManager;
    max_gespeicherte_manager:CARDINAL;
    abstand_x,akt_x,akt_y,akt_z:REAL;
    maximaleStringLaenge:CARDINAL;
    procedure update_startkoords();
    procedure abstand_aendern(x_abstand:REAL);
    procedure push_neue_instanz(turtelmanager:TTurtleManager);
    procedure ordnen();
  end;

var
  HauptForm: TForm1;


implementation
uses  uAnimation,uKamera, uKamObjektiv, uMatrizen, uGrammatiken, uTurtle, uOptionen_form,uZeichnerInit;
{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  width:=screen.width-310;
  height:=screen.Height-200;
  GraphikPanel.Height:=height-50;
  GraphikPanel.Width:=width-150;
  Trackbar1.width:=width-400;
  Trackbar1.top:=height-50;
  BT_Zurueck.top:=height-50;
  BT_weiter.top:=height-50;
  Label8.Top:=height-50;
  //BtRunterKreis1.Top:=height-50;
  TrackBar1.Position:=25;
  v:=TrackBar1.Position;
  //uObjekt.objekt:=n;
  KameraInit(GraphikPanel);
  liste_z:=TList.Create();
  liste_w:=TList.Create();
  abstand_x:=2;
  max_gespeicherte_manager:=20; //muss getestet werden
  akt_x:=0;
  akt_y:=0;
  akt_z:=0;
  maximaleStringLaenge:=100000;
  standardturtel;
  aktuelle_turtle_nr:=0;
  //o:=Tturtlemanager.create();
  KameraStart(uAnimation.ozeichnen);
  update_combobox();
  Timer1.Enabled:=FALSE;
  ObjKOSinitialisieren;
  KeyPreview:= True;
  //ScaleDPI(Self, 192);
 // kartToKugel;
end;
procedure TForm1.FormShow(Sender: TObject);
begin
  WindowState := wsFullScreen;
end;

procedure TForm1.ordnen();
begin
  abstand_aendern(abstand_x);
end;

procedure TForm1.BtRunterKreisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_S) then
  begin
   aktiv:=KameraGrossKreisXRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
end;

procedure TForm1.BtHochKreisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_W) then
  begin
   aktiv:=KameraGrossKreisXRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
end;

procedure TForm1.BtHochKreis1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraUmTurtleXRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.BtHochKreisKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Timer1.Enabled:=FALSE;
end;

procedure TForm1.BtLinksKreis1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraUmTurtleYRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.BtLinksKreisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_A) then
  begin
     aktiv:=KameraGrossKreisYRotieren;
     r:=-0.1*v;
     Timer1.Enabled:=True;
     Key:=0;
  end;
end;

procedure TForm1.BtLinksKreisKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Timer1.Enabled:=FALSE;
end;

procedure TForm1.BtRechtsKreis1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraUmTurtleYRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.BtRechtsKreisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_D) then
  begin
     aktiv:=KameraGrossKreisYRotieren;
     r:=0.1*v;
     Timer1.Enabled:=True;
     Key:=0;
  end;
end;

procedure TForm1.BtRechtsKreisKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Timer1.Enabled:=FALSE;
end;

procedure TForm1.BtRunterKreis1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   aktiv:=KameraUmTurtleXRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
end;

procedure TForm1.BT_weiterClick(Sender: TObject);  //weiter bt nur sichtbar wenn sinvoll
VAR nr:CARDINAL;hlob:TTurtleManager;
begin
  //stellt die letzte zurückgenommene änderung wieder her
  //achtung nimmt das ganze objekt
  //änderungen die dazwischen passiert sind...

  nr:=liste_w.Count-1;//letzte nr
  liste_z.add(o.copy());
  hlob:=TTurtleManager.Create;
  hlob:=liste_w[nr];
  liste_w.Delete(nr);
  o:=hlob;
  maximaleStringLaenge:=o.turtleListe[0].maximaleStringLaenge;
  update_sichtbarkeit_bt();
end;
procedure TForm1.update_sichtbarkeit_bt();
begin
   if liste_z.Count=0 then BT_Zurueck.Visible:=False
   else BT_Zurueck.Visible:=True;
   if liste_w.Count=0 then BT_Weiter.Visible:=False
   else BT_Weiter.Visible:=True;
end;

procedure TForm1.BT_ZurueckClick(Sender: TObject); //darf nicht eingeblendet sein, wenn nicht möglich
VAR nr:CARDINAL;hlob:TTurtleManager;
begin
  //nimmt letzte änderung am object o zurück. Maximal 20 mal.
  nr:=liste_z.Count-1;//letzte nr
  liste_w.add(o.copy());
  hlob:=TTurtleManager.Create;
  hlob:=liste_z[nr];
  liste_z.Delete(nr);
  o:=hlob;
  maximaleStringLaenge:=o.turtleListe[0].maximaleStringLaenge;
  update_sichtbarkeit_bt();
end;

procedure TForm1.update_combobox();
VAR i,anzahl:CARDINAL; name:string;
BEGIN
  ComboBox2.Items.Clear;
  anzahl:=(HauptForm.o.turtleListe.Count)-1;
  for i:=0 to anzahl do
      begin
         name:='Turtle'+inttostr(i);
         ComboBox2.Items.Add(name);
      end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
VAR i:CARDINAL; turtle:TTurtle; x:Real;
begin
  if ComboBox2.ItemIndex <> -1 then
  Begin
       i:=ComboBox2.ItemIndex ;
       turtle:=HauptForm.o.turtleListe[i];
       aktuelle_turtle_nr:=i;
       x:=turtle.StartPunkt.x;
     //  y:=turtle.StartPunkt.y;
     //  z:=turtle.StartPunkt.z;
       BtKameraResetClick(self);
       KamInEigenKOSVerschieben(x,0,0);
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if (Key = VK_S) then
  begin
   aktiv:=KameraZVersch;
   r:=0.01*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_A) then
  begin
     aktiv:=KameraXVersch;
     r:=-0.01*v;
     Timer1.Enabled:=True;
     Key:=0;
  end;
  if (Key = VK_D) then
  begin
     aktiv:=KameraXVersch;
     r:=0.01*v;
     Timer1.Enabled:=True;
     Key:=0;
  end;
  if (Key = VK_W) then
  begin
   aktiv:=KameraZVersch;
   r:=-0.01*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_Y) then
  begin
   aktiv:=KameraYVersch;
   r:=0.01*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_X) then
  begin
   aktiv:=KameraYVersch;
   r:=-0.01*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_J) then
  begin
   aktiv:=KameraUmTurtleYRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_I) then
  begin
   aktiv:=KameraUmTurtleXRotieren;
   r:=-0.1*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_L) then
  begin
   aktiv:=KameraUmTurtleYRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
  if (Key = VK_K) then
  begin
   aktiv:=KameraUmTurtleXRotieren;
   r:=0.1*v;
   Timer1.Enabled:=True;
   Key:=0;
  end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Timer1.Enabled:=FALSE;
end;

procedure TForm1.push_neue_instanz(turtelmanager:TTurtleManager);
VAR nr:CARDINAL;
begin
  nr:=liste_z.Count;
  //soll weiter noch verfügbar sein? oder muss sich gemerkt werden ob es sinn macht? ->erstmal nicht
  //liste_w zerstörern
  if nr=max_gespeicherte_manager then
  begin
     //liste_z[nr].Destroy; //alte Instanze löschen
     liste_z.Delete(nr);
  end;
  liste_z.add(o.copy());
  o:=turtelmanager;
  BT_Zurueck.Visible:=True;
  update_sichtbarkeit_bt();
  update_combobox();
end;
procedure TForm1.abstand_aendern(x_abstand:REAL);
VAR i:CARDINAL; turtlemanager:Tturtlemanager;
begin
  turtlemanager:=o.copy();
  abstand_x:=x_abstand;
  akt_x:=0;
  akt_y:=0;
  akt_z:=0;
  for i:=0 to (turtlemanager.turtleListe.Count)-1 do
      begin
       turtlemanager.turtleListe[i].setzeStartPunkt(akt_x,akt_y,akt_z);
       update_startkoords();
      end;
  push_neue_instanz(turtlemanager);
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
    turtle,turtle1: TTurtle;
    gram: TGrammatik;
    zeichnerInit: TZeichnerInit;
    zeichenPara: TZeichenParameter;
    para: TStringList;
begin
  //befindet sich jetzt in uForm.standardturtel

  o := TTurtleManager.Create;
  zeichnerInit := TZeichnerInit.Create;

  // So wird die Grammatik erstellt
  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(2)';                                  // axiom einstellen
  //gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F',18);   // 18%ige Chance fuer diese Einsetzung
  //gram.addRegel('F','B',2.01);                        // 2.01%ige Chance fuer diese Einsetzung
  //gram.addRegel('F','F&[+F&&F]&&F[-^^/^-F]F',79.99);  // 79.99%ige Chance fuer diese Einsetzung
  //gram.addRegel('F','F&[+F&&FB]&&F[-^^/^-FB]F');      // 100%ige Chance fuer diese Einsetzung
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung

  // einistellen vom winkel und der rekursionsTiefe
  zeichenPara.winkel := 47.5;
  zeichenPara.rekursionsTiefe := 3;

  // erster Baum (index 0)
  // zeichenPara.setzeStartPunkt(0,0,0);
  turtle := TTurtle.Create(
    gram,
    zeichnerInit.initialisiere('ZeichnerSchrittlaenge',zeichenPara)
  );
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(0,false);  // setzten der Sichtbarkeit der Turtle

  // gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  // gram.axiom := 'F(7)';                                  // axiom einstellen
  // gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  // zweiter Baum (index 1)
  // zeichenPara.setzeStartPunkt(2,0,0);
  // turtle := TTurtle.Create(
  //  gram,
  //  zeichnerInit.initialisiere('ZeichnerFarben',zeichenPara)
  // );
  // o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(1;2)&[+F(2)&&F(3)F(4)]&&F(5)[-^^/^-F(0)F(7)]F(8)';                                  // axiom einstellen
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  gram.addRegel('F(c;l)','F(c;l)&[+F(c;l)&&F(c;l)F(c;l)]&&F(c;l)[-^^/^-F(c;l)F(c;l)]F(c;l)');      // 100%ige Chance fuer diese Einsetzung
  zeichenPara.setzeStartPunkt(2,0,0);
  turtle := TTurtle.Create(
    gram,
    zeichnerInit.initialisiere('ZeichnerFarbenUndSchrittlaenge',zeichenPara)
  );
  para := TStringList.Create;
  para.add('14'); para.add('14');
  para.add('14'); para.add('14');
  para.add('14'); para.add('14');
  para.add('14'); para.add('14'); para.add('14');
  turtle.aendereParameter(para);
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(1)&[+F(2)&&F(3)F(4)]&&F(5)[-^^/^-F(0)F(7)]F(8)';                                  // axiom einstellen
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  zeichenPara.setzeStartPunkt(-2,0,0);
  turtle := TTurtle.Create(
    gram,
    zeichnerInit.initialisiere('ZeichnerFarben',zeichenPara)
  );
  para := TStringList.Create;
  //para.add('14'); para.add('14'); para.add('14'); para.add('14');
  //para.add('14'); para.add('14'); para.add('14'); para.add('14');
  turtle.aendereParameter(para);
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle

  gram := TGrammatik.Create;                          // initialisieren der Grammatik-Klass
  gram.axiom := 'F(14)&[+F(14)&&F(14)F(14)]&&F(14)[-^^/^-F(14)F(14)]F(14)';                                  // axiom einstellen
  gram.addRegel('F(c)','F(c)&[+F(c)&&F(c)F(c)]&&F(c)[-^^/^-F(c)F(c)]F(c)');      // 100%ige Chance fuer diese Einsetzung
  zeichenPara.setzeStartPunkt(-4,0,0);
  turtle := TTurtle.Create(
    gram,
    zeichnerInit.initialisiere('ZeichnerFarben',zeichenPara)
  );
  o.gibTurtle(2, turtle1);
  turtle.aendereParameter(turtle1.gibParameter);
  o.addTurtle(turtle);
  // o.setzeSichtbarkeit(1,false);  // setzten der Sichtbarkeit der Turtle


  // dritter Baum (index 2)
  // zeichenPara.setzeStartPunkt(5,0,0);
  // turtle := TTurtle.Create(gram, zeichnerInit.initialisiere(
  // zeichnerInit.gibZeichnerListe[1],zeichenPara));
  // o.addTurtle(turtle);

  // vierter Baum (index 3)
  // o.gibTurtle(1, turtle);
  // o.setzeSichtbarkeit(1,true);  // setzten der Sichtbarkeit der Turtle
  // turtle1 := turtle.copy;
  // turtle1.setzeStartPunkt(-4,0,0);
  // o.addTurtle(turtle1);
  // o.setzeSichtbarkeit(3,true);  // setzten der Sichtbarkeit der Turtle

  // turtle.speichern('h.json');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Kameradestroy(GraphikPanel);
end;
procedure TForm1.hinzufuegenClick(Sender: TObject);
begin
  if aGrammatiken.WindowState=wsMinimized then aGrammatiken.WindowState:=wsNormal
  else aGrammatiken.Show;
end;

procedure TForm1.bearbeitenClick(Sender: TObject);
begin
  EditorForm.BT_updateClick();
  if EditorForm.WindowState=wsMinimized then EditorForm.WindowState:=wsNormal
  else EditorForm.Show;
end;

procedure TForm1.optionenClick(Sender: TObject);
begin
  Optionen_Form.update_bt();
  if Optionen_Form.WindowState=wsMinimized then Optionen_Form.WindowState:=wsNormal
  else Optionen_Form.Show;
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

procedure TForm1.BtRunterKreisKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Timer1.Enabled:=FALSE;
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

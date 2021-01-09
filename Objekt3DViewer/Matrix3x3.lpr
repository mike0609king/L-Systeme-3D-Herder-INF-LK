program Matrix3x3;

{$MODE Delphi}

uses
  Forms, Interfaces,
  //UNeu in 'Formulare\UNeu.pas' {HauptForm},
  uForm in 'Formulare\uFrom.pas' {HauptForm},
  AMatrix in 'Formulare\AMatrix.pas' {FormAMatrix},
  MMatrix in 'Formulare\MMatrix.pas' {FormMMatrix},
  Rotation in 'Formulare\Rotation.pas' {FormRot},
  Umrechnung in 'Formulare\Umrechnung.pas' {FormKart2Kugel},
  Umrechnung2 in 'Formulare\Umrechnung2.pas' {FormKugel2Kart},
  Streckung in 'Formulare\Streckung.pas' {FormStreck},
  Verschiebung in 'Formulare\Verschiebung.pas' {FormVer},
  Scherung in 'Formulare\Scherung.pas' {FormScher},
  uMatrizen in '..\Graphik\uMatrizen.pas',
  uKamObjektiv in '..\Graphik\uKamObjektiv.pas',
  uRenderer in '..\Graphik\uRenderer.pas',
  uBeleuchtung in '..\Graphik\uBeleuchtung.pas',
  uAnimation in 'uAnimation.pas',
  uturtle in 'uObjekt.pas';

//uOctree in '..\Octree\uOctree.pas';

begin
  Application.Initialize;
  Application.CreateForm(TForm1, HauptForm);
  Application.CreateForm(TForm3, FormMMatrix);
  Application.CreateForm(TForm2, FormAMatrix);
  Application.CreateForm(TForm4, FormRot);
  Application.CreateForm(TForm5, FormKart2Kugel);
  Application.CreateForm(TForm6, FormKugel2Kart);
  Application.CreateForm(TForm7, FormStreck);
  Application.CreateForm(TForm8, FormVer);
  Application.CreateForm(TForm9, FormScher);
  Application.Run;
end.

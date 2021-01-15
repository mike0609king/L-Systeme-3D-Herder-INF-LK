unit uBeleuchtung;

{$MODE Delphi}

interface
procedure LichtAn(kamera:BOOLEAN);
implementation
uses dglOpenGL,uMatrizen;

procedure LichtAn(kamera:BOOLEAN);
  const
    //mat_specular   : Array[0..3] of GlFloat = (0.80, 0.72, 0.21, 1.0);
    //mat_shininess  : Array[0..0] of GlFloat = (83.2);
    //mat_ambient    : Array[0..3] of GlFloat = (0.25, 0.22, 0.03, 1.0);
    //mat_diffuse    : Array[0..3] of GlFloat = (0.35, 0.31, 0.09, 1.0);


   {   mat_specular   : Array[0..3] of GlFloat = (0.3, 0.3, 0.3, 1.0);
    mat_shininess  : Array[0..0] of GlFloat = (50.0);
    mat_ambient    : Array[0..3] of GlFloat = (0.4, 0.4, 0.4, 1.0);
    mat_diffuse    : Array[0..3] of GlFloat = (0.8, 0.8, 0.8, 1.0);
    }
    light_positionk: Array[0..3] of GlFloat = (0.0, 0.0, 0.0, 1.0);
    light_positionw: Array[0..3] of GlFloat = (5.0, 3.0, 1.0, 1.0);  //vorher w=0.0
    light_ambient  : Array[0..3] of GlFloat = (0.5, 0.5, 0.5, 1.0);
    light_diffuse  : Array[0..3] of GlFloat = (0.9, 0.9, 0.9, 1.0);


begin
  glMatrixMode(GL_ModelView);
    glLoadIdentity;
    UebergangsmatrixObjekt_Welt_laden;
    IF NOT kamera THEN UebergangsmatrixWelt_Kamera_laden;
    //glMaterialfv(GL_FRONT, GL_SPECULAR,  @mat_specular[0]);
    //glMaterialfv(GL_FRONT, GL_SHININESS, @mat_shininess[0]);
    //glMaterialfv(GL_FRONT, GL_AMBIENT,   @mat_ambient[0]);
    //glMaterialfv(GL_FRONT, GL_DIFFUSE,   @mat_diffuse[0]);
    IF kamera then
    begin
       glLightfv(GL_LIGHT0, GL_AMBIENT,  @light_ambient[0]);
       glLightfv(GL_LIGHT0, GL_DIFFUSE,  @light_diffuse[0]);
       glLightfv(GL_LIGHT0, GL_POSITION, @light_positionk[0]);
    end
    else
    begin
       glLightfv(GL_LIGHT1, GL_AMBIENT,  @light_ambient[0]);
       glLightfv(GL_LIGHT1, GL_DIFFUSE,  @light_diffuse[0]);
       glLightfv(GL_LIGHT1, GL_POSITION, @light_positionw[0]);
    end;
    //glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_LIGHTING);
    IF kamera THEN glEnable(GL_LIGHT0) ELSE glEnable(GL_Light1);
    glEnable(GL_Normalize);
end;
end.

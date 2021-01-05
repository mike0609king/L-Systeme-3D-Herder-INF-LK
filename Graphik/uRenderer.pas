unit uRenderer;

{$MODE Delphi}

interface
uses ExtCtrls,Windows,Forms;
Type ProcRenderer=Procedure;
procedure RendererInit(p:TPanel);
procedure RendererDestroy(p:TPanel);
procedure RendererAktivieren;
procedure RendererDeaktivieren;
procedure RendererAktualisieren;
procedure RendererStart(animation:ProcRenderer);

implementation
uses dglOpenGL;
type THilfsKruecke=class
         anim:ProcRenderer;
         null:ProcRenderer;
         procedure AnimationsKruecke(Sender:TObject;var Done:BOOLEAN);
         procedure AnimationsNull(Sender:TObject;var Done:BOOLEAN);
     END;

var dc:HDC;RC:HGLRC;
VAR t:THilfsKruecke;

procedure RendererDestroy(p:TPanel);
begin
  DeactivateRenderingContext;
  DestroyRenderingContext(RC);
  ReleaseDC(p.Handle, DC);
end;
procedure RendererAktivieren;
begin
  Application.OnIdle:=t.AnimationsKruecke;
end;
procedure RendererDeaktivieren;
begin
  Application.OnIdle:=t.AnimationsNull;
end;

procedure RendererInit(p:TPanel);
begin
  DC:= GetDC(p.Handle);
  RC:= CreateRenderingContext( DC,
                               [opDoubleBuffered],
                               32,
                               24,
                               0,0,0,
                               0);
  ActivateRenderingContext(DC, RC);
end;

procedure RendererAktualisieren;
begin
   SwapBuffers(DC);
   glEnable(gl_depth_test);
   glDepthFunc(GL_LEqual);
   //glDepthFunc(GL_Less);
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;

procedure RendererStart(animation:ProcRenderer);
begin
  t.anim:=animation;
  application.OnIdle := t.AnimationsKruecke;
end;

procedure THilfsKruecke.AnimationsKruecke(Sender:TObject;var Done:BOOLEAN);
begin
   done:=false;
   anim;   //Aufruf der eigentlichen Animation; kann geändert werden.
   RendererAktualisieren;
end;

procedure THilfsKruecke.AnimationsNull(Sender:TObject;var Done:BOOLEAN);
begin
   done:=true;
end;


begin
   t:=THilfskruecke.Create;
end.

unit uStringEntwickler;

{$H+}
interface

uses
  Classes, SysUtils, fgl, uGrammatik;

type TCardinalList = TFPGList<Cardinal>;

type TStringEntwickler = class
  private
    FGrammatik: TGrammatik;
    { Dieser Speichert den entwickelten String. Wenn es Parameter gibt, so enthaelt dieser
      Platzhalter fuer die tatsaechlichen Zahlen die als Parameter reingegeben werden. }
    FEntwickelterString: String;
    { Das ist der tatsaechlichen gezeichneter String. }
    FZuZeichnenderString: String;
    { Dieser Wert MUSS ein vielfaches von 10 sein.
      Dieser Wert (geteilt durch 100) bestimmt die Anzahl der Nachkommastellen, die
      beim zufaelligen bestimmen des Strings beruecksichtigt werden. }
    FMaximalerZufallsraum: Cardinal; 

    // getter-Funktionen fuer properties
    { Rueckgabe: Gibt zurueck, ob dieser Buchstabe ueberhaupt existiert und dem nach ersetzt
      werden kann. Wenn false zurueckgegeben wurde, so kann dieser string ueberhaupt nicht
      ersetze werden. Demnach steht auch kein sinvoller wert in der Variable ret.}
    function gibEinzusetzendenString(c: String; var ret: String) : Boolean;
    function gibAxiom : String;

    { Aufgabe: Die Zufaelligkeitsraeume werden als Cardinal gespeichert. Hierbei wird
      der Fliesskommawert ab dem log_10(FMaximalerZufallsraum)-2 ten Wert verworfen. Wir nehmen 
      also nicht mehr bei der Zufaelligkeit ruecksicht darauf. }
    function convertiereRealZuCardinal(wert: Real) : Cardinal;
    { Aufgabe: Zu zeichnender String wird auf den Stand von entwickelterString mit Einsetzung 
      von Werten gebracht. Dieser String besitzt wie Werte, mit welchen gezeichnet werden soll. }
    procedure aktualisiereZuZeichnendenString;
  public
    constructor Create(gram: TGrammatik); overload;
    constructor Create(gram: TGrammatik; entwickelterS: String); overload; // review!!

    destructor Destroy; override;

    property axiom: String read gibAxiom;
    property regeln: TRegelDictionary read FGrammatik.regeln;
    property entwickelterString: String read FEntwickelterString;
    property zuZeichnenderString: String read FZuZeichnenderString;

    { Aufgabe: Hier wird eine Liste von Parametern reingegeben. Damit kann man die Zahlenwerte
      der Parameter aendern. Wenn man im Axiom insgesamt anz_Ax Zahlenwerte aufgelistet hat, so MUSS
      die Laenge der Liste auch anz_Ax sein. }
    procedure aendereParameter(para: TStringList);

    { Aufgabe: Entwickelt den String gemaess der gegebenen Grammatik bis zur
      rekursions Tiefe, die angegeben wurde.}
    procedure entwickeln(rekursionsTiefe: Cardinal);
    function copy : TStringEntwickler;
end;

implementation

constructor TStringEntwickler.Create(gram: TGrammatik);
begin
  randomize;
  FGrammatik := gram;
  FEntwickelterString := '';
  FZuZeichnenderString := '';
  // es werden vier stellen nach dem Komma beruecksichtigt
  FMaximalerZufallsraum := 100 * 10000; 
end;

constructor TStringEntwickler.Create(gram: TGrammatik; entwickelterS: String);
begin
  randomize;
  FGrammatik := gram;
  FEntwickelterString := entwickelterS;
  aktualisiereZuZeichnendenString;
  // es werden vier stellen nach dem Komma beruecksichtigt
  FMaximalerZufallsraum := 100 * 10000; 
end;

destructor TStringEntwickler.Destroy;
begin
  FreeAndNil(FGrammatik);
  FreeAndNil(FEntwickelterString);
  FreeAndNil(FZuZeichnenderString);
  FreeAndNil(FMaximalerZufallsraum);
end;

function TStringEntwickler.gibEinzusetzendenString(c: String; var ret: String) : Boolean;
var data: TRegelProduktionsseitenListe;
    prefix: TCardinalList;
    i: Cardinal;
    zufaelligerWert: Cardinal;
  function upper_bound(gesucht: Cardinal) : Cardinal;
  var a, b, m: Cardinal;
  begin
    a := 0; b := prefix.Count-1;
    while a <= b do
    begin
      m := (a+b) div 2;
      if prefix[m] = gesucht then exit(m);
      if prefix[m] < gesucht then a := m+1
      else b := m-1;
    end;
    { Wir koennen uns sicher sein, dass der Index von b gueltig ist, 
      da wir nur Werte suchen werden, die nicht groesser, als der groesste
      Wert ist. }
    result := b;
  end;
begin
  if FGrammatik.regeln.TryGetData(c,data) then
  begin
    prefix := TCardinalList.Create;
    prefix.add(0);
    for i := 1 to data.Count do
    begin
        prefix.add(prefix[i-1]+convertiereRealZuCardinal(data[i-1].zufaelligkeit));
    end;
    zufaelligerWert := random(FMaximalerZufallsraum)-1;
    ret := data[upper_bound(zufaelligerWert)].produktion;
    exit(true);
  end;
  result := false;
end;

function TStringEntwickler.gibAxiom : String;
begin
  result := FGrammatik.axiom;
end;

function TStringEntwickler.convertiereRealZuCardinal(wert: Real) : Cardinal;
begin
  result := trunc(wert * (FMaximalerZufallsraum div 100));
end;

procedure TStringEntwickler.aktualisiereZuZeichnendenString;
var i: Cardinal; tmp_string: String;
begin
  FZuZeichnenderString := '';
  i := 1; 
  while (i <= length(entwickelterString)) do
  begin
    FZuZeichnenderString += entwickelterString[i];
    if (i <> length(entwickelterString) - 1) and 
    (entwickelterString[i+1] = '(') then
    begin
      inc(i); 
      while (true) do
      begin
        if (entwickelterString[i] = ';') then 
        begin
          FZuZeichnenderString += (FGrammatik.variableZuWert[tmp_string]) + ';'; 
          tmp_string := ''; inc(i); continue;
        end
        else if (entwickelterString[i] = ')') then 
        begin
          FZuZeichnenderString += (FGrammatik.variableZuWert[tmp_string]) + ')'; 
          tmp_string := ''; break;
        end
        else if (entwickelterString[i] = '(') then 
        begin
          FZuZeichnenderString += '('; tmp_string := ''; inc(i); continue;
        end;
        tmp_string += entwickelterString[i]; 
        inc(i);
      end;
    end;
    inc(i);
  end;
end;

procedure TStringEntwickler.aendereParameter(para: TStringList);
begin
  FGrammatik.aendereParameter(para);
  aktualisiereZuZeichnendenString;
end;


procedure TStringEntwickler.entwickeln(rekursionsTiefe: Cardinal);
  function toSmallLetter(letter: Char) : Char;
  var letterAsc: Cardinal;
  begin
    letterAsc:=Ord(letter);
    letterAsc:=letterAsc+32;
    result:=Chr(letterAsc);
  end;

  procedure entw(tiefe: Cardinal; s: String);
  var i,j: Cardinal;
      data,tmp_string,links,letters: String;
      paraList: TStringList;
      rechteSeiteGefunden: Boolean;
      smLetter: Char;
  begin
    i := 1; 
    while (i <= length(s)) do
    begin
      links := s[i]; paraList := TStringList.Create; 
      // parameter Liste richtig initialisieren (links = '<Buchstabe>(' wenn 
      // length(paraList) > 0)
      if (i <> length(s) - 1) and (s[i+1] = '(') and (tiefe <> 0) then
      begin
        inc(i); 
        while (true) do
        begin
          if (s[i] = ';') then 
          begin
            paraList.add(tmp_string); tmp_string := '';
            inc(i); continue;
          end
          else if (s[i] = ')') then 
          begin
            paraList.add(tmp_string); tmp_string := ''; break;
          end
          else if (s[i] = '(') then 
          begin
            tmp_string := ''; links := links + '(';
            inc(i); continue;
          end;
          tmp_string := tmp_string + s[i]; inc(i);
        end;

        // rekonstruktion der rechten Seite
        smLetter := toSmallLetter(links[1]);
        for j := 1 to paraList.Count do
        begin
          letters := IntToStr(j) + smLetter;
          while length(letters) < 4 do letters:='0'+letters;
          links := links + letters;
          if (j = paraList.Count) then links := links + ')'
          else links := links + ';';
        end;
      end;

      rechteSeiteGefunden := gibEinzusetzendenString(links,data);
      if (tiefe <> 0) and (rechteSeiteGefunden) and (paraList.Count > 0) then
      begin
        // Ersetzung der Variablen
        smLetter := toSmallLetter(links[1]);
        for j := 0 to paraList.Count - 1 do
        begin
          letters := IntToStr(j+1) + smLetter;
          while length(letters)<4 do letters:='0'+letters;
          tmp_string:=paraList[j];
          data := StringReplace(data,letters,paraList[j],[rfReplaceAll]);
        end;
        entw(tiefe-1,data);
      end
      else if (tiefe <> 0) and (rechteSeiteGefunden) and (paraList.Count = 0) then entw(tiefe-1,data)
      else FEntwickelterString += s[i];
      inc(i);
    end;
    FreeAndNil(paraList);
  end;
begin
  FEntwickelterString := '';
  entw(rekursionsTiefe,FGrammatik.axiom);
  aktualisiereZuZeichnendenString;
end;

function TStringEntwickler.copy : TStringEntwickler;
var tmp_string: String;
begin
  tmp_string := system.Copy(
    FEntwickelterString,
    1,
    length(FEntwickelterString)
  );
  result := TStringEntwickler.Create(
    FGrammatik.copy,
    tmp_string
  );
end;

end.


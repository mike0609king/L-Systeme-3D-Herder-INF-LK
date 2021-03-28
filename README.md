# L-Systeme in 3D

## Installation
### OS-Version
Das Programm wird auf einem 64-bit System funktionieren. Bei einem 32-bit
System könnte es schwieriger werden, da in diesem Programm ein Int64 benutzt wird.
### Compilieren
Der Code für das Projekt ist im src Ordener. In [src/Objekt3DViewer](src/Objekt3DViewer) ist die Datei, die lpr-Datei, 
welche man mit Lazarus öffnen kann. Dann muss nur nochmal kompiliert werden.

## Information zur Nutzung
In dem [doc](doc/)-Ordner befinden sich einige zusätzlichen Informationen zum Projekt.

## Zur Vollständigkeit des Projekts
In der Form wurden viel Exception-Handling implementiert, jedoch könnten einige Sachen nicht
berücksichtigt worden sein. Demnach ist es möglich, dass bestimmte Eingaben trotzdem zu einem 
Programmabsturz führen. Wenn dies der Fall ist, einfach kurz bei "Issues" melden. Sachen, die nicht 
mehr implementiert werden konnten oder auf die man achten sollte, wenn man das Programm nutzt, sind 
also in "Issues" einlesbar und werden noch gefixt.

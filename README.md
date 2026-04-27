# YDKJ4 – Windows 10/11 Fix + Online-Modus: Rebirth

## Installation

1. Lade das Spiel herunter:  
   [You Don't Know Jack 4 herunterladen](https://ftp.ydkjarchive.com/get?file=ydkj4de_dej)

2. Entpacke das Archiv und starte **Setup.exe**.

3. Lade die ZIP-Datei aus diesem Repository herunter.

4. Kopiere alle Dateien aus der ZIP in den Spielordner und ersetze die vorhandenen Dateien.

## Warum ein eigener Launcher?

Das Originalspiel nutzt die **Northcode SWF Studio 2003**-Hülle, die `Flash.ocx` per COM aus der Windows-Registrierung lädt und die VB6-Laufzeitumgebung benötigt. Auf Windows 10/11 ist Flash seit 2021 nicht mehr standardmäßig registriert; eine systemweite Registrierung benötigt Administratorrechte und kann mit anderen Anwendungen kollidieren.

Der **YDKJ 4 Launcher** ist eine kompakte C++-Implementierung, die das Flash-ActiveX-Objekt direkt aus dem Spielordner hostet — ohne Registrierung, ohne VB6, ohne Adminrechte.

| | Original `YDKJ 4.exe` | `YDKJ 4 Launcher.exe` |
|---|---|---|
| Flash.ocx-Registrierung | systemweit (Admin) | lokal in `Deflasher\Flash.ocx` |
| VB6-Laufzeitumgebung (MSVBVM60.DLL) | erforderlich | nicht nötig |
| Auflösungsauswahl | nicht vorhanden | beim Start (gespeichert in `Deflasher\app.ini`) |
| Kompatibilitätsmodus auf Win10/11 | meist nötig | nicht nötig |
| Single-Instance-Schutz | ja | ja |

Die Spiellogik selbst (`engine.dat`, Fragen, Musik) bleibt unverändert. Der Launcher reicht die nötigen FSCommands des Originals (`FileSys2.WriteToFile`, `SysInfo.ConnectState`, `Mouse.SetNotify`, `Quit`) durch, sodass alle Spielfunktionen einschließlich Online-Lobby normal funktionieren.

## Dateistruktur nach Installation

```
<Spielordner>/
├── YDKJ 4 Launcher.exe       ← starten
├── YDKJ 4.exe                ← Original, lauffähig, zur Sicherheit aufgehoben
├── engine.dat                ← modifizierte Engine
├── lib/mod/lobby.dat         ← modifizierte Lobby
└── Deflasher/
    ├── Flash.ocx             (lokale Kopie, keine Registrierung nötig)
    ├── launcher.dat          (UI für Auflösungsauswahl)
    └── app.ini               (wird beim ersten Start erstellt)
```

## Bedienung

- **Beim ersten Start:** Auflösung wählen (Zifferntasten 1–8 oder mit der Maus klicken), mit ENTER bestätigen. Mit Leertaste wird „Beim nächsten Mal wieder fragen" umgeschaltet.
- **Beenden:** über das Spielmenü oder Alt+F4.
- **Auflösung später ändern:** `Deflasher\app.ini` löschen oder `AlwaysAsk=1` setzen.

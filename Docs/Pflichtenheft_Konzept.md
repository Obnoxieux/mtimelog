# Pflichtenheft/Konzept

## Einleitung

Die GNOME-Applikation [gtimelog](https://gtimelog.org/) bietet eine bewusst reduzierte Möglichkeit, die eigene Arbeitszeit im laufenden Betrieb zu erfassen. Das Design der App ist bewusst minimalistisch gehalten und bietet keine überladenen Features.

## Ausgangssituation

Eine äquivalente App für macOS ist dem Ersteller nicht bekannt. Es gibt auf dem Markt selbstverständlich zahlreiche Optionen mit ähnlichem Funktionsumfang, aber oft sehr viel umfangreicher und selten wirklich nativ.

## Zielsetzung

Es soll eine Applikation programmiert werden, die sich im Stil, minimalistischem Design und Funktionsumfang an *gtimelog* anlehnt, ohne eine reine Portierung zu sein. Nutzer können ihre täglichen Aufgaben über eine Benutzeroberfläche erstellen, dokumentieren, verwalten, versenden und visualisieren.

Die App wird nativ ausschließlich für macOS im Framework SwiftUI und der Programmiersprache Swift entwickelt. Die Nutzung soll komplett offline möglich sein, jegliche Synchronisationen von Daten sind optional.

Die Benutzeroberfläche wird in englischer Sprache umgesetzt.

Die Entwicklung soll quelloffen unter der GPL v3 öffentlich zugänglich stattfinden. Die Verteilung an Nutzende findet mittels signierten .dmg-Archiven statt, wenn sinnvoll möglich auch über den Mac App Store.

## Kernfeatures

### Aufbau

Die App gliedert sich in 3 Bereiche, die durch ein Spaltenlayout realisiert werden:

1. linke Seitenleiste: Anzeige der Arbeitstage. Nutzer können neue Arbeitstage, für die Zeiten festgehalten werden sollen, über einen Button hinzufügen.
2. mittlerer Hauptbereich: Nutzer erhalten eine Anzeige der Aufgaben für den gewählten Arbeitstag.
3. rechte Seitenleiste: Detailansicht. Nutzer können Detailinformationen über eine einzelne Aufgabe abrufen und diese bearbeiten.

### Basisstruktur einer Aufgabe

Eine Aufgabe hat:

- Projektbezeichnung (kurzer Identifikator)
- Beschreibung (längere Textform)
- Status (fester Wert aus `in Bearbeitung`, `abgeschlossen`, `blockiert` und `laufend`)
- Statuskommentar (weiterführende Info, warum die Aufgabe in diesem Status ist)
- Startzeit
- Endzeit

### Dokumentation von Tätigkeiten

Nutzer können pro Arbeitstag die durchgeführten Tätigkeiten dokumentieren. Arbeitstage, die dokumentiert werden sollen, können über eine Datumsauswahl gewählt werden. Für einen gewählten Arbeitstag können Aufgaben angelegt werden. Aufgaben befinden sich in unterschiedlichen Status und werden entsprechend farbkodiert angezeigt. Informationen über Aufgaben können sowohl unmittelbar angelegt werden als auch später hinzugefügt werden. Die Dauer der Tätigkeiten wird automatisch berechnet.

### Vorschlagfunktion für Projektbezeichnung

Die App verfügt eine Liste mit bisher verwendeten Projektbezeichnungen, die bei der Eingabe weiterer Aufgaben vorgeschlagen werden. Zusätzlich zu dieser automatischen Generierung ist diese Liste auch durch Nutzer editierbar.

### Visualisierung der Inhalte

Alle angezeigten Aufgaben und Tätigkeiten werden mit sinnvollen Graphen ergänzt, die subtil einen Mehrwert in der Auswertung liefern (z.B. Anteil der verbrauchten Zeit in Relation zur einstellbaren Gesamtdauer eines Arbeitstags).

### Runden von Zeiten

Es kann in Workflows erforderlich sein, die tatsächlich aufgewendete Zeit für Tätigkeiten auf glatte Werte zu runden. Die App bietet eine solche Option an. Die Optionen für die Rundung sind konfigurierbar (auf 30 min, auf 15 min...).

### Erstellung eines Reports

Alle Aufgaben eines Arbeitstages können in einem Textformat über die macOS-native Share-Funktion geteilt werden. Dabei werden die Aufgaben in einem übersichtlichen Format ausgespielt, das in der Basisversion fest konfiguriert ist. Im Report ist unmittelbar ersichtlich, in welchem Status sich eine Aufgabe befindet.

### Persistente Speicherung

Alle von der App erzeugten Daten werden lokal auf dem Gerät gespeichert und sind durchsuchbar. Für die Persistenz wird das Framework SwiftData verwendet (Abstraktion lokale SQLite-Datenbank).

### Export der Gesamtdaten

Alle Daten über Arbeitstage und Aufgaben können in einem Plain-Text-Format exportiert werden, um einen Wechsel von Diensten und die Wiederverwendbarkeit des Datenbestandes zu erleichtern.

## Features Ausbaustadium

### Deutsche Lokalisierung

Die Benutzeroberfläche steht auch auf Deutsch zur Verfügung.

### Plugin für Ausgabe Report

Bei der Generierung des Reports können benutzerdefinierte Formate angegeben werden, die bestimmen, wie die Aufgaben in Textform dargestellt werden.

### Synchronisation der Daten über Cloud-Dienste

Es werden Dienste implementiert, die es ermöglichen, die Daten der App über mehrere Geräte synchron und aktuell zu halten. Möglich wären z.B.:

- iCloud
- WebDAV
- Google Drive

etc. pp.

## Einschränkungen

Im Einklang mit den Unix-Designprinzipien soll die App folgende Features *nicht* leisten:

#### Kein Projektmanagement

Es gibt keine Möglichkeiten, Aufgaben tagesübergreifend zu verfolgen oder in einem höheren Detailgrad zu speichern sowie Auswertungen über aufgewendete Zeit durchzuführen
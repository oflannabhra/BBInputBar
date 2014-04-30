# BBInputBar

## Beschreibung
BBInputBar ist eine Erweiterung für die iOS-Tastatur, welche aus einem Bereich oberhalb der Tastatur besteht und eine beliebige Anzahl an Buttons enthält. So lässt sich die Standardfunktionalität der Tastatur um eigene Buttons erweitern. Die InputBar fügt sich nahtlos an die Tastatur an, standardmäßig sehen die Buttons in der Bar exakt so aus wie die Tastatur-Buttons.



## Benutzung
### Initialisierung
Die BDInputBar lässt sich auf verschiedene Art und Weise initialisieren. 

`- (instancetype)initWithButtonTitles:(NSArray*)buttonTitles;`

Die InputBar wird auf die Standardgröße `320.0 x 44.0` initialisiert, und mit `buttonTitles.count` Buttons befüllt, welche jeweils den entsprechenden Titel aus dem übergebenen `NSArray` erhalten.

`- (instancetype)initWithButtonImages:(NSArray*)buttonImages;`

Die InputBar wird auf die Standardgröße `320.0 x 44.0` initialisiert, und mit `buttonImages.count` Buttons befüllt, welche jeweils das entsprechende Bild aus dem übergebenen `NSArray` erhalten.

### BDInputBarDataSource



### BDInputBarDelegate



### Beispiel
	BDInputBar *inputBar = [[BDInputBar alloc] initWithTitles:@[@"-", @"_", @"@", @"&"]];
	self.textView.inputAccessoryView = inputBar;


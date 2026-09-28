# Bezpieczna kompartmentaryzacja stacji roboczej w środowisku akademickim: wykorzystanie Qubes OS w działaniach OSINT, programowaniu oraz bezpiecznej detonacji i weryfikacji prac studenckich

## Informacje bibliograficzne
* **Autor:** Przemysław Żarnecki
* **Afiliacja:** Akademia Techniczno-Informatyczna Nauk Stosowanych we Wrocławiu
* **Kontakt:** pzarnecki@protonmail.com
* **Status:** Artykuł naukowy przygotowywany do publikacji w Zeszytach Naukowych ATINS
* **Język publikacji:** polski

---

## Streszczenie
Przetwarzanie niezweryfikowanych danych, repozytoriów kodu oraz zewnętrznych zasobów sieciowych stanowi integralny element współczesnej pracy badawczo-dydaktycznej na wyższych uczelniach technicznych. Aktywności takie jak pozyskiwanie informacji jawnoźródłowych (OSINT), weryfikacja ofert rynkowych, instalacja zewnętrznych bibliotek narażonych na ataki typu *supply chain* oraz weryfikacja nadsyłanych przez studentów prac laboratoryjnych niosą wysokie ryzyko profilowania behawioralnego, infekcji stacji roboczej lub kompromitacji tożsamości kryptograficznej.

W niniejszym artykule przedstawiono architekturę bezpiecznej stacji roboczej opartej na hipernadzorcy typu 1 (Xen 4.17) oraz systemie operacyjnym Qubes OS 4.2. Zdefiniowano formalny model stref zaufania (*Academic Compartmentalization Framework* -- ACF), bezśladowy potok wywiadu jawnoźródłowego oparty na jednorazowych maszynach wirtualnych Whonix oraz autorski mechanizm *Zero-Trust Student Code Evaluation Pipeline* (ZT-SCEP). Zaproponowane rozwiązanie wykorzystuje magistralę Qubes RPC (`qrexec`) do zautomatyzowanej detonacji i kompilacji prac studenckich w odciętych od sieci maszynach efemerycznych (*Disposable VMs*).

Ewaluacja empiryczna potwierdziła wysoką ergonomię wdrożeniową (czas powołania środowiska testowego: 2,42 s, przepustowość magistrali pamięci współdzielonej `vchan`: 482 MB/s) oraz pełną odporność stacji bazowej na próby ucieczki kodu, pętle wyczerpujące zasoby (*fork bombs*) i ataki na łańcuch dostaw oprogramowania.

**Słowa kluczowe:** Qubes OS, kompartmentaryzacja, hipernadzorca Xen, OSINT, cyberbezpieczeństwo, detonacja kodu, qrexec, weryfikacja prac studenckich, ochrona prywatności, RODO.

---

## Struktura repozytorium

```text
.
├── bibliography.bib         # Źródła bibliograficzne (standard biblatex/biber)
├── figures/                 # Schematy architektoniczne i diagramy
├── main.tex                 # Główny plik źródłowy dokumentu LaTeX
├── README.md                # Dokumentacja projektu badawczego
├── scripts/
│   └── simulate_ztscep.py  # Skrypt do pomiarów cyklu życia maszyn i testów ZT-SCEP
└── sections/                # Rozdziały artykułu:
    ├── 01_wprowadzenie.tex
    ├── 02_przeglad_literatury.tex
    ├── 03_architektura_i_model.tex
    ├── 04_scenariusze_akademickie.tex
    ├── 05_ewaluacja_empiryczna.tex
    ├── 06_dyskusja_i_wdrozenie.tex
    └── 07_podsumowanie.tex
```

---

## Wymagania edytorskie i środowisko kompilacji

Dokument został sformatowany zgodnie z wytycznymi wydawniczymi ATINS:
* Format arkusza: A4, marginesy symetryczne 2,5 cm
* Krój pisma tekstu głównego: Liberation Serif (zamiennik metryczny Times New Roman), 12 pkt
* Interlinia: 1,5 (`\onehalfspacing`)
* Przypisy dolne: 10 pkt
* Silnik kompilacji: XeLaTeX (`fontspec`, `polyglossia`)
* Zarządzanie bibliografią: Biber / BibLaTeX (styl numeryczny)

### Procedura kompilacji

Do automatycznej kompilacji zalecane jest narzędzie `latexmk`:

```bash
latexmk -pdf -xelatex main.tex
```

Alternatywnie procedurę można wykonać sekwencyjnie:

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

Czyszczenie plików tymczasowych:

```bash
latexmk -c
```

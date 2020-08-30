# Granda Vortaro Esperanta-Ĉeĥa - GVEĈ
## Large Esperanto-Czech dictionary / Velký slovník esperantsko-český

Downloaded from http://www.esperanto.wz.cz/ (http://esperanto.wz.cz/Slovniky/GVECx_11_A.xlsx)

From [Úvod a návod 11](http://esperanto.wz.cz/Slovniky/Uvod%20a%20navod_11.doc):
>  Slovník lze volně využívat bez jakéhokoli omezení včetně dalšího zveřejňování v jiné úpravě nebo
>  využívání jeho slovní zásoby k automatickým překladům.

## Stardict format

Run following to generate stardict format (requires `xlsx2csv`, `ruby`, `python3`, `python3-stardicter` and `dictzip`):
```
$ ./gen-stardict.sh
```
Result can be downloaded from [releases](https://github.com/urde-graven/GVECx/releases) / Výsledek lze stáhnout z [vydání](https://github.com/urde-graven/GVECx/releases) / La rezulto elŝuteblas de la [eldonoj](https://github.com/urde-graven/GVECx/releases).

## How to inspect XLSX on Linux

For example use following to display original data using the [visidata](https://www.visidata.org/):
```
$ vd GVECx_11_A.xlsx
$ vd -f csv GVECx_11_A.csv
```

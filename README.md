# Granda Vortaro Esperanta-Ĉeĥa - GVEĈ
## Velký slovník esperantsko - český

Downloaded from http://www.esperanto.wz.cz/ (http://esperanto.wz.cz/Slovniky/GVECx_11_A.xlsx)

From [Úvod a návod 11](http://esperanto.wz.cz/Slovniky/Uvod%20a%20navod_11.doc):
>  Slovník lze volně využívat bez jakéhokoli omezení včetně dalšího zveřejňování v jiné úpravě nebo
>  využívání jeho slovní zásoby k automatickým překladům.

Run following to generate stardict format (requires `xlsx2csv`, `ruby`, `python3`, `python3-stardicter` and `dictzip`):
```
$ ./gen-stardict.sh
```

Run following to display the data using the `visidata`:
```
$ vd GVECx_11_A.xlsx
$ vd -f csv GVECx_11_A.csv
```

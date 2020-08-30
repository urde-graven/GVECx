#!/usr/bin/bash

# convert XLSX into CSV
xlsx2csv GVECx_11_A.xlsx GVECx_11_A.csv

# convert CSV into format of `svobodneslovniky' for python3-stardicter
./csv2sdgen.rb < GVECx_11_A.csv > sdgen.txt

# create stardict dictionary by python3-stardicter
rm stardict/*
./esperantoczech.py
mv stardict/README stardict/esperanto-czech.txt

# create archive for Android ColorDict and others
(cd stardict && tar -c esperanto-czech.* | bzip2 -9 > ../esperanto-czech.tar.bz2)
(cd stardict && tar -c czech-esperanto.* | bzip2 -9 > ../czech-esperanto.tar.bz2)

# compress dict data for desktop QStarDict and others
dictzip stardict/*.dict
# copy stardict/* for example to $HOME/.stardict/dic/
#cp stardict/* ~/.stardict/dic/


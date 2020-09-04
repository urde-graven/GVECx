#!/usr/bin/bash

# convert XLSX into CSV
xlsx2csv GVECx_11_A.xlsx GVECx_11_A.csv

# convert CSV into format of `svobodneslovniky' for python3-stardicter
./csv2stardicter.rb < GVECx_11_A.csv

# create stardict dictionary by python3-stardicter
rm -rf stardict out
mkdir -p stardict out
./stardicter-writer.py
mv stardict/README stardict/esperanto-czech.txt

# create archive for Android ColorDict and others
(cd stardict && tar -c esperanto-czech.*  | bzip2 -9 > ../out/esperanto-czech.tar.bz2)
(cd stardict && tar -c esperantox-czech.* | bzip2 -9 > ../out/esperantox-czech.tar.bz2)
(cd stardict && tar -c czech-esperanto.*  | bzip2 -9 > ../out/czech-esperanto.tar.bz2)

# compress dict data for desktop QStarDict and others
dictzip stardict/*.dict

# copy stardict/* for example to $HOME/.stardict/dic/
#cp stardict/* ~/.stardict/dic/

(cd stardict && tar -c * | xz -9 > ../out/stardict-esperanto-czech.tar.xz)

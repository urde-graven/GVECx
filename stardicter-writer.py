#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import io
from stardicter.base import StardictWriter

class EsperantoCzechWriter(StardictWriter):
    url = 'http://www.esperanto.wz.cz/'
    name = 'Velký slovník Esperantsko-Český'
    source = 'esperanto'
    target = 'czech'
    bidirectional = False

writer = EsperantoCzechWriter(file=io.open('esperanto-czech.txt', 'rb'))
writer.parse()
writer.write_dict('stardict')

class EsperantoXConventionCzechWriter(EsperantoCzechWriter):
    name = 'Velký slovník Esperantsko-Český x-spřežky'
    source = 'esperantox'

writer = EsperantoXConventionCzechWriter(file=io.open('esperantox-czech.txt', 'rb'))
writer.parse()
writer.write_dict('stardict')

class CzechEsperantoWriter(EsperantoCzechWriter):
    name = 'Velký slovník Česko-Esperantský'
    source = 'czech'
    target = 'esperanto'

writer = CzechEsperantoWriter(file=io.open('czech-esperanto.txt', 'rb'))
writer.parse()
writer.write_dict('stardict')


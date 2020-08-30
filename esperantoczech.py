#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import io
from stardicter.base import StardictWriter

class EsperantoCzechWriter(StardictWriter):
    url = 'http://www.esperanto.wz.cz/'
    name = 'Velký slovník Esperantsko-Český'
    source = 'esperanto'
    target = 'czech'

    def get_name(self, forward=True):
        if forward:
            return 'Velký slovník Esperantsko-Český'
        return 'Velký slovník Česko-Esperantský'

writer = EsperantoCzechWriter(file=io.open('sdgen.txt', 'rb'))
writer.parse()
writer.write_dict('stardict')


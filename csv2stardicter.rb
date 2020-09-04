#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
require 'csv'

RECODE = {
  'cx' => 'ĉ', 'cX' => 'ĉ', 'Cx' => 'Ĉ', 'CX' => 'Ĉ',
  'gx' => 'ĝ', 'gX' => 'ĝ', 'Gx' => 'Ĝ', 'GX' => 'Ĝ',
  'hx' => 'ĥ', 'hX' => 'ĥ', 'Hx' => 'Ĥ', 'HX' => 'Ĥ',
  'jx' => 'ĵ', 'jX' => 'ĵ', 'Jx' => 'Ĵ', 'JX' => 'Ĵ',
  'sx' => 'ŝ', 'sX' => 'ŝ', 'Sx' => 'Ŝ', 'SX' => 'Ŝ',
  'ux' => 'ŭ', 'uX' => 'ŭ', 'Ux' => 'Ŭ', 'UX' => 'Ŭ',
}

TRANSITIVITY = {
  't' => 'přech.',
  'n' => 'nepřech.',
}

DICT = {
  'a'   => 'Akademia Vortaro; ',
  'zam' => 'Zamenhof; ',
  'nv'  => 'Neologisma Glosaro; ',
  'n'   => 'Hron; ',
}

def recode str
  str.gsub(/[cghjsu]x/i, RECODE)
end

def write_line f, word1, word2, notes, spec_notes, dict
  if word1 =~ /^(.*?)\((.*)\)$/ # comment inside translated world
    word1      = $1.strip
    spec_notes = ' ' + spec_notes unless spec_notes.empty?
    spec_notes = recode($2) + spec_notes # word1 can be in x-convention
  end
  # remove dots from esperanto words
  word1 = word1.gsub(/(^\.|\.$)/, '') # .word.
  word2 = word2.gsub(/(?:^\.|\.$|\.( *\())/, "\\1") # .word. (comments)
  # from stardicter-format.en.md:
  #   "English word [TAB] Czech word [TAB] notes [TAB] special notes [TAB] translator’s name"
  f.puts "#{word1}\t#{word2}\t#{notes}\t#{spec_notes}\t#{dict}"
  word1
end

3.times { STDIN.gets } # skip headers

File.open 'esperanto-czech.txt',     'w' do |esperanto_czech|
  File.open 'esperantox-czech.txt',  'w' do |esperantox_czech|
    File.open 'czech-esperanto.txt', 'w' do |czech_esperanto|
      esperantox = {}

      csv = CSV.new(STDIN, nil_value: '')
      csv.each do |row|
        es1 = row[1].strip
        es2 = recode(es1)
        notes = row[2].strip.downcase.gsub(/[tn]/, TRANSITIVITY)
        unless (cat = row[3].strip).empty?
          notes << ' ' unless notes.empty?
          notes << "[#{cat}.]"
        end
        dict = row[5].downcase.gsub(/(a|zam|nv|n)/, DICT).strip
        dict.gsub!(/; *$/, '')
        spec_notes = recode(row[6].strip)
        row[4].strip.split(/[,;] /).each do |cs|
          write_line esperanto_czech, es2, cs,  notes, spec_notes, dict
          write_line czech_esperanto, cs,  es2, notes, spec_notes, dict
          esperantox[write_line(esperantox_czech, es1, cs, notes, spec_notes, dict)] = true unless es1 == es2
        end
      end
      csv.close

      esperantox.each_key do |es1|
        write_line esperantox_czech, es1, recode(es1), 'spř.', '', ''
      end
    end
  end
end


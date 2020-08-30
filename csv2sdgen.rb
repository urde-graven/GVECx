#!/usr/bin/env ruby
# CSV to sdgen from package python3-stardicter
require 'csv'

RECODE = {
  'cx' => 'ĉ',
  'Cx' => 'Ĉ',
  'jx' => 'ĵ',
  'Jx' => 'Ĵ',
  'gx' => 'ĝ',
  'Gx' => 'Ĝ',
  'hx' => 'ĥ',
  'Hx' => 'Ĥ',
  'sx' => 'ŝ',
  'Sx' => 'Ŝ',
  'ux' => 'ŭ',
  'Ux' => 'Ŭ',
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

def recode(str)
  str.gsub(/[cjghsu]x/, RECODE)
end

3.times { STDIN.gets } # skip headers

csv = CSV.new(STDIN, nil_value: '')
csv.each do |row|
  es1, spec_notes = row[1].strip, ''
  es1, spec_notes = $1.strip, $2 if es1 =~ /^(.*?)\((.*)\)$/
  es1.gsub!(/(^\.|\.$)/, '')
  es2 = recode(es1)
  es1 = nil if es1 == es2
  notes = row[2].strip.downcase.gsub(/[tn]/, TRANSITIVITY)
  unless (cat = row[3].strip).empty?
    notes << ' ' unless notes.empty?
    notes << "[#{cat}.]"
  end
  dict = row[5].downcase.gsub(/(a|zam|nv|n)/, DICT).strip
  dict.gsub!(/; *$/, '')
  unless (comments = row[6].strip).empty?
    spec_notes = '; ' unless spec_notes.empty?
    spec_notes << recode(comments)
  end
  row[4].strip.split(', ').each do |cs|
    # from svobodneslovniky:
    #   "English word [TAB] Czech word [TAB] notes [TAB] special notes [TAB] translator’s name"
    puts "#{es2}\t#{cs}\t#{notes}\t#{spec_notes}\t#{dict}"
    puts "#{es1}\t#{cs}\tspř.\t{eo #{es2}}\t" if es1 # variant with `spřežky'
  end
end
csv.close


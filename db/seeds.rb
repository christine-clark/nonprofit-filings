# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke", movie: movies.first)

include Parsers

FILING_URLS = [
  "#{Rails.root}/db/seed_files/201132069349300318_public.xml",
  "#{Rails.root}/db/seed_files/201612429349300846_public.xml",
  "#{Rails.root}/db/seed_files/201521819349301247_public.xml",
  "#{Rails.root}/db/seed_files/201641949349301259_public.xml",
  "#{Rails.root}/db/seed_files/201921719349301032_public.xml",
  "#{Rails.root}/db/seed_files/201831309349303578_public.xml",
  "#{Rails.root}/db/seed_files/201823309349300127_public.xml",
  "#{Rails.root}/db/seed_files/201401839349300020_public.xml",
  "#{Rails.root}/db/seed_files/201522139349100402_public.xml",
  "#{Rails.root}/db/seed_files/201831359349101003_public.xml"
].freeze

parser = Nokogiri::XML::SAX::Parser.new(XmlTaxFiling.new)
FILING_URLS.each do |filename|
  parser.parse(File.open(filename))
rescue StandardError => e
  puts "Failed to parse XML file, Error: #{e.inspect}"
end

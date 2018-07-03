require 'csv'
require 'pp'

rows = CSV.read('./who-aap-database-may2016/database-Table 1.csv');

rows = rows.select { |row| row.compact.length > 0 }.drop(3)

COUNTRY = 3
PM10 = 5

module Enumerable
  def mean
    reduce(:+) / size
  end
end

pollution_by_country = rows
  .group_by { |row| row[COUNTRY] }
  .transform_values { |rows| rows.map { |row| row[PM10].to_f }.mean }

pp pollution_by_country.entries.sort_by { |row| row[1] }


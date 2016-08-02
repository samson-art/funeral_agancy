# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
  # cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

deceased_json = ActiveSupport::JSON.decode(File.read(Rails.root + 'db/deceaseds.json'))
relative_json = ActiveSupport::JSON.decode(File.read(Rails.root + 'db/relations.json'))
flowers_json = ActiveSupport::JSON.decode(File.read(Rails.root + 'db/flowers.json'))

deceased_json.each do |a|
  Deceased.create!(a)
end

relative_json.each do |a|
  Relative.create!(a)
end

flowers_json.each do |a|
  Flower.create!(a)
end

Deceased.all.each do |d|
  Relative.all.each do |r|
    if d.id == r.id
      puts "Create order:\n#{Order.create!(deceased_id: d.id, relative_id: r.id)}"
    end
  end
end
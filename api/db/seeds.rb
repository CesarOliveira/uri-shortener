puts '---Seeding database---'

puts '-Creating Link Seeds:'

link_one = Link.create(
  title: 'Title of the Page',
  identifier: 'some_cool_identifier',
  destination_url: 'https://google.com'
)

link_two = Link.create(
  title: 'Title of the Page',
  identifier: 'other_cool_identifier',
  destination_url: 'https://twitter.com'
)

puts '-Creating Hit Seeds:'

100.times do |variable|
  Hit.create(
    link: [link_one, link_two].sample,
    identifier: ['identifier_1','identifier_2','identifier_3','identifier_4','identifier_5'].sample
  )
end

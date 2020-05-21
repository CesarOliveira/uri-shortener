puts '---Seeding database---'

puts '-Creating Link Seeds:'

link = Link.create(
  title: 'Title of the Page',
  identifier: 'some_cool_identifier',
  destination_url: 'http://google.com'
)

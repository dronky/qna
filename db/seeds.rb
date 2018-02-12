# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.first
Question.create({title: 'my 1st question',body: 'hello qna', user_id: 1})
Question.create({title: 'how to install rvm',body: 'help pls', user_id: 1})
Question.create({title: 'hello world in hlasm',body: 'please give example', user_id: 1})
Question.create({title: 'stop racf',body: 'how can i stop racf in zos?', user_id: 1})
Question.create({title: 'seeds in rails', body: 'how to create seeds in rails?', user_id: 1})
Question.create({title: 'ruby hello world', body: 'how to write hello world in ruby', user_id: 1})
Question.create({title: 'Show shipping methods based on product category
', body: 'Can anyone tell me where I am going wrong?

', user_id: 1})
Question.create({title: 'How to read a specific position in a file of numbers and get the position', body: 'I have a big matrix of numbers (more than one million) in an ASCII file (.txt) from which I must extract the position of the highest number in a particular row.

Inspecting the NetLogo primitives to read data from a file I have found file-read-line. With this primitive, I have to sequentially read rows of the file to reach, first the particular row I need, save it in a list, apply max to the list and finally apply position command to find the position of the number in the list.', user_id: 1})
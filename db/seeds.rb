# Create admin user
u_admin = User.new(email: 'borza.marius98@gmail.com', password: 'marius10',
  name: 'Marius Borza', gender: 'Male', country: 'Romania', city: 'Bucharest', birthdate: Date.new(1998, 12, 16))
u_admin.add_role :admin
u_admin.save

# Create normal users
u = User.create(email: 'cristina.badic12@gmail.com', password: 'Kikirika98',
  name: 'Cristina Badic', gender: 'Female', country: 'Romania', city: 'Bucharest', birthdate: Date.new(1998, 5, 12))

# Create interests
i_art = Interest.create(name: 'Art')
i_comedy = Interest.create(name: 'Comedy')
i_crafts = Interest.create(name: 'Crafts')
i_sports = Interest.create(name: 'Sports')
i_dance = Interest.create(name: 'Dance')
i_film = Interest.create(name: 'Film')
i_theater = Interest.create(name: 'Theater')
i_food = Interest.create(name: 'Food')
i_games = Interest.create(name: 'Games')
i_health = Interest.create(name: 'Health')
i_literature = Interest.create(name: 'Literature')
i_gardening = Interest.create(name: 'Gardening')
i_shopping = Interest.create(name: 'Shopping')
i_music = Interest.create(name: 'Music')
i_party = Interest.create(name: 'Party')
i_other = Interest.create(name: 'Other')

# Subscribe users to interests
u.interests << i_art << i_crafts << i_music << i_games << i_film << i_shopping
u_admin.interests << i_games << i_music << i_sports << i_dance << i_party

# Create posts
post1 = Post.create(title: 'Games', body: 'Stuff', created_by: u_admin.id, interest_id: i_games.id)
post2 = Post.create(title: 'I like music', body: 'Nice', created_by: u.id, interest_id: i_music.id)
post3 = Post.create(title: 'Test', body: 'Testing', created_by: u_admin.id, interest_id: i_party.id)

# Create comments
comment1 = Comment.create(content: 'Comment test', created_by: u.id, post_id: post1.id)
reply1 = Comment.create(content: 'First Reply', created_by: u_admin.id, post_id: post1.id, parent_id: comment1.id)
reply2 = Comment.create(content: 'Second Reply', created_by: u.id, post_id: post1.id, parent_id: comment1.id)

comment2 = Comment.create(content: 'Commenting....', created_by: u_admin.id, post_id: post3.id)
reply3 = Comment.create(content: 'Replying....', created_by: u.id, post_id: post3.id, parent_id: comment2.id)
reply4 = Comment.create(content: 'Replying to reply', created_by: u_admin.id, post_id: post3.id, parent_id: reply3.id)

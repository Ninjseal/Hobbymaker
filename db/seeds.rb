# Import world_data.csv - Countries, Regions and Cities
Rake::Task['csv_imports:world_data'].invoke
romania = Country.where(name: "Romania").first

# Create admin user
u_admin = User.new(email: 'borza.marius98@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Marius Borza', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1998, 12, 16))
u_admin.add_role :admin
u_admin.save

# Create normal users
u = User.create(email: 'cristina.badic12@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Cristina Badic', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1998, 5, 12))

# Create Follows
Follow.create(follower_id: u.id, following_id: u_admin.id)

# Create interests
i_art = Interest.create(name: 'Art')
i_business = Interest.create(name: 'Business')
i_comedy = Interest.create(name: 'Comedy')
i_crafts = Interest.create(name: 'Crafts')
i_sports = Interest.create(name: 'Sports')
i_dance = Interest.create(name: 'Dance')
i_film = Interest.create(name: 'Film')
i_theater = Interest.create(name: 'Theater')
i_food = Interest.create(name: 'Food')
i_games = Interest.create(name: 'Games')
i_health = Interest.create(name: 'Health')
i_languages = Interest.create(name: 'Languages')
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

# Create Chat and Messages
chat1 = TwoUsersChat.create(user1_id: u.id, user2_id: u_admin.id)
m1 = Message.new(content: 'Hello', user_id: u.id)
m1.chat = chat1
m1.save

gr1 = GroupChat.create(name: 'Group Test')
gr1.users << u << u_admin
m2 = Message.new(content: 'Yo!', user_id: u_admin.id)
m2.chat = gr1
m2.save

# Create Events
e1 = Event.create(name: 'Test', description: 'Just testing', kind: Event.kinds['online'], start_date: DateTime.now, end_date: DateTime.now)
e2 = Event.create(name: 'Evento', description: 'Beep', kind: Event.kinds['online'], start_date: DateTime.now, end_date: DateTime.now)

e1.organizers << u_admin
e1.organizers << u

e2.organizers << u
e2.participants << u_admin

# Favorites
f1 = Favorite.new(user_id: u_admin.id)
f1.favorite_item = e2
f1.save

f2 = Favorite.new(user_id: u.id)
f2.favorite_item = post1
f2.save

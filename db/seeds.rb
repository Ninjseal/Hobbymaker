# Import world_data.csv - Countries, Regions and Cities
Rake::Task['csv_imports:world_data'].invoke
romania = Country.where(name: "Romania").first
bucuresti = City.where(name: "Bucuresti").first

# Create admin user
u_admin = User.new(email: 'borza.marius98@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Marius Borza', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1998, 12, 16))
u_admin.add_role :admin
u_admin.save

# Create normal users
u = User.create(email: 'cristina.badic12@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Cristina Badic', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1998, 5, 12))
u_2 = User.create(email: 'sorina.cozma@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Sorina Cozma', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1996, 3, 26))
u_3 = User.create(email: 'raluca.iliescu@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Raluca Iliescu', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1995, 8, 10))
u_4 = User.create(email: 'iulian.marcovici@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Iulian Marcovici', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1999, 10, 29))
u_5 = User.create(email: 'tiberiu.mihalache@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Tiberiu Mihalache', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1997, 1, 4))
u_6 = User.create(email: 'simona.prunea@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Simona Prunea', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1990, 12, 18))
u_7 = User.create(email: 'luiza.zamfir@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Luiza Zamfir', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1992, 9, 29))
u_8 = User.create(email: 'ionut.dimitru@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Ionut Dimitru', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1998, 8, 7))
u_9 = User.create(email: 'laurentiu.florescu@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Laurentiu Florescu', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(2000, 2, 20))
u_10 = User.create(email: 'catalin.marin@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Catalin Marin', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1994, 3, 11))
u_11 = User.create(email: 'darius.mironescu@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Darius Mironescu', gender: User.genders['male'], country_id: romania.id, birthdate: Date.new(1989, 5, 16))
u_12 = User.create(email: 'lacramioara.draghici@gmail.com', password: 'Marius10!', confirmed_at: DateTime.now,
  name: 'Lacramioara Draghici', gender: User.genders['female'], country_id: romania.id, birthdate: Date.new(1992, 11, 5))

# Create Follows
Follow.create(follower_id: u.id, following_id: u_4.id)
Follow.create(follower_id: u.id, following_id: u_10.id)
Follow.create(follower_id: u_admin.id, following_id: u.id)
Follow.create(follower_id: u_admin.id, following_id: u_10.id)
Follow.create(follower_id: u_admin.id, following_id: u_9.id)

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
i_games = Interest.create(name: 'Gaming')
i_health = Interest.create(name: 'Health')
i_languages = Interest.create(name: 'Languages')
i_literature = Interest.create(name: 'Literature')
i_gardening = Interest.create(name: 'Gardening')
i_shopping = Interest.create(name: 'Shopping')
i_music = Interest.create(name: 'Music')
i_party = Interest.create(name: 'Party')
i_other = Interest.create(name: 'Other')

# Subscribe users to interests
u.interests << i_art  << i_music << i_games << i_film << i_shopping << i_literature
u_admin.interests << i_games << i_music << i_sports << i_dance << i_party
u_4.interests << i_music << i_dance << i_party
u_10.interests << i_film << i_theater << i_literature << i_health << i_games
u_6.interests << i_food << i_health << i_music
u_9.interests << i_business << i_film

# Create posts
post1 = Post.create(title: 'How Music Can Ease Your Pain', content: 'Losing yourself in music really may help take the sting out of a root canal or other painful medical procedure -- especially if you are feeling anxious about it.In a new study, 143 people listened to music while they received a painful shock in their fingertip. Participants were asked to follow the melodies, and identify unusual tones in an effort to take their mind off the pain.It seemed to do the trick. Participants’ pain decreased as they became more and more absorbed in the tunes. Those who were the most anxious reaped the most pain-relieving benefits when they became engaged in the music.', created_by: u_4.id)
post1.interests << i_music
post2 = Post.create(title: 'Playing Video Games Is Good For Your Brain', content: 'Whether playing video games has negative effects is something that has been debated for 30 years, in much the same way that rock and roll, television, and even the novel faced much the same criticisms in their time.Purported negative effects such as addiction, increased aggression, and various health consequences such as obesity and repetitive strain injuries tend to get far more media coverage than the positives.<br/> I know from my own research examining both sides that my papers on video game addiction receive far more publicity than my research into the social benefits of, for example, playing online role-playing games.However there is now a wealth of research which shows that video games can be put to educational and therapeutic uses, as well as many studies which reveal how playing video games can improve reaction times and hand-eye co-ordination. For example, research has shown that spatial visualisation ability, such as mentally rotating and manipulating two- and three-dimensional objects, improves with video game playing.', created_by: u_10.id)
post2.interests << i_games
post2.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'video-games.jpg'))
post2.save

post3 = Post.create(title: 'Be Better at Parties', content: 'Whether you love them or hate them, parties are important. They are where people meet future business and romantic partners and friends, where small talk becomes the stuff of life. Who among us, save the most self-sufficient and confident partygoer (and who is that insufferable person, anyway?), wouldn’t like to party better? This guide will teach you how to make seamless, beautiful small talk that leads to important conversations and connections. It will ease you into mingling effortlessly, and it will even demonstrate the right way to leave (without ruining your life). Go forth and party.', created_by: u_7.id)
post3.interests << i_party
post3.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'party-photo.jpg'))
post3.save

post4 = Post.create(title: 'How to Eat Healthy', content: 'It’s a natural desire to want to eat healthy—to nourish your body with the nutrition it needs to feel good. But then actually figuring out how to eat healthy, or healthier, isn’t always so clear or intuitive. In fact, it’s really freaking confusing sometimes.First off, there are a lot of opinions and information (and misinformation) out there, so it’s hard to know what to listen to. And diet culture has skewed a lot of our thinking about what healthy eating advice should sound like—often pushing restriction and prescriptive rules that don’t take into account the personal, cultural, and socioeconomic factors that influence what a healthy diet looks like for any one individual. Connected to that is the assumption, largely fueled by fatphobia, that healthy eating is synonymous with eating to lose weight. <br/> In other words: If you’re a little lost on how to eat healthy, it’s not you. So we looked to 11 R.D.s from a variety of backgrounds, personally and professionally, for their best tips on healthy eating that are flexible and empowering, instead of rigid and punishing. They shared practical pieces of advice that can make it easier for people to enrich and diversify the nutrition in their diets and make their own delicious, satisfying meals—as well as, just as important, cultivate a more peaceful and enjoyable relationship with food and eating. Take the tips that speak to you, and add them to your very own one-of-a-kind healthy eating toolbox.', created_by: u_6.id)
post4.interests << i_food
post4.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'healthy-food.jpg'))
post4.save

post5 = Post.create(title: 'Why Do I Make Art?', content: 'I like expressing emotions—to have others feel what it is I’m feeling when I’m photographing people.<br/>Empathy is essential to portraiture. I’ve done landscapes, and I think they can be very poetic and emotional, but it’s different from the directness of photographing a person. I think photographing people is, for me, the best way to show somebody something about themselves—either the person I photograph or the person looking—that maybe they didn’t already know. Maybe it’s presumptuous, but that’s the desire. I feel like I’m attending to people when I’m photographing them, and I think I understand people better because I’ve been looking at them intensely for 40-some years.', created_by: u.id)
post5.interests << i_art
post5.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'art-photo.png'))
post5.save

post6 = Post.create(title: 'The five types of film time', content: '<strong>When studying film, there is an important distinction to be made between two dimensions of ‘story time’: the time we experience as the viewers of the film (the 2 hours we’re in a cinema, or the 10 minutes in front of a laptop, the 30 minute TV programme etc.) and the time the story itself covers (which might cover a character’s lifetime, the history of a people or country, or told in ‘real time’ - how long the story itself takes to happen).<strong><br/> Film theorist Christian Metz called it the difference between ‘the time of the thing being told, and the time of the telling.’ A focus on time in film creates opportunities for rich language learning - time in language translates into ‘tense’ and this is how we can introduce and help students learn about the past, present, and future tenses. <br/>There is a typology of the different kinds of film time, attributed to Sarah Kozloff that finds five different relationships between film time, and our time:
<br/>1. Scene – where story time is the same as real time – e.g. in soap operas, which feel like they’re playing out in real time – or a film like Victoria, which was shot and performed ‘live’ in a single take, between 5am and 7.30am early one morning in Berlin. <br/>2. Stretch – where story time stretches out real time, like in adventure film sequences of countdowns to a bomb going off – 30 seconds of countdown seems to last 2 minutes, because there’s lots of cross-cutting – to the clock, to the action, to a close-up.<br/>3. Ellipsis – where the story cuts out real time – woman gets into her car outside a building, there’s one shot of the journey, then cut to her arriving at a house. The actual journey might take 10 minutes in real time, but in the film it lasts 20 seconds.<br/>4. Summary – where real time is summarised by clock hands winding forward, or newspaper pages spinning, or the example in Notting Hill, where Hugh Grant walks up Portobello Road through winter rain, spring, summer, and autumn.<br/>5. Pause – which is in some ways the hardest type of film time to spot. Sometimes in a film, time is ‘paused’ while a voice-over updates us on the action; sometimes the opening credits show us the world of the film, but the time of story hasn’t started yet.', created_by: u_12.id)
post6.interests << i_film
post6.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'cinema.jpg'))
post6.save

post7 = Post.create(title: 'A brief history of invisibility on screen', content: 'What would you do if you could be invisible? Would this newfound power bring out the best in you, instilling you with the courage to discreetly sabotage the efforts of evildoers? Or would the ability to slip in and out of rooms unnoticed tap into darker impulses?<br/>This alluring fantasy has long been fodder for filmmakers, many of whom have taken cues from the eponymous character in H.G. Wells’ 1897 novel, <p style="text-decoration: underline;">“The Invisible Man.”</p><br/>First adapted to the screen in 1933, the invisible man (and his descendents) appeared in six films from 1933 to 1951. Now, he’ll be making his latest screen (dis)appearance in a film directed by Leigh Whannell. This iteration takes a horror-movie tack: Its protagonist, played by Elisabeth Moss, is harassed by an ex who has faked his own death. But beyond “The Invisible Man” franchise, the concept of invisibility has inspired a raft of movies over the decades.<br/>As a film professor who studies adaptations and series, I’m most interested in the versatility of these invisible characters. They can star in cautionary tales or embody underdog heroes; they can act as vessels for social critique or vehicles for masochistic power fantasies.', created_by: u_3.id)
post7.interests << i_film

# Create comments
comment1 = Comment.create(content: 'You spoke the truth.', created_by: u_4.id, post_id: post4.id)

comment2 = Comment.create(content: 'Kind of difficult for an introverted person like me.', created_by: u_11.id, post_id: post3.id)

comment3 = Comment.create(content: 'It will be fine.Just give it a shot. :)', created_by: u_7.id, post_id: post3.id)

comment4 = Comment.create(content: 'There`s more to say about it but everything is on point.', created_by: u_12.id, post_id: post7.id)

comment5 = Comment.create(content: 'Will come back with more information on this later this week. Do follow, please.', created_by: u_3.id, post_id: post7.id)

comment6 = Comment.create(content: 'I listen to music everytime I`m sad or upset and I`m feeling better in no time.', created_by: u_8.id, post_id: post1.id)


# Create Events
e1 = Event.create(name: 'Open Movie Nights', description: 'Friends, in September we are starting a new type of gatherings - movie nights.<br/>We`ll be screening inspirational, relatable movies to expand our knowledge and spark a conversation. After the movie, we`ll have a discussion on the topic and see where it leads.<br/>?Join us to meet new people without the hustle of preparing conversation topics.<br/> Learn something new and have a cozy evening surrounded by friendly people.', kind: Event.kinds['venue'], city_id: bucuresti.id, start_date: DateTime.new(2020,9,17,16,0,0), end_date: DateTime.new(2020,9,17,20,0,0))
e2 = Event.create(name: 'Mortal Combat Video Game Tournament', description: 'Who is going to be the best?', kind: Event.kinds['online'], start_date: DateTime.new(2020,9,19,18,0,0), end_date: DateTime.new(2020,9,19,23,0,0))
e3 = Event.create(name: 'K-Pop Random Play Dance', description: 'Show your moves in the first-ever K-Pop random play dance in Bucharest. Come join us and make new friends.', kind: Event.kinds['venue'], city_id: bucuresti.id,  start_date: DateTime.new(2020,9,15,9,0,0), end_date: DateTime.new(2020,9,15,11,0,0))

e1.organizers << u_3
e1.organizers << u_12

e2.organizers << u_10

e3.organizers << u

e2.thumbnail = File.open(Rails.root.join('app', 'assets', 'images', 'mortal-kombat.jpg'))
e2.save

# Favorites
f1 = Favorite.create(user_id: u_8.id, favorite_item_type: "Event", favorite_item_id: e1.id)
f2 = Favorite.create(user_id: u.id, favorite_item_type: "Post", favorite_item_id: post5.id)
f3 = Favorite.create(user_id: u_11.id, favorite_item_type: "Event", favorite_item_id: e1.id)
f4 = Favorite.create(user_id: u_9.id, favorite_item_type: "Event", favorite_item_id: e2.id)
f5 = Favorite.create(user_id: u_admin.id, favorite_item_type: "Event", favorite_item_id: e3.id)
f6 = Favorite.create(user_id: u_admin.id, favorite_item_type: "Event", favorite_item_id: e2.id)
f7 = Favorite.create(user_id: u_admin.id, favorite_item_type: "Post", favorite_item_id: post2.id)
f8 = Favorite.create(user_id: u_10.id, favorite_item_type: "Post", favorite_item_id: post4.id)

# Polls
p1 = Poll.create(user_id: u.id, question: 'Which Harry Potter movie is the best?', allow_multiple_answers: false)
op1 = PollOption.create(poll_id: p1.id, answer: 'Sorcerer`s Stone')
op2 = PollOption.create(poll_id: p1.id, answer: 'Chamber of Secrets')
op3 = PollOption.create(poll_id: p1.id, answer: 'Prisoner of Azkaban')
op4 = PollOption.create(poll_id: p1.id, answer: 'Goblet of Fire')
op5 = PollOption.create(poll_id: p1.id, answer: 'Order of the Phoenix')
op6 = PollOption.create(poll_id: p1.id, answer: 'Half-Blood Prince')
op7 = PollOption.create(poll_id: p1.id, answer: 'Deathly Hallows: Part 1')
op8 = PollOption.create(poll_id: p1.id, answer: 'Deathly Hallows: Part 2')
v1 = PollVote.create(user_id: u.id, poll_option_id: op1.id, poll_id: p1.id)
v2 = PollVote.create(user_id: u_admin.id, poll_option_id: op5.id, poll_id: p1.id)
v3 = PollVote.create(user_id: u_10.id, poll_option_id: op1.id, poll_id: p1.id)
v4 = PollVote.create(user_id: u_5.id, poll_option_id: op6.id, poll_id: p1.id)
v5 = PollVote.create(user_id: u_9.id, poll_option_id: op6.id, poll_id: p1.id)

p2 = Poll.create(user_id: u_10.id, question: 'What was the best film in 2016?', allow_multiple_answers: false)
op1 = PollOption.create(poll_id: p2.id, answer: 'Ghostbusters')
op2 = PollOption.create(poll_id: p2.id, answer: 'Deadpool')
op3 = PollOption.create(poll_id: p2.id, answer: 'Moana')
op4 = PollOption.create(poll_id: p2.id, answer: 'Zootopia')
v1 = PollVote.create(user_id: u.id, poll_option_id: op4.id, poll_id: p2.id)
v2 = PollVote.create(user_id: u_admin.id, poll_option_id: op2.id, poll_id: p2.id)
v3 = PollVote.create(user_id: u_10.id, poll_option_id: op2.id, poll_id: p2.id)
v4 = PollVote.create(user_id: u_3.id, poll_option_id: op4.id, poll_id: p2.id)
v5 = PollVote.create(user_id: u_11.id, poll_option_id: op4.id, poll_id: p2.id)
v6 = PollVote.create(user_id: u_2.id, poll_option_id: op3.id, poll_id: p2.id)

p3 = Poll.create(user_id: u_4.id, question: 'I would rather listen to Ariana Grande than Taylor Swift, Katy Perry or Selena Gomez.', allow_multiple_answers: false)
op1 = PollOption.create(poll_id: p3.id, answer: 'Agree')
op2 = PollOption.create(poll_id: p3.id, answer: 'Disagree')
v1 = PollVote.create(user_id: u.id, poll_option_id: op2.id, poll_id: p3.id)
v2 = PollVote.create(user_id: u_admin.id, poll_option_id: op2.id, poll_id: p3.id)
v3 = PollVote.create(user_id: u_7.id, poll_option_id: op2.id, poll_id: p3.id)
v4 = PollVote.create(user_id: u_5.id, poll_option_id: op1.id, poll_id: p3.id)
v5 = PollVote.create(user_id: u_4.id, poll_option_id: op1.id, poll_id: p3.id)
v6 = PollVote.create(user_id: u_8.id, poll_option_id: op2.id, poll_id: p3.id)
v7 = PollVote.create(user_id: u_9.id, poll_option_id: op2.id, poll_id: p3.id)
v8 = PollVote.create(user_id: u_6.id, poll_option_id: op2.id, poll_id: p3.id)

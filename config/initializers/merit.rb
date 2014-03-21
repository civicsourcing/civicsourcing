# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  config.current_user_method = 'current_user'
end

[{
  id: 0,
  name: "Welcome Aboard",
  description: "Joined the site",
  points: 25
}, {
  id: 1,
  name: 'Conversationalist I',
  description: 'Left 10 comments',
  points: 10
}, {
  id: 2,
  name: 'Conversationalist II',
  description: 'Left 50 comments',
  points: 20
}, {
  id: 3,
  name: 'Conversationalist III',
  description: 'Left 250 comments',
  points: 40
}, {
  id: 4,
  name: 'Conversationalist IV',
  description: 'Left 1250 comments',
  points: 80
}, {
  id: 5,
  name: 'Conversationalist V',
  description: 'Left 6250 comments',
  points: 160
}, {
  id: 6,
  name: 'Initiator',
  description: 'Started an initiative',
  points: 20
}, {
  id: 11,
  name: 'Founder',
  description: 'Founded a community',
  points: 20
}, {
  id: 16,
  name: 'Facilitator',
  description: 'Created a post',
  points: 10
}, {
  id: 21,
  name: 'Voter I',
  description: 'Cast 10 votes',
  points: 10
}, {
  id: 22,
  name: 'Voter II',
  description: 'Cast 50 votes',
  points: 20
}, {
  id: 23,
  name: 'Voter III',
  description: 'Cast 250 votes',
  points: 40
}, {
  id: 24,
  name: 'Voter IV',
  description: 'Cast 1250 votes',
  points: 80
}, {
  id: 25,
  name: 'Voter V',
  description: 'Cast 6250 votes',
  points: 160
}].each do |badge|
  Merit::Badge.create! badge
end
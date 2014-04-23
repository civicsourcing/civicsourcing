ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :enable_starttls_auto => true, # detects and uses STARTTLS
  :user_name => ENV['MANDRILL_USERNAME'],
  :password  => ENV['MANDRILL_PASSWORD'], # SMTP password is any valid API key
  :authentication => 'login', # Mandrill supports 'plain' or 'login'
  :domain => 'civicsourcing.org', # your domain to identify your server when
}

if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "civicsourcing.org"
else
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
end
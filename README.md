ShareTasker
====
Web application to share activities


## Requirement
- ruby 2.5.1
    - rails 5.2.3
- Web server (Nginx, apache, ...)
    - to serve static content and proxy
- Gmail Account
    - This app uses Gmail

## Start for Production

### On-premise
```bash
git clone git@github.com:Takuya-Sugita/sharetasker.git
cd sharetasker
bundle install --path vendor/bundle --without test development
gem install foreman
```

rename `.env.template` to `.env` , and generate a Rails Secret Key  
```bash
mv .env.template .env

# generate a Rails Secret Key
bundle exec rake secret
```

Open `.env` and modify below variable
- SECRET_KEY_BASE : Rails Secret Key which generate

below variable is about mail setting
- G_MAIL_USERNAME : Gmail Account
- G_MAIL_PASSWORD : Gmail Account password
- SITE_URL : web site URL where MissionForest can serve
- SITE_PORT : web site PORT where MissionForest can serve

## DataBase setting
```
bundle exec rake db:create 
bundle exec rake db:migrate 
```

# Authors
- Takuya Sugita
- Akira Kamiya
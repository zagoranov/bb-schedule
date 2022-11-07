# Bodybuilding diary for 'Big But Boring' programs
ruby on rails + sqlite

## Env stuff
* Interface mostly in russian, sorry.
* You should fill config/secret.yml with secret key bases
* If you want use telegtam notifications, you should fill app/controller/application_controller.rb telegram chat data in method def pontificate(mess)
* Replace my email with yours in app/mailer/mailers

## Creating DB
```console
rake db:migrate
```

## Run
```console
rails s
```

## Requires
* rails 4.2.1
* ruby 2.3.3

# Simple Sistema Medico

# Setup

* bundle install

* rails db:create

* rails db:migrate

* rails db:seed

* rails server

- Users.

* admin@domain.com , contraseña : admin123
* doctor@domain.com , contraseña : doctor123
* paciente@domain.com, contraseña : paciente123

***
Docker
***
- Create postgres container
* `docker run --name=postgres_rails -e POSTGRES_USER=clinic_development -e POSTGRES_PASSWORD=medical123 -e POSTGRES_DB=clinic_development -p 5432:5432 -d postgres`

- Build Dockerfile for medical_system
* `docker build -t medical_rails .`

- Create migration
* `docker run --rm --link=postgres_rails:db_rails -e DB_HOST=postgres_rails -e DB_USER=clinic_development -e DB_NAME=clinic_development -e DB_POSTGRES_PASSWORD=medical123 medical_rails rake db:migrate`

- Run seeds
* `docker run --rm --link=postgres_rails:db_rails -e DB_HOST=postgres_rails -e DB_USER=clinic_development -e DB_NAME=clinic_development -e DB_POSTGRES_PASSWORD=medical123 medical_rails rake db:seed`

- Create container rails
* `docker run --name=rails_medical --link=postgres_rails:db_rails -p 3000:3000 -e DB_HOST=postgres_rails -e DB_USER=clinic_development -e DB_NAME=clinic_development -e DB_POSTGRES_PASSWORD=medical123 -d medical_rails`

- Connection with postgres
* `docker run -it --rm --link postgres_rails:db_rails postgres psql -h postgres_rails -U clinic_development`

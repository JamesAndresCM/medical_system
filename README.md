# Simple Sistema Médico

### Demo
https://sistema-medico.herokuapp.com/

### Descripción 
- Sistema el cual permite agendar una cita médica seleccionando el día, la hora y la especialidad de un doctor.

### Características
- Los usuarios son registrados en el sistema solo por el administrador
- Al agendar una cita se envía un correo de confirmación
- Un doctor puede crear ficha médica
- Un doctor puede crear un historial para cada paciente
- Un doctor puede crear una prescripción médica para cada paciente
- El administrador tiene control total sobre el sistema
- Un usuario solo puede registrar una cita y revisar sus prescripciones medicas

### Adicional
- Para configurar el email se debe establecer este más su password en el archivo `config/application.yml`
y remover el comentario de la línea 55 en el archivo `app/controllers/appointments_controller.rb`

### Usuarios por defecto
- admin@domain.com , contraseña : admin123
- doctor@domain.com , contraseña : doctor123
- paciente@domain.com, contraseña : paciente123

### Instalación

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```

## Instalación mediante Docker
- Create postgres container
```bash
docker run --name=postgres_rails -e POSTGRES_USER=clinic_development -e POSTGRES_PASSWORD=medical123 -e POSTGRES_DB=clinic_development -p 5432:5432 -d postgres
```

- Build Dockerfile for medical_system
```bash
docker build -t medical_rails .
```

- Create migration
```bash
docker run --rm --link=postgres_rails:db_rails -e DB_HOST=postgres_rails -e DB_USER=clinic_development -e DB_NAME=clinic_development -e DB_POSTGRES_PASSWORD=medical123 medical_rails rake db:migrate
```

- Run seeds
```bash
docker run --rm --link=postgres_rails:db_rails -e DB_HOST=postgres_rails -e DB_USER=clinic_development -e DB_NAME=clinic_development -e DB_POSTGRES_PASSWORD=medical123 medical_rails rake db:seed
```

- Create container rails
```bash
docker run --name=rails_medical --link=postgres_rails:db_rails -p 3000:3000 -e DB_HOST=postgres_rails -e DB_USER=clinic_development -e DB_NAME=clinic_development -e DB_POSTGRES_PASSWORD=medical123 -d medical_rails
```

- Connection with postgres
```bash
docker run -it --rm --link postgres_rails:db_rails postgres psql -h postgres_rails -U clinic_development
```

### Imágenes

<img src="https://i.imgur.com/HdWrAt0.png" />
<br>
<img src="https://i.imgur.com/Yylff9d.png" />
<br>
<img src="https://i.imgur.com/crvG2XJ.png" />
<br>
<img src="https://i.imgur.com/YfUkgwH.png" />

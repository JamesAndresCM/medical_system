# Photo Album (especie de blog)

# TL;DR
Un Usuario tiene un rol, puede crear comentarios, editar perfil y otros usuarios pueden comentar publicaciones.

# Instalación
Luego de clonar el proyecto :
* cd photo_album

* bundle install

* configurar usuario y base de dato en el archivo config/database.yml , luego iniciar servicio mysql

* rails db:create

* rails db:migrate

* rails db:seed

* rails s

3 tipos de usuarios, admin, supervisor y usuario normal.

* admin@domain.com , contraseña : admin123
* supervisor@domain.com , contraseña : supervisor123
* user@domain.com, contraseña : user123


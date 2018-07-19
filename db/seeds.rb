# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

User.create!([{
               email: 'admin@domain.com',
               username: 'admin',
               password: 'admin123',
               password_confirmation: 'admin123',
               last_name: 'name',
               last_name_mother: 'less',
               phone_number: '976542378',
               rut: '6316035-0',
               role: 1
             },
              {
                email: 'paciente@domain.com',
                username: 'andres',
                password: 'paciente123',
                password_confirmation: 'paciente123',
                last_name: 'perez',
                last_name_mother: 'reyes',
                phone_number: '976542371',
                rut: '24047408-5',
                role: 0
              }])

Specialty.create!([{
                    name: 'neurologo'
                  },
                   {
                     name: 'psiquiatra'
                   },
                   {
                     name: 'psicologo'
                   },
                   {
                     name: 'obstetra'
                   },
                   {
                     name: 'pediatra'
                   },
                   {
                     name: 'oftalmologo'
                   },
                   {
                     name: 'dentista'
                   },
                   {
                     name: 'ginecologo'
                   },
                   {
                     name: 'dermatologo'
                   },
                   {
                     name: 'kinesiologo'
                   }])
Doctor.create(
  email: 'doctor@domain.com',
  username: 'juan',
  password: 'doctor123',
  password_confirmation: 'doctor123',
  last_name: 'perez',
  last_name_mother: 'villa',
  phone_number: '976542377',
  rut: '10392173-2',
  specialty_id: 1
)

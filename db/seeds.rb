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
               password_confirmation: 'admin123'
             },
              {
                email: 'supervisor@domain.com',
                username: 'supervisor',
                password: 'supervisor123',
                password_confirmation: 'supervisor123'
              },
              {
                email: 'user@domain.com',
                username: 'user',
                password: 'user123',
                password_confirmation: 'user123'
              }])

Role.find_by(user_id: 1).update(superadmin_role: true)
Role.find_by(user_id: 2).update(supervisor_role: true)

p "Created #{User.count} users"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(description: 'Inativo', value_in_cash: 0, value_in_installments: 0, allow_dependents: false)
Category.create(description: 'Dependente', value_in_cash: 0, value_in_installments: 0, allow_dependents: false)
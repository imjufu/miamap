# frozen_string_literal: true

password = 'password'

if Apartment::Tenant.current == 'public'
  unless Organization.find_by(subdomain: 'guillamap')
    organization = FactoryBot.create(:organization, name: "Guill'AMAP", subdomain: 'guillamap')
    puts "-- create an organization"
    puts "   -> name: #{organization.name}"
    puts "   -> subdomain: #{organization.subdomain}"

    Apartment::Tenant.create(organization.subdomain)
  end
else
  unless User.find_by(email: 'john@guillamap.local')
    user = FactoryBot.create(:user, email: 'john@guillamap.local', password: password)
    puts "-- create a user"
    puts "   -> email: #{user.email}"
    puts "   -> password: #{password}"
  end
end

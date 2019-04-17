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
  unless User.find_by(email: 'yoda@guillamap.local')
    user = FactoryBot.create(:user, email: 'yoda@guillamap.local', password: password, profile: Profile::ADMIN)
    puts "-- create a user"
    puts "   -> email: #{user.email}"
    puts "   -> password: #{password}"
  end

  unless Member.find_by(email_address: 'luc@guillamap.local')
    member = FactoryBot.create(:member, email_address: 'luc@guillamap.local')
    puts "-- create a member"
    puts "   -> email_address: #{member.email_address}"
  end
end

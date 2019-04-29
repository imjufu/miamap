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

  member = Member.find_by(email_address: 'luke@guillamap.local')
  unless member
    member = FactoryBot.create(:member, email_address: 'luke@guillamap.local')
    puts "-- create a member"
    puts "   -> email address: #{member.email_address}"
  end

  producer = Producer.find_by(email_address: 'obi-wan@guillamap.local')
  unless producer
    producer = FactoryBot.create(:producer, email_address: 'obi-wan@guillamap.local')
    puts "-- create a producer"
    puts "   -> email address: #{producer.email_address}"
  end

  contract = Contract.find_by(title: 'Été 2019')
  unless contract
    contract = FactoryBot.create(:contract, title: 'Été 2019')
    puts "-- create a contract"
    puts "   -> title: #{contract.title}"
  end

  unless Subscription.find_by(contract: contract, member: member)
    subscription = FactoryBot.create(:subscription, contract: contract, member: member)
    puts "-- create a subscription"
    puts "   -> member: #{subscription.member.full_name}"
    puts "   -> contract: #{subscription.contract.title}"
  end
end

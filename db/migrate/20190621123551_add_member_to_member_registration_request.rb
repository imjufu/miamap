class AddMemberToMemberRegistrationRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :member_registration_requests, :member, foreign_key: true
  end
end

# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a? User
      # A super admin can manage all ressources
      if user.admin?
        can :manage, :all
      else
        initialize_common_abilities_for_user(user)
        # ...otherwise, add permissions for each user's roles
        initialize_abilities_for_user(user)
      end
    elsif user.is_a? Member
      initialize_common_abilities_for_member(user)
    end
  end

  private

  def initialize_common_abilities_for_member(user)
    can :read, Subscription, member_id: user.id
  end

  def initialize_common_abilities_for_user(user)
    # Every logged in users...
    # ...can update its profile
    can %i[read edit update], user
  end

  def initialize_abilities_for_user(user)
    send("user_#{user.profile}_abilities", user)
  end

  def user_level_0_abilities(_user)
    can :read, :all
  end
end

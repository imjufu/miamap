# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # A super admin can manage all ressources
    if user.admin?
      can :manage, :all
    else
      initialize_common_abilities_for(user)
    end
  end

  private

  def initialize_common_abilities_for(user)
    # Every logged in users...
    # ...can update its profile
    can %i[read edit update], user
  end
end

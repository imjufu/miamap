# frozen_string_literal: true

class Profile
  ADMIN = 'administrator'
  LEVEL_0 = 'level_0'

  def initialize(profile)
    @profile = profile
  end

  def admin?
    @profile == ADMIN
  end

  def level_0?
    @profile == LEVEL_0
  end

  def to_s
    @profile
  end
end

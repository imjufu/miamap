# frozen_string_literal: true

seed_file = Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb")
load(seed_file) if seed_file.exist?

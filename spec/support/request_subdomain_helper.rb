# frozen_string_literal: true

module RequestSubdomainHelper
  def within_subdomain(subdomain)
    before { host! "#{subdomain}.miamap.test" }
    after  { host! 'www.miamap.test' }
    yield
  end
end

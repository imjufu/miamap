# frozen_string_literal: true

class ContractScrubber < Rails::Html::PermitScrubber
  def initialize
    super
    self.tags = %w[p br strong a u em ol ul li h1 h2 h3]
    self.attributes = %w[href]
  end

  def skip_node?(node)
    node.text?
  end
end

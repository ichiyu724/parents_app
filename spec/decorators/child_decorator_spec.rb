# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChildDecorator do
  let(:child) { Child.new.extend ChildDecorator }
  subject { child }
  it { should be_a Child }
end

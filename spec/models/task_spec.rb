require 'rails_helper'

RSpec.describe Task, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project).optional }
    it { should belong_to(:workspace) }
    # it { should have_many(:task_taggings) }
    # it { should have_many(:tags).through(:task_taggings) }
  end

  context "validations" do
    it { should validate_presence_of(:description) }
  end
end

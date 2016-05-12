require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validations" do
    it "should validate presence of title" do
      expect { FactoryGirl.create(:task, title: '') }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end
end

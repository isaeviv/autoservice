require 'rails_helper'

RSpec.describe ClientDecorator do
  let(:client){ create(:client) }
  subject { client.full_name_cache }
  it{ is_expected.to include client.first_name }
  it{ is_expected.to include client.second_name }
  it{ is_expected.to include client.patronymic }
  
  describe "updating" do
    before do
      client.update first_name: "Updated"
    end
    
    it{ is_expected.to include "Updated" }
    it{ is_expected.to include client.second_name }
    it{ is_expected.to include client.patronymic }
  end
end

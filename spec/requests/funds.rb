require 'spec_helper'
require 'json'

describe "Fund pages" do

  describe "root" do
    it "should have all the funds" do
      visit '/funds/index'
      # json_length
      # expect(page.body).to have_length(5)
    end
  end
  describe "necessity category" do
    it "should have some funds" do
      visit '/funds/index'
    end
  end

  def parse_body_to_json(body)
    # body.to_json
  end

end

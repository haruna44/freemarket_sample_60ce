require 'rails_helper'
describe Address do
  describe '#create' do
    it "全て入力されていればOK" do
      address = build(:address)
      expect(address).to be_valid
    end
    it "postal_codeが空ならNG" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end
    it "postal_codeが意図しない形ならNG（全角）" do
      address = build(:address, postal_code: "１１１ー１１１１")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end
    it "postal_codeが意図しない形ならNG（ハイフンなし）" do
      address = build(:address, postal_code: "1111111")
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid")
    end
    it "prefectureが空ならNG" do
      address = build(:address, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("can't be blank")
    end
    it "cityが空ならNG" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end
    it "addressが空ならNG" do
      address = build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("can't be blank")
    end
  end
end
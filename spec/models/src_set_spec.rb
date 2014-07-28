# encoding: UTF-8

describe SrcSet do
  it { should validate_presence_of :name }

  it { should belong_to :user }
  it { should have_and_belong_to_many :src_images }

  let(:set1) { FactoryGirl.create(:src_set) }

  context "determining the set's thumbnail" do

    it 'uses the most used image as the thumbnail for the set' do
      si1 = FactoryGirl.create(
          :src_image,
          src_thumb: FactoryGirl.create(:src_thumb),
          gend_images_count: 3)
      si2 = FactoryGirl.create(
          :src_image,
          src_thumb: FactoryGirl.create(:src_thumb),
          gend_images_count: 2)
      si3 = FactoryGirl.create(
          :src_image,
          src_thumb: FactoryGirl.create(:src_thumb),
          gend_images_count: 1)

      set1.src_images << si1
      set1.src_images << si2
      set1.src_images << si3

      expect(set1.thumbnail).to eq si1.src_thumb
    end

    context 'when the set is empty' do

      subject(:src_set) { FactoryGirl.create(:src_set) }

      specify { expect(src_set.thumbnail).to eq(nil) }
      specify { expect(src_set.thumb_width).to eq(nil) }
      specify { expect(src_set.thumb_height).to eq(nil) }
    end

  end

  context 'creating a new src set with the same name as an active src set' do

    it 'fails validation' do
      expect { FactoryGirl.create(:src_set, name: set1.name) }.to(
          raise_error(ActiveRecord::RecordInvalid))
    end

  end

  context 'creating a new src set with the same name as a deleted src set' do

    it 'allows the src set to be created' do
      set1.is_deleted = true
      set1.save!
      FactoryGirl.create(:src_set, name: set1.name)
    end

  end

end

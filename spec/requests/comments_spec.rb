require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:post1) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, post_id: post1.id, user_id: user.id) }
  let!(:headers) { { HTTP_REFERER: post_path(post1)} }
  
  describe "#create" do
    context "コメント成功" do
      it "正常にコメントできること" do
        expect do
          post post_comments_path(comment.post_id), params: { comment: FactoryBot.attributes_for(:comment) }
        end.to change(post1.comments, :count).by(1)
      end

      it "コメント成功後、リダイレクトするか" do
        sign_in user
        post post_comments_path(comment.post_id), params: { comment: FactoryBot.attributes_for(:comment) }, headers: headers
        expect(response).to redirect_to post_path(post1)
      end
    end
  end
end

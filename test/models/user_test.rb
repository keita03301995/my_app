require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end

  test "Userオブジェクトが正常に働いているか確認" do
    assert @user.valid?
  end

  test "空白文字列で名前を登録出来ない事の確認" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "空白文字列でメールアドレスを登録出来ない事の確認" do
    @user.email = "   "
    assert_not @user.valid?
  end

	test "51文字以上の名前を登録出来ない事の確認" do
		@user.name = "a" * 51
		assert_not @user.valid?
  end

  test "255文字以上のメールアドレスを登録出来ない事の確認" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "正しいメールアドレスが弾かれていない事の確認" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "不正なメールアドレスが弾かれている事の確認" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "同じメールアドレスが登録されていない事の確認" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "パスワードが空でない事の確認" do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end

  test "パスワードが6文字以上である事の確認" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

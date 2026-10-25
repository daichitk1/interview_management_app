require "application_system_test_case"

class InterviewsTest < ApplicationSystemTestCase
  setup do
    @interview = interviews(:one)
  end

  test "visiting the index" do
    visit interviews_url
    assert_selector "h1", text: "面接管理アプリ"
    assert_link @interview.title
  end

  test "should create interview" do
    visit interviews_url
    click_on "新規企業の面接日程追加"
    fill_in "企業名", with: "New System Company"
    fill_in "コメント", with: "Application submitted"
    click_on "決定"
    assert_text "企業名: New System Company"
    assert_text "Application submitted"
    assert_equal "document_submit", Company.find_by!(title: "New System Company").select_status
    click_on "一覧"
    assert_link "New System Company"
  end

  test "should update interview" do
    visit interview_url(@interview)
    click_on "編集", match: :first
    fill_in "コメント", with: "Updated interview notes"
    click_on "更新"
    assert_text "Updated interview notes"
    assert_equal "Updated interview notes", @interview.reload.content
    click_on "一覧"
    assert_link @interview.title
  end

  test "should destroy interview" do
    visit interview_url(@interview)
    accept_confirm do
      click_on "削除", match: :first
    end
    assert_current_path interviews_path
    assert_no_link @interview.title
    assert_not Interview.exists?(@interview.id)
    assert_not Company.exists?(title: @interview.title)
  end
end

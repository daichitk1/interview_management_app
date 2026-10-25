require "test_helper"

class InterviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interview = interviews(:one)
  end

  test "should get index" do
    get interviews_url
    assert_response :success
  end

  test "should get new" do
    get new_interview_url
    assert_response :success
  end

  test "should create interview" do
    assert_difference("Interview.count") do
      post interviews_url, params: { interview: { title: "New Company", status: "document_submit", content: "Application sent" } }
    end

    assert_redirected_to interview_url(Interview.last)
  end

  test "should show interview" do
    get interview_url(@interview)
    assert_response :success
  end

  test "should get edit" do
    get edit_interview_url(@interview)
    assert_response :success
  end

  test "should update interview" do
    patch interview_url(@interview), params: { interview: { title: @interview.title } }
    assert_redirected_to interview_url(@interview)
  end

  test "invalid update renders the edit form and history" do
    patch interview_url(@interview), params: { interview: { title: "" } }
    assert_response :unprocessable_entity
    assert_select "h2", "面接編集"
    assert_select "h4", "面接記録"
    assert_select "a[href=?]", edit_interview_path(@interview, title: @interview.title), text: "編集"
    assert_equal "Example Company One", @interview.reload.title
  end

  test "should destroy interview" do
    assert_difference("Interview.count", -1) do
      delete interview_url(@interview)
    end

    assert_redirected_to interviews_url
  end
end

require 'rails_helper'

RSpec.describe "Api::V1::TalentCourses", type: :request do
  let(:author) { create :author }
  let(:learning_path) {create :learning_path}
  let(:talent) { create :talent, author: author}
  let(:course1) { create :course, author: author, learning_path: learning_path, order: 1 }
  let(:course2) { create :course, author: author, learning_path: learning_path, order: 2 }
  let(:course3) { create :course, author: author, learning_path: learning_path, order: 3 }
  let(:params) do
    { talent_course: {
      talent_id: talent.id,
      course_id: course1.id,
      completed: false
    } }
  end
  describe 'POST talent_courses#create' do
    it 'should create new talent course with valid attributes' do
      post api_v1_talent_courses_path, params: params.to_json, headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(json['talent_id']).to eq(talent.id)
      expect(json['course_id']).to eq(course1.id)
      expect(json['completed']).to eq(false)
      
    end
  end

  describe 'PUT talent_courses#update' do
    let(:course1) { create :course, author: author, learning_path: learning_path, order: 1 }
    let(:course2) { create :course, author: author, learning_path: learning_path, order: 2 }
    let(:course3) { create :course, author: author, learning_path: learning_path, order: 3 }
    let(:talent_course) {create :talent_course, talent: talent, course: course1, completed: false}
    it 'should complete the current course' do
      update_params = { talent_course: {
        completed: true,
      } }
      create :course, author: author, learning_path: learning_path, order: 2
      create :course, author: author, learning_path: learning_path, order: 3
      put api_v1_talent_course_path(talent_course), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['completed']).to eq(true)
    end

    it 'should enroll into next course in the learning path' do
      update_params = { talent_course: {
        completed: true,
      } }
      course2 = create :course, author: author, learning_path: learning_path, order: 2
      # create :course, author: author, learning_path: learning_path, order: 3
      put api_v1_talent_course_path(talent_course), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['completed']).to eq(true)
      new_course_enrolment = TalentCourse.where(talent_id: talent.id, course_id: course2.id).limit(1).first
      expect(new_course_enrolment.course_id).to eq(course2.id)
    end

    it 'should complete the learning path if they complete the last course in the learning path' do
      update_params = { talent_course: {
        completed: true,
      } }
      
      create :talent_learning_path, talent: talent, learning_path: learning_path
      course2 = create :course, author: author, learning_path: learning_path, order: 2
      course3 = create :course, author: author, learning_path: learning_path, order: 3
      put api_v1_talent_course_path(talent_course), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
    
      second_course_enrolment = TalentCourse.where(talent_id: talent.id, course_id: course2.id).limit(1).first
      put api_v1_talent_course_path(second_course_enrolment), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      third_course_enrolment = TalentCourse.where(talent_id: talent.id, course_id: course3.id).limit(1).first
      put api_v1_talent_course_path(third_course_enrolment), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      talent_learning_path = TalentLearningPath.where(learning_path_id: learning_path.id, talent_id: talent.id).limit(1).first
      expect(talent_learning_path.completed).to eq(true)
    end
  end

end

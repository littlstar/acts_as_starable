require 'test_helper'

class ActsAsStarableTest < ActiveSupport::TestCase

  def setup
    @dom = FactoryGirl.create :dom
    @joe = FactoryGirl.create :joe
    @oar = FactoryGirl.create :oar
  end

  test 'instance methods defined' do
    assert @oar.respond_to? :starred_by?
    assert @oar.respond_to? :starings_count
    assert @oar.respond_to? :starings_scoped
    assert @oar.respond_to? :starings_by_type
    assert @oar.respond_to? :starers_by_type
    assert @oar.respond_to? :all_starings
    assert @oar.respond_to? :all_starers
    assert @oar.respond_to? :get_star_for
  end

  test 'returns starred by status' do
    @dom.star @oar
    assert @oar.starred_by? @dom
  end

  test 'returns starings count' do
    @dom.star @oar
    assert_equal 1, @oar.starings_count
  end

  test 'returns starings by type' do
    @dom.star @oar
    assert_equal [Star.first], @oar.starings_by_type('User')
    @joe.star @dom
    assert_equal [Star.last], @dom.starings_by_type('User')

    # also accepts AR options
    @joe.star @oar
    assert_equal 1, @oar.starings_by_type('User', limit: 1).count
  end

  test 'returns starers by type' do
    @dom.star @oar
    assert_equal [User.first], @oar.starers_by_type('User')

    # also accepts AR options
    @joe.star @oar
    assert_equal 1, @oar.starers_by_type('User', limit: 1).count
  end

  test 'returns all starings' do
    assert_equal [], @oar.all_starings
    @dom.star @oar
    @joe.star @oar
    assert_equal Star.all.to_a, @oar.all_starings
    
    # also accepts AR options
    assert_equal 1, @oar.all_starings(limit: 1).count
  end

  test 'returns all starers' do
    assert_equal [], @oar.all_starers
    @dom.star @oar
    @joe.star @oar
    assert_equal User.all.to_a, @oar.all_starers
    
    # also accepts AR options
    assert_equal 1, @oar.all_starers(limit: 1).count
  end

  test 'dependent destroy' do
    @dom.star @oar
    assert_difference 'Star.count', -1 do
      @dom.destroy
    end
  end

  def teardown
    User.destroy_all
    Band.destroy_all
    Star.destroy_all
  end

end

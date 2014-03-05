require 'test_helper'

class ActsAsStarerTest < ActiveSupport::TestCase

  def setup
    @dom = FactoryGirl.create :dom
    @joe = FactoryGirl.create :joe
    @oar = FactoryGirl.create :oar
    @stp = FactoryGirl.create :stp
  end

  test 'instance methods defined' do
    assert @dom.respond_to? :star
    assert @dom.respond_to? :unstar
    assert @dom.respond_to? :starred?
    assert @dom.respond_to? :stars_count
    assert @dom.respond_to? :stars_scoped
    assert @dom.respond_to? :stars_by_type
    assert @dom.respond_to? :starred_by_type
    assert @dom.respond_to? :all_stars
    assert @dom.respond_to? :all_starred
    assert @dom.respond_to? :get_star_from
  end

  test 'starring and unstarring' do

    # star
    assert_difference 'Star.count', 1 do
      @dom.star @oar
    end

    # can't star self
    assert_difference 'Star.count', 0 do
      @dom.star @dom
    end

    # unstar
    assert_difference 'Star.count', -1 do
      @dom.unstar @oar
    end

  end
  
  test 'returns starred status' do
    @dom.star @oar
    assert @dom.starred? @oar
  end

  test 'returns stars count' do
    @dom.star @oar
    assert_equal 1, @dom.stars_count
  end

  test 'returns stars by type' do
    @dom.star @oar
    assert_equal [Star.first], @dom.stars_by_type('Band')
    assert_equal [], @dom.stars_by_type('User')
    @joe.star @dom
    assert_equal [Star.last], @joe.stars_by_type('User')
    assert_equal [], @joe.stars_by_type('Band')

    # also accepts AR options
    @dom.star @stp
    assert_equal 1, @dom.stars_by_type('Band', limit: 1).count
  end

  test 'returns starred by type' do
    @dom.star @oar
    assert_equal [Band.first], @dom.starred_by_type('Band')
    @joe.star @dom
    assert_equal [User.first], @joe.starred_by_type('User')

    # also accepts AR options
    assert_equal 1, @dom.starred_by_type('Band', limit: 1).count
  end

  test 'returns all stars' do
    assert_equal [], @dom.all_stars
    @dom.star @oar
    @dom.star @stp
    @dom.star @joe
    assert_equal Star.all.to_a, @dom.all_stars
    
    # also accepts AR options
    assert_equal 1, @dom.all_stars(limit: 1).count
  end

  test 'returns all starred' do
    assert_equal [], @dom.all_starred
    @dom.star @oar
    @dom.star @stp
    @dom.star @joe
    assert_equal Band.all.to_a + [User.last], @dom.all_starred
    
    # also accepts AR options
    assert_equal 1, @dom.all_starred(limit: 1).count
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

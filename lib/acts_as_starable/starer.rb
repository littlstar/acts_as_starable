module ActsAsStarable #:nodoc:
  module Starer

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_starer
        has_many :stars, as: :starer, dependent: :destroy
        include ActsAsStarable::Starer::InstanceMethods
        include ActsAsStarable::StarerLib
      end
    end

    module InstanceMethods

      # Creates a new star record for this instance to star the passed object.
      # Does not allow duplicate records to be created.
      def star(starable)
        if self != starable
          self.stars.find_or_create_by(starable_id: starable.id, starable_type: parent_class_name(starable))
        end
      end

      # Deletes the star record if it exists.
      def unstar(starable)
        if star = get_star_from(starable)
          star.destroy
        end
      end

      # Returns true if this instance has starred the object passed as an argument.
      def starred?(starable)
        self.stars.for_starable(starable).first.present?
      end

      # Returns the number of objects this instance has starred.
      def stars_count
        self.stars.count
      end

      # returns the star records to the current instance
      def stars_scoped
        self.stars.includes(:starable)
      end

      # Returns the star records related to this instance by type.
      def stars_by_type(starable_type, options={})
        stars_scope = stars_scoped.for_starable_type(starable_type)
        stars_scope = apply_options_to_scope(stars_scope, options)
      end

      # Returns the actual records of a particular type which this record has starred.
      def starred_by_type(starable_type, options={})
        stars_by_type(starable_type, options).collect { |f| f.starable }
      end

      # Returns the star records related to this instance with the starable included.
      def all_stars(options={})
        apply_options_to_scope(stars_scoped, options)
      end

      # Returns the actual records which this instance has starred.
      def all_starred(options={})
        all_stars(options).collect { |f| f.starable }
      end

      # Returns a star record for the current instance and starable object.
      def get_star_from(starable)
        self.stars.for_starable(starable).first
      end

    end

  end
end

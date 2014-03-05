module ActsAsStarable #:nodoc:
  module Starable

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_starable
        has_many :starings, as: :starable, dependent: :destroy, class_name: 'Star'
        include ActsAsStarable::Starable::InstanceMethods
        include ActsAsStarable::StarerLib
      end
    end

    module InstanceMethods

      # Returns true if the current instance has been starred by the passed record
      def starred_by?(starer)
        self.starings.for_starer(starer).first.present?
      end

      # Returns the number of objects that have starred this instance.
      def starings_count
        self.starings.count
      end

      # returns the star records to the current instance
      def starings_scoped
        self.starings.includes(:starer)
      end

      # Returns the star records related to this instance by type.
      def starings_by_type(starer_type, options={})
        starings_scope = starings_scoped.for_starer_type(starer_type)
        starings_scope = apply_options_to_scope(starings_scope, options)
      end

      # Returns the actual records of a particular type which have starred this record.
      def starers_by_type(starer_type, options={})
        starings_by_type(starer_type, options).collect { |f| f.starer }
      end

      # Returns the star records related to this instance with the starer included.
      def all_starings(options={})
        apply_options_to_scope(starings_scoped, options)
      end

      # Returns the actual records which have starred this instance.
      def all_starers(options={})
        all_starings(options).collect { |f| f.starer }
      end

      # Returns a star record for the current instance and starer object.
      def get_star_for(starer)
        self.starings.for_starer(starer).first
      end

    end

  end
end

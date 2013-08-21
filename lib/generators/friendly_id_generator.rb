require 'rails/generators'
require "rails/generators/active_record"

# This generator adds a migration for the {FriendlyId::History
# FriendlyId::History} addon.
class FriendlyIdGenerator < ActiveRecord::Generators::Base
  # ActiveRecord::Generators::Base inherits from Rails::Generators::NamedBase which requires a NAME parameter for the
  # new table name. Our generator always uses 'friendly_id_slugs', so we just set a random name here.
  argument :name, type: :string, default: 'random_name'

  source_root File.expand_path('../../friendly_id', __FILE__)

  # Copies the migration template to db/migrate.
  def copy_files
    migration_template 'migration.rb', 'db/migrate/create_friendly_id_slugs.rb'
  end

  def create_initializer
    initializer 'friendly_id.rb' do
<<-END
# FriendlyId Global Configuration
#
# Use this to set up shared configuration options for your entire application.
#
# To learn more, check out the guide:
#
# http://rubydoc.info/github/norman/friendly_id/master/file/Guide.md

FriendlyId.defaults do |config|
  # ## Reserved Words
  #
  # Some words could conflict with Rails's routes when used as slugs, or are
  # undesirable to allow as slugs. Edit this list as needed for your app.
  config.use :reserved

  config.reserved_words = %w(new edit index session login logout users admin
    stylesheets assets javascripts images)

  #  ## Friendly Finders
  #
  # Uncomment this to use friendly finders in all models. By default, if
  # you wish to find a record by its friendly id, you must do:
  #
  #    MyModel.friendly.find('foo')
  #
  # If you uncomment this, you can do:
  #
  #    MyModel.find('foo')
  #
  # This is significantly more convenient but may not be appropriate for
  # all applications, so you must explicity opt-in to this behavior. You can
  # always also configure it on a per-model basis if you prefer.
  #
  # config.use :finders
  #
  # ## Slugs
  #
  # Most applications will use the :slugged module everywhere. If you wish
  # to do so, uncomment the following line.
  #
  # config.use :slugged
  #
  # By default, FriendlyId's :slugged addon expects the slug column to be named
  # 'slug', but you can change it if you wish.
  # config.slug_column = 'slug'
  #
  #
  #  ## Tips and Tricks
  #
  #  ### Changing when slugs are generated
  #
  # By default, new slugs are generated only when the slug field is nil, but you
  # can change this behavior by overriding the `should_generate_new_friendly_id`
  # method that FriendlyId adds to your model. You can configure this globally by
  # passing a module to the :use method. It can be a module that you declare
  # elsewhere in your application, or an anonymous one that you create on-the-fly
  # like here; it doesn't matter.
  #
  # config.use Module.new {
  #   def should_generate_new_friendly_id?
  #     slug.blank? || name_changed?
  #   end
  # }
  #
  #
  # By default FriendlyId uses Rails's `parameterize` method, but for languages
  # that don't use the Roman alphabet, that's not usually suffient. Here we use
  # the Babosa library to transliterate Russian Cyrillic slugs to ASCII:
  #
  # require 'babosa'
  #
  # config.use Module.new {
  #   def normalize_friendly_id(text)
  #     text.to_slug.normalize! :transliterations => [:russian, :latin]
  #   end
  # }
end
END
    end
  end
end
